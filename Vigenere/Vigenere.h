//
//  vigenere.h
//  vigenère
//
//  Created by Ludger on 14.06.11.
//  Copyright 2012 Ludger Heide.
/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */

#import <Foundation/Foundation.h>

@interface Vigenere : NSObject
{
	short firstChar, lastChar, unknownChar;
}

@property(nonatomic) short firstChar;
@property(nonatomic) short lastChar; //lastChar IS within the alphabet
@property(nonatomic) short unknownChar;

-(BOOL)canDecypher: (NSString *)text;
-(NSString *)makeDecypherable: (NSString *)text;
-(NSString *)encryptText: (NSString *)cleartext withKey: (NSString *)key;
-(NSString *)decryptText: (NSString *)cyphertext withKey: (NSString *)key;
-(NSString *)decryptAutomatically: (NSString *)cyphertext
                    withKeyLength: (NSInteger)keyLength; //This is not guaranteed to return a correct result.

-(id)initWithfirstChar: (short)fChar lastChar: (short)lChar unknownChar: (short)uChar;

@end
