//
//  Coin.h
//  Switch
//
//  Created by Jared Weinstein on 2/4/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface Coin : NSObject

-(id) init;
-(id) initWithX:(int)posX andY:(int)posY andValue:(int)val;

@property int locationX;
@property int locationY;
@property int value;
@property UIImageView *coinImage;

@end