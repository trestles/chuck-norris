//
//  IAHTTPCommunication.h
//  ChuckNorrisRater
//
//  Created by jonathan twaddell on 8/5/13.
//  Copyright (c) 2013 Trestles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAHTTPCommunication : NSObject <NSURLConnectionDelegate>

-(void)retrieveURL:(NSURL *)url successBlock:(void (^)(NSData *))successBlock;
-(void)postURL:(NSURL *)url params:(NSDictionary *)params successBlock:(void (^)(NSData *))successBlock;

@end
