//
//  ContactListViewController.h
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/22/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "ContactParser.h"
#import "ContactParserDelegate.h"
#import "AddContactViewController.h"
#import "AddContactDelegate.h"
#import "JMContactUser.h"

@interface ContactListViewController : UITableViewController<ContactParserDelegate, AddContactDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSMutableArray *contacts;

@property (strong, nonatomic) JMContactUser *user;

@end
