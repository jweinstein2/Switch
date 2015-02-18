//
//  MainViewController.h
//  Switch
//
//  Created by Jared Weinstein on 2/3/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coin.h"
#import "Positive.h"
#import "Negative.h"
#import "Switcher.h"

@interface MainViewController : UIViewController

-(void) collide:(Token*) tok withLocation:(bool) loc;

@property (weak, nonatomic) IBOutlet UILabel *leftScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *gamecenter;
@property (weak, nonatomic) IBOutlet UIButton *store;
@property (weak, nonatomic) IBOutlet UIButton *settings;
@property (weak, nonatomic) IBOutlet UIButton *information;

@property NSMutableArray *coins;
@property NSMutableArray *tokens;
@property Switcher *switcher;

@end
