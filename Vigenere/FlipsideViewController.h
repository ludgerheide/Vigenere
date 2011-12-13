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
