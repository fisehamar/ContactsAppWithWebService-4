//
//  Contact.h
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/21/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject


@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phone;

-(id)initWithContactDict:(NSDictionary *)contactDict;

@end
