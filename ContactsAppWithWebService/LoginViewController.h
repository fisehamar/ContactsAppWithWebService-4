//
//  ViewController.h
//  UserManagementExample
//
//  Created by Joffrey Mann on 5/26/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMLoginModel.h"
#import "ContactListViewController.h"

@interface LoginViewController : UIViewController<JMLoginModelDelegate,UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *userField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginToWebService:(id)sender;
- (IBAction)registerAsUser:(id)sender;
@end

