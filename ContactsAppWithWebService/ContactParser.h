//
//  ContactParser.h
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/21/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactParserDelegate.h"
#import "JMContactUser.h"

@interface ContactParser : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) id <ContactParserDelegate> delegate;

-(void)sendContactRequest:(JMContactUser *)user;

@end
