//
//  vigenere.h
//  vigenère
//
//  Created by Ludger on 14.06.11.
//  Copyright 2011 Ludger Heide. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Vigenere : NSObject
{
	short firstChar, lastChar, unknownChar;
}

@property(nonatomic) short firstChar;
@property(nonatomic) short lastChar; //lastChar is not within the alphabet, it is the first character outside!!!
@property(nonatomic) short unknownChar;

-(BOOL)canDecypher: (NSString *)text;
-(NSString *)makeDecypherable: (NSString *)text;
-(NSString *)encryptText: (NSString *)cleartext withKey: (NSString *)key;
-(NSString *)decryptText: (NSString *)cyphertext withKey: (NSString *)key;
-(NSString *)decryptAutomatically: (NSString *)cyphertext
                    withKeyLength: (NSInteger)keyLength;

@end
