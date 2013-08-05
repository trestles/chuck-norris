//
//  IAViewController.h
//  ChuckNorrisRater
//
//  Created by jonathan twaddell on 8/5/13.
//  Copyright (c) 2013 Trestles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IAViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *jokeLabel;
- (IBAction)thumbUp:(id)sender;
- (IBAction)thumbDown:(id)sender;

@end
