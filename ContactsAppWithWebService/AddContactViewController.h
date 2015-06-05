//
//  AddContactViewController.h
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/22/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddContactDelegate.h"
#import "JMContactUser.h"

@interface AddContactViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;

@property (strong, nonatomic) JMContactUser *user;

@property (weak, nonatomic) id <AddContactDelegate> delegate;

- (IBAction)goBack:(id)sender;
- (IBAction)done:(id)sender;

@end
