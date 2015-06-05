//
//  AddContactViewController.m
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/22/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "AddContactViewController.h"

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    NSDictionary *dict = @{@"FirstName": _firstNameField.text, @"LastName": _lastNameField.text, @"Phone": _phoneField.text, @"Username": _user};
    // Attention! Delegates(listeners) of the AddContactDelegate protocol, we are notifying you that a new contact has been added for this user.
    [self.delegate addContact:dict];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
