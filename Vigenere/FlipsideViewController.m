//
//  FlipsideViewController.m
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

#define FIRST_PRINTABLE 33
#define LAST_PRINTABLE 126

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize firstChar;
@synthesize lastChar;
@synthesize unknownChar;

@synthesize delegate = _delegate;
@synthesize slFirstChar;
@synthesize tfFirstChar;
@synthesize slLastChar;
@synthesize tfLastChar;
@synthesize slUnknownChar;
@synthesize tfUnknownChar;
@synthesize swUpperCase;
@synthesize swLowerCase;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSlFirstChar:nil];
    [self setSlLastChar:nil];
    [self setSlUnknownChar:nil];
    [self setTfFirstChar:nil];
    [self setTfLastChar:nil];
    [self setTfUnknownChar:nil];
    [self setSwUpperCase:nil];
    [self setSwLowerCase:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    //Initialize the text fields and sliders
    slFirstChar.value = firstChar;
    slLastChar.value = lastChar;
    slUnknownChar.value = unknownChar;
    
    tfFirstChar.text = [NSString stringWithFormat: @"%c", firstChar];
    tfLastChar.text = [NSString stringWithFormat: @"%c", lastChar];
    tfUnknownChar.text = [NSString stringWithFormat: @"%c", unknownChar];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        //Enable the text fields since they don't obscure the keyboard anymore
        tfFirstChar.enabled = YES;
        tfLastChar.enabled = YES;
        tfUnknownChar.enabled = YES;
        
        //Make the text black to tell the user
        tfFirstChar.textColor = [UIColor blackColor];
        tfLastChar.textColor = [UIColor blackColor];
        tfUnknownChar.textColor = [UIColor blackColor];
    }
    else
    {
        //Disable the text fields since they will be obscured (a scroll view would be nicer)
        tfFirstChar.enabled = NO;
        tfLastChar.enabled = NO;
        tfUnknownChar.enabled = NO;
        
        //Grey them out to tell the user
        tfFirstChar.textColor = [UIColor grayColor];
        tfLastChar.textColor = [UIColor grayColor];
        tfUnknownChar.textColor = [UIColor grayColor];
    }

    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

//Methods to set the characters while keeping the constraints valid, automatically setting sliders and so on
-(void)setFirstCharAndSlider:(short)fChar
{
    firstChar = fChar;
    tfFirstChar.text = [NSString stringWithFormat: @"%c", firstChar];
    slFirstChar.value = firstChar;
    
    //If the first character is higher than the last, adjust the last character
    if(firstChar > lastChar)
        [self setLastCharAndSlider: firstChar];
    
    //If the unknown caracter is out of bounds now, adjust it
    if(unknownChar < firstChar)
        [self setUnknownCharAndSlider: firstChar];
}

-(void)setLastCharAndSlider:(short)lChar
{
    lastChar = lChar;
    tfLastChar.text = [NSString stringWithFormat: @"%c", lastChar];
    slLastChar.value = lastChar;
    
    //If the last character is lower than the first, adjust the first character
    if(lastChar < firstChar)
        [self setFirstCharAndSlider: lastChar];
    
    //If the unknown caracter is out of bounds now, adjust it
    if(unknownChar > lastChar)
        [self setUnknownCharAndSlider: lastChar];
}

-(void)setUnknownCharAndSlider:(short)uChar
{
    unknownChar = uChar;
    tfUnknownChar.text = [NSString stringWithFormat: @"%c", unknownChar];
    slUnknownChar.value = unknownChar;
    
    //If the unknown character is outside the current range, adjust first or last character
    if(unknownChar > lastChar)
        [self setLastCharAndSlider: unknownChar];
    else if(unknownChar < firstChar)
        [self setFirstCharAndSlider: unknownChar];
}

//Method to close the keyboard on return keypress
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)sliderChanged:(id)sender
{
    //Set the variable and update the view
    if(sender == slFirstChar)
        [self setFirstCharAndSlider: slFirstChar.value];
    else if(sender == slLastChar)
        [self setLastCharAndSlider: slLastChar.value];
    else if(sender == slUnknownChar)
        [self setUnknownCharAndSlider: slUnknownChar.value];
}

- (IBAction)textfieldChanged:(id)sender
{
    //Check for validity, set the variable and update the view
    short tempChar;
    UIAlertView *invalidCharAlert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Invalid character!", nil)
                                                               message: NSLocalizedString(@"Only printable ASCII characters are allowed.", nil)
                                                              delegate: nil
                                                     cancelButtonTitle: NSLocalizedString(@"Go back", nil)
                                                     otherButtonTitles: nil];
    
    if(sender == tfFirstChar)
    {
        //Check if the string is not empty
        if(![tfFirstChar.text isEqualToString: @""])
        {
            tempChar = [tfFirstChar.text characterAtIndex: 0];
            //Check if it is inside the allowed range, if yes set it and return;
            if(tempChar >= FIRST_PRINTABLE && tempChar <= LAST_PRINTABLE)
                [self setFirstCharAndSlider: tempChar];
            else
                [invalidCharAlert show];
        }
        else
            [invalidCharAlert show];
    }
    else if(sender == tfLastChar)
    {
        //Check if the string is not empty
        if(![tfLastChar.text isEqualToString: @""])
        {
            tempChar = [tfLastChar.text characterAtIndex: 0];
            //Check if it is inside the allowed range, if yes set it and return;
            if(tempChar >= FIRST_PRINTABLE && tempChar <= LAST_PRINTABLE)
                [self setLastCharAndSlider: tempChar];
            else
                [invalidCharAlert show];
        }
        else
            [invalidCharAlert show];
    }
    else if(sender == tfUnknownChar)
    {
        //Check if the string is not empty
        if(![tfUnknownChar.text isEqualToString: @""])
        {
            tempChar = [tfUnknownChar.text characterAtIndex: 0];
            //Check if it is inside the allowed range, if yes set it and return;
            if(tempChar >= FIRST_PRINTABLE && tempChar <= LAST_PRINTABLE)
                [self setUnknownCharAndSlider: tempChar];
            else
                [invalidCharAlert show];
        }
        else
            [invalidCharAlert show];
    }
}

- (IBAction)switchChanged:(id)sender
{
    if(sender == swUpperCase)
        swLowerCase.on = NO;
    else if(sender == swLowerCase)
        swUpperCase.on = NO;
}

- (IBAction)done:(id)sender
{
    if((tfFirstChar.isFirstResponder) || (tfLastChar.isFirstResponder) || (tfUnknownChar.isFirstResponder))
    {
        [tfFirstChar resignFirstResponder];
        [tfLastChar resignFirstResponder];
        [tfUnknownChar resignFirstResponder];
    }
    else
        [self.delegate flipsideViewControllerDidFinish:self];
}

@end
