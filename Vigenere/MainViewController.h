//
//  MainViewController.h
//  Vigenere
//
//  Created by Ludger Heide on 06.11.11.
//  Copyright (c) 2011 Ludger Heide. All rights reserved.
//

#import "FlipsideViewController.h"
@class Vigenere;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (strong) Vigenere *vigenere;
@property NSInteger mode;

@property (unsafe_unretained, nonatomic) IBOutlet UITextView *tvText;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *tfKey;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *buProcess;
@property (unsafe_unretained, nonatomic) IBOutlet UISegmentedControl *scMode;

- (IBAction)showInfo:(id)sender;
- (IBAction)process:(id)sender;
- (IBAction)changeMode:(id)sender;

@end
