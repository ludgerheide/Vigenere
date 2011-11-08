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
@synthesize fullSize;
@synthesize reducedSize;

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
    
    //Initialize vigenere with them
    vigenere = [[Vigenere alloc] initWithfirstChar: firstChar lastChar: lastChar unknownChar: unknownChar];
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
    if(interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        fullSize = CGRectMake(0, 57, 320, 344);
        reducedSize = CGRectMake(0, 57, 320, 198);
        if([tvText isFirstResponder])
            [tvText setFrame: reducedSize];
        else
            [tvText setFrame: fullSize];
    }
    else
    {
        fullSize = CGRectMake(0, 57, 480, 184);
        reducedSize = CGRectMake(0, 57, 480, 83);
        if([tvText isFirstResponder])
            [tvText setFrame: reducedSize];
        else
            [tvText setFrame: fullSize];
    }
    NSLog(@"%f %f %f %f", tvText.bounds.origin.x, tvText.bounds.origin.y, tvText.bounds.size.width, tvText.bounds.size.height);
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    //Write our new values to the User defaults
    [[NSUserDefaults standardUserDefaults] setValue: [NSNumber numberWithShort: controller.firstChar] forKey: @"firstChar"];
    [[NSUserDefaults standardUserDefaults] setValue: [NSNumber numberWithShort: controller.lastChar] forKey: @"lastChar"];
    [[NSUserDefaults standardUserDefaults] setValue: [NSNumber numberWithShort: controller.unknownChar] forKey: @"unknownChar"];
    
    //Send our vigenere instance the new cyphertext alphabet
    vigenere.firstChar = controller.firstChar;
    vigenere.lastChar = controller.lastChar;
    vigenere.unknownChar = controller.unknownChar;
    
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
    [textView setFrame: reducedSize];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView setFrame: fullSize];
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
