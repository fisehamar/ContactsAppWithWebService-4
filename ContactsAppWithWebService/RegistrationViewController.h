//
//  RegistrationViewController.h
//  UserManagementExample
//
//  Created by Joffrey Mann on 5/26/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMContactUser.h"

@interface RegistrationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *userField;
@property (strong, nonatomic) IBOutlet UITextField *passField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)registerUser:(id)sender;
@end
