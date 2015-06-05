//
//  JMLoginModel.m
//  HomePlaces
//
//  Created by Joffrey Mann on 11/14/14.
//  Copyright (c) 2014 JoffreyMann. All rights reserved.
//

#import "JMLoginModel.h"

@implementation JMLoginModel

static JMLoginModel *staticModel;

+(JMLoginModel *)createGlobalLogin
{
    if(staticModel == nil)
    {
        staticModel = [[super alloc]init];
    }
    
    return staticModel;
}

-(void)postUserInfo:(JMContactUser *)user
{
    // Create a dictionary with key-value pairs that I will post as JSON.
    //NSDictionary *newDatasetInfo = [NSDictionary dictionaryWithObjectsAndKeys:user.username, @"Username", user.password, @"Password", nil];
    NSError *error;
    NSString *postString = [NSString stringWithFormat:@"Username=%@&Password=%@", user.username, user.password];
    //convert object to data
    NSData* data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create an instance of NSMutableURLRequest before setting the URL to my desired URL.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    // Set url by calling URLWithString passing in my url string as my argument
    [request setURL:[NSURL URLWithString:@"http://localhost/ContactUsers.php"]];
    // Set the HTTPMethod to Post
    [request setHTTPMethod:@"POST"];
    // Set the content type to JSON
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
    // Set the HTTP body to my jsonData object
    [request setHTTPBody:data];
    
    // print json:
    NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:data
                                                     encoding:NSUTF8StringEncoding]);
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    self.retrievedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [self.retrievedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate checkLogin];
}

@end
