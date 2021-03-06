//
//  MainViewController.m
//  Vigenere
//
//  Created by Ludger Heide on 06.11.11.
//  Copyright 2012 Ludger Heide.
/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */

#import "Vigenere.h"
#import "MainViewController.h"

@implementation MainViewController

@synthesize vigenere;
@synthesize mode;
@synthesize fullSize;
@synthesize reducedSize;
@synthesize screenSize;

@synthesize upperCase;
@synthesize lowerCase;

@synthesize tvText;
@synthesize tfKey;
@synthesize buProcess;
@synthesize scMode;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Load the characters from our preferences
    short firstChar, lastChar, unknownChar;
    
    firstChar = [[[NSUserDefaults standardUserDefaults] objectForKey: @"firstChar"] shortValue];
    lastChar = [[[NSUserDefaults standardUserDefaults] objectForKey: @"lastChar"] shortValue];
    unknownChar = [[[NSUserDefaults standardUserDefaults] objectForKey: @"unknownChar"] shortValue];
    
    //Load the conversion to upper/lowercase presets
    upperCase = [[[NSUserDefaults standardUserDefaults] objectForKey: @"upperCase"] boolValue];
    lowerCase = [[[NSUserDefaults standardUserDefaults] objectForKey: @"lowerCase"] boolValue];
    
    //Initialize vigenere with them
    vigenere = [[Vigenere alloc] initWithfirstChar: firstChar lastChar: lastChar unknownChar: unknownChar];
    
    //Initialize the text field by obsercing the keyboard size
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self updateTextViewSizes: 0];
    [tvText setFrame: fullSize];
}

- (void)viewDidUnload
{
    [self setTfKey:nil];
    [self setBuProcess:nil];
    [self setTvText:nil];
    [self setVigenere: nil];
    [self setScMode:nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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

- (void)updateTextViewSizes: (int) keyboardSize
{
    screenSize = [[UIScreen mainScreen] bounds];
    //Somehow iOS doesn't echange width and height when we rotate, so I have do do it manually
    //Also, we have to compensate for different keyboard sizes
    int keyBoardCompensation = keyboardSize + 78;
    if ([self interfaceOrientation] == UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation] == UIInterfaceOrientationLandscapeRight)
    {
        CGFloat temp = screenSize.size.height;
        screenSize.size.height = screenSize.size.width;
        screenSize.size.width = temp;
    }
    fullSize = CGRectMake(screenSize.origin.x, (screenSize.origin.y + 57), screenSize.size.width, (screenSize.size.height - 136));
    reducedSize = CGRectMake(screenSize.origin.x, (screenSize.origin.y + 57), screenSize.size.width, (screenSize.size.height - keyBoardCompensation));
}

- (void) keyboardDidShow:(NSNotification*)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"keyboard frame raw %@", NSStringFromCGRect(keyboardFrame));
    if ([self interfaceOrientation] == UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation] == UIInterfaceOrientationLandscapeRight)
        [self updateTextViewSizes: keyboardFrame.size.width];
    else
        [self updateTextViewSizes: keyboardFrame.size.height];
    [tvText setFrame: reducedSize];
}

- (void) keyboardDidHide:(NSNotification*)notification {
    [tvText setFrame: fullSize];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown)
        {
        //[self didRotateFromInterfaceOrientation: interfaceOrientation];
        return YES;
        }
    else
        return NO;
}

//Autorotate Code for iOS 6
- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self updateTextViewSizes: 0];
    if([tvText isFirstResponder])
        [tvText setFrame: reducedSize];
    else
        [tvText setFrame: fullSize];
    NSLog(@"%f %f %f %f", tvText.bounds.origin.x, tvText.bounds.origin.y, tvText.bounds.size.width, tvText.bounds.size.height);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    //Write our new values to the User defaults
    [[NSUserDefaults standardUserDefaults] setValue: [NSNumber numberWithShort: controller.firstChar] forKey: @"firstChar"];
    [[NSUserDefaults standardUserDefaults] setValue: [NSNumber numberWithShort: controller.lastChar] forKey: @"lastChar"];
    [[NSUserDefaults standardUserDefaults] setValue: [NSNumber numberWithShort: controller.unknownChar] forKey: @"unknownChar"];
    
    //Write our upper/lowercase preset to User defaults
    [[NSUserDefaults standardUserDefaults] setValue: [NSNumber numberWithBool: controller.swUpperCase.on] forKey: @"upperCase"];
    [[NSUserDefaults standardUserDefaults] setValue: [NSNumber numberWithBool: controller.swLowerCase.on] forKey: @"lowerCase"];
    
    //Send our vigenere instance the new cyphertext alphabet
    vigenere.firstChar = controller.firstChar;
    vigenere.lastChar = controller.lastChar;
    vigenere.unknownChar = controller.unknownChar;
    
    //Set our upper/lowercase preference in this instance
    upperCase = controller.swUpperCase.on;
    lowerCase = controller.swLowerCase.on;
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //Send the controller our current cyphertext alphabet definitions
    controller.firstChar = vigenere.firstChar;
    controller.lastChar = vigenere.lastChar;
    controller.unknownChar = vigenere.unknownChar;
    
    [self presentModalViewController:controller animated:YES];
    
    //Send the controller our upper/lowercase preferences
    controller.swUpperCase.on = upperCase;
    controller.swLowerCase.on = lowerCase;
}

- (IBAction)process:(id)sender
{
    NSString *input = tvText.text;
    NSString *key = tfKey.text;
    
    //Check for empty key (which would crash the app
    if([key isEqualToString: @""])
    {
        UIAlertView *noKey = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"No key!", nil)
                                                        message: NSLocalizedString(@"Please enter a valid key before encrypting or decrypting", nil)
                                                       delegate: self
                                              cancelButtonTitle: @"Go back"
                                              otherButtonTitles: nil];
        [noKey show];
        return;
    }
    
    if(mode == 0) //Check whether we want to encrypt or decrypt
    {
        //Check whether we should convert to upper/lowercase before encrypting
        if(upperCase == YES)
        {
            key = [key uppercaseString];
            input = [input uppercaseString];
        }
        else if(lowerCase == YES)
        {
            key = [key uppercaseString];
            input = [input lowercaseString];
        }
        
        tvText.text = [vigenere encryptText: input withKey: key];
    }
    else
    {
        //WHen decrypting we should already have a correctly formatted cyphertext. All we have to do is put the key in the correct case.
        if(upperCase == YES)
            key = [key uppercaseString];
        else if(lowerCase == YES)
            key = [key uppercaseString];
    
        tvText.text = [vigenere decryptText: input withKey: key];
    }
}

- (IBAction)changeMode:(id)sender
{
    mode = scMode.selectedSegmentIndex;
    if(mode == 0)
        [buProcess setTitle: NSLocalizedString(@"Encrypt", nil) forState:UIControlStateNormal];
    else
        [buProcess setTitle: NSLocalizedString(@"Decrypt", nil) forState:UIControlStateNormal];
}

//Methods for Handling the text view

//Resize when beginninge/ending edit
//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    [textView setFrame: reducedSize];
//}
//
//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//    [textView setFrame: fullSize];
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
