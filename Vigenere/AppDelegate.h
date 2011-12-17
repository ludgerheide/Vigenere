//
//  AppDelegate.h
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

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *mainViewController;

@end
