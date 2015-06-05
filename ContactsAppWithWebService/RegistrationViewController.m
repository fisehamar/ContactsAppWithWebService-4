//
//  RegistrationViewController.m
//  UserManagementExample
//
//  Created by Joffrey Mann on 5/26/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@property (strong, nonatomic) NSMutableData *retrievedData;

@end

@implementation RegistrationViewController
NSString *responseText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    self.retrievedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [self.retrievedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self checkRegistration];
}

-(void)checkRegistration
{
    responseText = [[NSString alloc] initWithData:self.retrievedData encoding:NSUTF8StringEncoding];
    NSLog(@"response=%@",responseText);
    if ([responseText isEqualToString:@"You have successfully created a new account"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Congratulations, your new account has been created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:responseText delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(JMContactUser *)returnNewUserObject
{
    JMContactUser *userObject = [[JMContactUser alloc]init];
    userObject.username = self.userField.text;
    userObject.password = self.passField.text;
    userObject.confirmPassword = self.confirmPassField.text;
    userObject.email = self.emailField.text;
    userObject.firstName = self.firstNameField.text;
    userObject.lastName = self.lastNameField.text;
    
    return userObject;
}

- (IBAction)registerUser:(id)sender {
    JMContactUser *user = [self returnNewUserObject];
    
    NSString *postString = [NSString stringWithFormat:@"FirstName=%@&LastName=%@&Username=%@&Password=%@&PasswordConfirmation=%@&Email=%@", user.firstName, user.lastName, user.username, user.password, user.confirmPassword, user.email];
    //convert object to data
    NSData* data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create an instance of NSMutableURLRequest before setting the URL to my desired URL.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    // Set url by calling URLWithString passing in my url string as my argument
    [request setURL:[NSURL URLWithString:@"http://localhost/ContactRegister.php"]];
    // Set the HTTPMethod to Post
    [request setHTTPMethod:@"POST"];
    // Set the content type to Form Data
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [data length]] forHTTPHeaderField:@"Content-Length"];
    // Set the HTTP body to my jsonData object
    [request setHTTPBody:data];
    
    // print json:
    NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:data
                                                     encoding:NSUTF8StringEncoding]);
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}
@end
