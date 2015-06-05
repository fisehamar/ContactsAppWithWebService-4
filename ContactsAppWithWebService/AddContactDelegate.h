//
//  AddContactDelegate.h
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/22/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddContactDelegate <NSObject>

-(void)addContact:(NSDictionary *)contactDict;

@end
