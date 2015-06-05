//
//  JMLocationUser.m
//  HomePlaces
//
//  Created by Joffrey Mann on 11/12/14.
//  Copyright (c) 2014 JoffreyMann. All rights reserved.
//

#import "JMContactUser.h"

@implementation JMContactUser

static JMContactUser *singleInstance;

+(JMContactUser *)getUserObject
{
    if(singleInstance == nil){
        singleInstance = [[super alloc]init];
    }
    return  singleInstance;
}

@end
