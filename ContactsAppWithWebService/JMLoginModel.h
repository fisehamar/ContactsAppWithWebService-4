//
//  JMLoginModel.h
//  HomePlaces
//
//  Created by Joffrey Mann on 11/14/14.
//  Copyright (c) 2014 JoffreyMann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMContactUser.h"

@protocol JMLoginModelDelegate <NSObject>

-(void)checkLogin;

@end

@interface JMLoginModel : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

-(void)postUserInfo:(JMContactUser *)user;

@property (weak, nonatomic) id <JMLoginModelDelegate> delegate;
@property (strong, nonatomic) NSMutableData *retrievedData;

+(JMLoginModel *)createGlobalLogin;

@end
