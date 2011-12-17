//
//  MainViewController.h
//  Vigenere
//
//  Created by Ludger Heide on 06.11.11.
//  Copyright (c) 2011 Ludger Heide. All rights reserved.
//
//DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
//Version 2, December 2004
//
//Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
//
//Everyone is permitted to copy and distribute verbatim or modified
//copies of this license document, and changing it is allowed as long
//as the name is changed.
//
//DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
//TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
//
//0. You just DO WHAT THE FUCK YOU WANT TO.

#import "FlipsideViewController.h"
@class Vigenere;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (strong) Vigenere *vigenere;
@property NSInteger mode;
@property CGRect fullSize;
@property CGRect reducedSize;

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
