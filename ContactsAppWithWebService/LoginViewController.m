//
//  ViewController.m
//  UserManagementExample
//
//  Created by Joffrey Mann on 5/26/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) JMLoginModel *model;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _model = [JMLoginModel createGlobalLogin];
    _model.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginToWebService:(id)sender {
    
    [_model postUserInfo:[self returnNewUserObject]];
    [self resignKeyboard];
}

- (IBAction)registerAsUser:(id)sender {
    [self performSegueWithIdentifier:@"toRegister" sender:self];
}

-(void)resignKeyboard
{
    [_userField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

-(JMContactUser *)returnNewUserObject
{
    JMContactUser *userObject = [JMContactUser getUserObject];
    userObject.username = self.userField.text;
    userObject.password = self.passwordField.text;
    
    return userObject;
}

-(void)checkLogin
{
    NSString *responseText = [[NSString alloc] initWithData:self.model.retrievedData encoding:NSUTF8StringEncoding];
    NSLog(@"response=%@",responseText);
    
    if ([responseText containsString:@"Welcome To Contacts"]) {
        //Open the wall
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully logged in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //self.userField.text = nil;
        //self.passwordField.text = nil;
        [self performSegueWithIdentifier:@"toContacts"sender:self];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:responseText delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"toContacts"])
    {
        ContactListViewController *clvc = (ContactListViewController *)segue.destinationViewController;
        clvc.user = [self returnNewUserObject];
    }
}
@end
