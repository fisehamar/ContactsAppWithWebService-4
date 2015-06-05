//
//  ContactListViewController.m
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/22/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "ContactListViewController.h"

@interface ContactListViewController ()

@property (strong, nonatomic) ContactParser *contactParser;

@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self refreshData];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

-(void)refreshData
{
    _contacts = [[NSMutableArray alloc]init];
    
    _contactParser = [[ContactParser alloc]init];
    [_contactParser sendContactRequest:_user];
    _contactParser.delegate = self;
}

-(void)parseJSONWithData:(NSData *)data
{
    //Here's where you parse your JSON.
    id immutableContacts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if([immutableContacts isKindOfClass:[NSArray class]])
    {
        for(NSDictionary *contactDict in immutableContacts)
        {
            Contact *contactToAdd = [[Contact alloc]initWithContactDict:contactDict];
            [_contacts addObject:contactToAdd];
        }
    }
    
    else if([immutableContacts isKindOfClass:[NSDictionary class]])
    {
        NSArray *contactArray = immutableContacts[@"Contacts"];
        
        for(NSDictionary *dict in contactArray)
        {
            Contact *contactToAdd = [[Contact alloc]initWithContactDict:dict];
            [_contacts addObject:contactToAdd];
        }
    }
    
        [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_contacts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Contact *contact = _contacts[indexPath.row];
    
    cell.textLabel.text = contact.firstName;
    cell.detailTextLabel.text = contact.lastName;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)addContact:(NSDictionary *)contactDict
{
    // Note that the URL is the "action" URL parameter from the form.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/contactsInsert.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    //this is hard coded based on your suggested values, obviously you'd probably need to make this more dynamic based on your application's specific data to send
    NSString *firstName = contactDict[@"FirstName"];
    NSString *lastName = contactDict[@"LastName"];
    NSString *phone = contactDict[@"Phone"];
    
    NSString *postString = [NSString stringWithFormat:@"FirstName=%@&LastName=%@&Phone=%@&Username=%@", firstName, lastName, phone, _user.username];
    NSLog(@"%@", postString);
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self refreshData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AddContactViewController *acvc = (AddContactViewController *)segue.destinationViewController;
    acvc.user = _user;
    acvc.delegate = self;
}


@end
