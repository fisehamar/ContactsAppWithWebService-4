//
//  ContactParserDelegate.h
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/21/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContactParserDelegate <NSObject>

-(void)parseJSONWithData:(NSData *)data;

@end
