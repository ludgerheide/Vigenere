//
//  vigenere.m
//  vigenère
//
//  Created by Ludger on 14.06.11.
//  Copyright 2011 Ludger Heide. All rights reserved.
//
//  Licensed under the WTFPL
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
		if((character < firstChar) || (character >= (lastChar +1)))
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
		if((character < firstChar) || (character >= (lastChar +1)))
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
		if((clearChar < firstChar) || (clearChar >= (lastChar +1)))
			clearChar = unknownChar;
		//NSLog(@"%c", clearChar);
		
        keyChar = [key characterAtIndex: ((i + key.length) % key.length)];
		if((keyChar < firstChar) || (keyChar >= (lastChar +1)))
			keyChar = unknownChar;
		//NSLog(@"%c", keyChar);
		
		cypherChar = clearChar + (keyChar - firstChar);
		
        if(cypherChar >= (lastChar +1))
			cypherChar = cypherChar - ((lastChar +1) - firstChar);
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
		if((cypherChar < firstChar) || (cypherChar >= (lastChar +1)))
        {
            [result appendFormat: @"#"];
            break;
        }
		//NSLog(@"%c", cypherChar);
		
		keyChar = [key characterAtIndex: ((i + key.length) % key.length)];
		if((keyChar < firstChar) || (keyChar >= (lastChar +1)))
			keyChar = unknownChar;
		//NSLog(@"%c", keyChar);
		
		clearChar = cypherChar - (keyChar - firstChar);
		
        if(clearChar < firstChar)
			clearChar = clearChar + ((lastChar +1) - firstChar);
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
