//
//  FlipsideViewController.h
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

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController <UITextFieldDelegate>

@property short firstChar;
@property short lastChar;
@property short unknownChar;

@property (unsafe_unretained, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;
@property (unsafe_unretained, nonatomic) IBOutlet UISlider *slFirstChar;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *tfFirstChar;
@property (unsafe_unretained, nonatomic) IBOutlet UISlider *slLastChar;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *tfLastChar;
@property (unsafe_unretained, nonatomic) IBOutlet UISlider *slUnknownChar;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *tfUnknownChar;
@property (unsafe_unretained, nonatomic) IBOutlet UISwitch *swUpperCase;
@property (unsafe_unretained, nonatomic) IBOutlet UISwitch *swLowerCase;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)textfieldChanged:(id)sender;
- (IBAction)switchChanged:(id)sender;
- (IBAction)done:(id)sender;

-(void)setFirstCharAndSlider:(short)fChar;
-(void)setLastCharAndSlider:(short)lChar;
-(void)setUnknownCharAndSlider:(short)uChar;

@end
