//
//  ContactParser.m
//  ContactsAppWithWebService
//
//  Created by Joffrey Mann on 5/21/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "ContactParser.h"

@interface ContactParser ()

@property (strong, nonatomic) NSMutableData *jsonData;

@property (strong, nonatomic) NSURLConnection *contactConnection;

@end

@implementation ContactParser

-(void)sendContactRequest:(JMContactUser *)user
{
    NSString *contactURLString = [NSString stringWithFormat:@"http://localhost/contacts.php?Username=%@", user.username];
    NSLog(@"%@", contactURLString);
    NSURL *contactURL = [NSURL URLWithString:contactURLString];
    NSURLRequest *contactRequest = [NSURLRequest requestWithURL:contactURL];
    _contactConnection = [NSURLConnection connectionWithRequest:contactRequest delegate:self];
    // Create NSURLConnection using alloc and initWithRequest.
    //_contactConnection = [[NSURLConnection alloc]initWithRequest:contactRequest delegate:self];
}

#pragma mark - NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse from server");
    _jsonData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_jsonData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate parseJSONWithData:_jsonData];
}


@end
