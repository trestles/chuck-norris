//
//  IAViewController.m
//  ChuckNorrisRater
//
//  Created by jonathan twaddell on 8/5/13.
//  Copyright (c) 2013 Trestles. All rights reserved.
//

#import "IAViewController.h"
#import "IAHTTPCommunication.h"

@interface IAViewController () {
    NSNumber *jokeID;
}

@end

@implementation IAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self retrieveRandomJokes:self];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)retrieveRandomJokes:(id)sender
{
    IAHTTPCommunication *http=[[IAHTTPCommunication alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://api.icndb.com/jokes/random"];
    [http retrieveURL:url successBlock:^(NSData *response) {
        NSError *error=nil;
        NSDictionary *data=[NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        if(!error)
        {
            NSDictionary *value=data[@"value"];
            if (value && value[@"joke"])
            {
                jokeID=value[@"id"];
                [self.jokeLabel setText:value[@"joke"]];
            }
        }
    }];
}

-(IBAction)thumbUp:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://example.com/rater/vote"];
    IAHTTPCommunication *http=[[IAHTTPCommunication alloc] init];
    NSDictionary *params= @{@"joke_id":jokeID, @"vote":@(1)};
    [http postURL:url params:params successBlock:^(NSData *response) {
        NSString* dataStr = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];

        NSLog(@"Voted Up %@", dataStr);
    }];
}


-(IBAction)thumbDown:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://example.com/rater/vote"];
    IAHTTPCommunication *http=[[IAHTTPCommunication alloc] init];
    NSDictionary *params= @{@"joke_id":jokeID, @"vote":@(-1)};
    [http postURL:url params:params successBlock:^(NSData *response) {
        NSString* dataStr = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];
        
        NSLog(@"Voted Up %@", dataStr);
    }];
}
@end
