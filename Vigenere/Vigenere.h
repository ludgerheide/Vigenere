//
//  vigenere.h
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

#import <Foundation/Foundation.h>

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
                    withKeyLength: (NSInteger)keyLength;

-(id)initWithfirstChar: (short)fChar lastChar: (short)lChar unknownChar: (short)uChar;

@end
