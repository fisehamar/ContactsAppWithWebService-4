//
//  Contact.m
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/21/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(id)initWithContactDict:(NSDictionary *)contactDict
{
    self = [super init];
    
    if(self)
    {
        _firstName = contactDict[@"FirstName"];
        //_firstName = [contactDict objectForKey:@"FirstName"];
        _lastName = contactDict[@"LastName"];
        //_lastName = [contactDict objectForKey:@"LastName"];
        _phone = contactDict[@"Phone"];
        //_phone = [contactDict objectForKey:@"Phone"];
    }
    
    return self;
}

-(id)init
{
    return [self initWithContactDict:nil];
}

@end
