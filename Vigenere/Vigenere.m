//
//  vigenere.m
//  vigenère
//
//  Created by Ludger on 14.06.11.
//  Copyright 2012 Ludger Heide.
/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */

#import "Vigenere.h"

@implementation Vigenere

//Variables
@synthesize firstChar;
@synthesize lastChar; //lastChar IS within the alphabet
@synthesize unknownChar;

-(BOOL)canDecypher:(NSString *)text
{
    //Variables
    NSUInteger i;
    short character;
    
    for(i = 0; i < text.length; i++)
	{
		character = [text characterAtIndex: i];
		if((character < firstChar) || (character > lastChar))
            return NO;
    }
    return YES;
}

-(NSString *)makeDecypherable: (NSString *)text
{
    //Variables
    NSUInteger i;
    short character;
    NSMutableString *result = [[NSMutableString alloc] init];

    for(i = 0; i < text.length; i++)
	{
		character = [text characterAtIndex: i];
		if((character < firstChar) || (character > lastChar))
            [result appendFormat: @"%c", unknownChar];
        else
            [result appendFormat: @"%c", character];
    }
    return result;
}

-(NSString *)encryptText: (NSString *)cleartext withKey: (NSString *)key
{
	//Variables
	NSUInteger i;
	short clearChar, keyChar, cypherChar;
    
	NSMutableString *result = [[NSMutableString alloc] init];
	
	for(i = 0; i < cleartext.length; i++)
	{
		clearChar = [cleartext characterAtIndex: i];
		if((clearChar < firstChar) || (clearChar > lastChar))
			clearChar = unknownChar;
		//NSLog(@"%c", clearChar);
		
        keyChar = [key characterAtIndex: ((i + key.length) % key.length)];
		if((keyChar < firstChar) || (keyChar > lastChar))
			keyChar = unknownChar;
		//NSLog(@"%c", keyChar);
		
		cypherChar = clearChar + (keyChar - firstChar);
		
        if(cypherChar > lastChar)
			cypherChar = cypherChar - ((lastChar +1) - firstChar);  //If we are outside the alphabet, subtract alphabet size.
		//NSLog(@"%c", cypherChar);
		
		[result appendFormat: @"%c", cypherChar];
	}
	return result;
}

-(NSString *)decryptText: (NSString *)cyphertext withKey: (NSString *)key
{
	NSUInteger i;
	short clearChar, keyChar, cypherChar;
    
	NSMutableString *result = [[NSMutableString alloc] init];
	
	for(i = 0; i < cyphertext.length; i++)
	{
		cypherChar = [cyphertext characterAtIndex: i];
		if((cypherChar < firstChar) || (cypherChar > lastChar))
        {
            [result appendFormat: @"#"];
            break;
        }
		//NSLog(@"%c", cypherChar);
		
		keyChar = [key characterAtIndex: ((i + key.length) % key.length)];
		if((keyChar < firstChar) || (keyChar > lastChar))
			keyChar = unknownChar;
		//NSLog(@"%c", keyChar);
		
		clearChar = cypherChar - (keyChar - firstChar);
		
        if(clearChar < firstChar)
			clearChar = clearChar + ((lastChar +1) - firstChar);    //If we are outside the alphabet, add alphabet size.
		//NSLog(@"%c", clearChar);
		
		[result appendFormat: @"%c", clearChar];
	}
	return result;
}
 
-(NSString *)decryptAutomatically: (NSString *)cyphertext withKeyLength: (NSInteger)keyLength
{
    return @"Not quite ready";
}

-(id)initWithfirstChar: (short)fChar lastChar: (short)lChar unknownChar: (short)uChar
{
    self = [super init];
    if(self)
    {
        firstChar = fChar;
        lastChar = lChar;
        unknownChar = uChar;
    }
    return self;
}

-(id)init
{
    return [self initWithfirstChar: 33 lastChar: 90 unknownChar: 35];
}

@end
