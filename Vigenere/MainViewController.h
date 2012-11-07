//
//  MainViewController.h
//  Vigenere
//
//  Created by Ludger Heide on 06.11.11.
//  Copyright 2012 Ludger Heide.
/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */

#import "FlipsideViewController.h"
@class Vigenere;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (strong) Vigenere *vigenere;
@property NSInteger mode;
@property CGRect fullSize;
@property CGRect reducedSize;
@property CGRect screenSize;

@property BOOL upperCase;
@property BOOL lowerCase;

@property (unsafe_unretained, nonatomic) IBOutlet UITextView *tvText;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *tfKey;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *buProcess;
@property (unsafe_unretained, nonatomic) IBOutlet UISegmentedControl *scMode;

- (IBAction)showInfo:(id)sender;
- (IBAction)process:(id)sender;
- (IBAction)changeMode:(id)sender;

@end
