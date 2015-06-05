//
//  JMLocationUser.h
//  HomePlaces
//
//  Created by Joffrey Mann on 11/12/14.
//  Copyright (c) 2014 JoffreyMann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMContactUser : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *confirmPassword;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign) int userID;

-(instancetype)initWithUsername:(NSDictionary *)user;
+ (instancetype)registerWithUser:( NSDictionary *)user;
+(JMContactUser *)getUserObject;
@end
