//
//  MainViewController.m
//  Vigenere
//
//  Created by Ludger Heide on 06.11.11.
//  Copyright (c) 2011 Ludger Heide. All rights reserved.
//

#import "Vigenere.h"
#import "MainViewController.h"

@implementation MainViewController

@synthesize vigenere;
@synthesize mode;

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
    self.vigenere = [[Vigenere alloc] init];
}

- (void)viewDidUnload
{
    [self setTfKey:nil];
    [self setBuProcess:nil];
    [self setTvText:nil];
    [self setVigenere: nil];
    [self setScMode:nil];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
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
        tvText.text = [vigenere encryptText: input withKey: key];
    else
        tvText.text = [vigenere decryptText: input withKey: key];
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
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView setFrame:CGRectMake(0, 57, 320, 198)];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView setFrame:CGRectMake(0, 57, 320, 344)];
}

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
