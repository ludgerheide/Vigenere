//
//  FlipsideViewController.h
//  Vigenere
//
//  Created by Ludger Heide on 06.11.11.
//  Copyright (c) 2011 Ludger Heide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (unsafe_unretained, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
