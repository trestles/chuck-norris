//
//  IAHTTPCommunication.m
//  ChuckNorrisRater
//
//  Created by jonathan twaddell on 8/5/13.
//  Copyright (c) 2013 Trestles. All rights reserved.
//

#import "IAHTTPCommunication.h"

@interface IAHTTPCommunication () {
    NSMutableData *receivedData;
}

@property (nonatomic, copy) void (^successBlock) (NSData *);

@end

@implementation IAHTTPCommunication

-(void) retrieveURL:(NSURL *)url successBlock:(void (^)(NSData *)) successBlock
{
    //NSLog(@"at top of retrieveURL");
    // 
    self.successBlock=successBlock;
    receivedData = [NSMutableData data];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [urlConnection start];
}

-(void)postURL:(NSURL *)url params:(NSDictionary *)params successBlock:(void (^)(NSData *))successBlock
{
    self.successBlock=successBlock;
    receivedData=[NSMutableData data];
    
    NSMutableArray *parametersArray=[NSMutableArray arrayWithCapacity:[params count]];
    
    for (NSString *key in params){
        [parametersArray addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    
    NSString *postBodyString=[parametersArray componentsJoinedByString:@"&"];
    NSData *postBodyData = [NSData dataWithBytes:[postBodyString UTF8String] length:[postBodyString length]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postBodyData];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [urlConnection start];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"didRecieveData");
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"didRecieveResponse");
    [receivedData setLength:0];
}

-(void)connectionDidFinishLoading: (NSURLConnection *) connection
{
    //NSLog(@"connectionDidFisnishLoading");
    self.successBlock(receivedData);
}

@end
