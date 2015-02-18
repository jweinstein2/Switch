//
//  MainViewController.m
//  Switch
//
//  Created by Jared Weinstein on 2/3/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

bool playing;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    playing = false;
    self.tokens = [[NSMutableArray alloc] init];
    self.coins = [[NSMutableArray alloc] init];
    self.switcher = [[Switcher alloc] init];
    [self.view addSubview: self.switcher.switcherImage];
    [self.view bringSubviewToFront: self.switcher.switcherImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backgroundButtonPressed:(id)sender {
    if(playing == false){
        NSLog(@"Triggered");
        //If the game is not currently being played need to start new game
        [self addCoin:1 withLocX: 50 andLocY: 100];
        [self addCoin:1 withLocX: 100 andLocY: 400];
        [self addPositiveTokenWithSpeed:1];
        [self addNegativeTokenWithSpeed:-1];
        [self changeScreen];
        [self performSelector:@selector(gameLoop) withObject:self afterDelay:0.5];
        playing = true;
    }else if(playing == true){
        [self.switcher switchAction];
        //If a game is in progress need to switch the view
        
    }
}

//Move all information to the back
-(void)changeScreen{
    [self.view sendSubviewToBack:self.gamecenter];
    [self.view sendSubviewToBack:self.store];
    [self.view sendSubviewToBack:self.settings];
    [self.view sendSubviewToBack:self.information];
    [self.leftScoreLabel setAlpha: .35];
    [self.centerScoreLabel setAlpha: .35];
    [self.rightScoreLabel setAlpha: .35];
    
}

-(void)gameLoop{
    /*
    for(Token *tok in self.tokens) {
        //Check if tokens have completed animation
    }
    */
    [self performSelector:@selector(gameLoop) withObject:self afterDelay:0.01];
}

-(void)addCoin: (int)value withLocX: (int)locX andLocY: (int)locY{
    NSLog(@"Adding a coin");
    Coin *coin = [[Coin alloc] initWithX:locX andY:locY andValue:value];
    [self.view addSubview: coin.coinImage];
    [self.coins addObject: coin];
    [self.view bringSubviewToFront: coin.coinImage];
}

-(void)addPositiveTokenWithSpeed:(int)spd{
    NSLog(@"Adding a Positive Token");
    Positive *token = [[Positive alloc] initWithSpeed:spd];
    [self.view addSubview: token.positiveImage];
    [self.tokens addObject: token];
    [self.view bringSubviewToFront: token.positiveImage];
    [token move];
}

-(void)addNegativeTokenWithSpeed:(int)spd{
    NSLog(@"Adding a Negative Token");
    Negative *token = [[Negative alloc] initWithSpeed:spd];
    [self.view addSubview: token.negativeImage];
    [self.tokens addObject: token];
    [self.view bringSubviewToFront: token.negativeImage];
    [token move];
}

-(void) collide: (Token*) tok withLocation:(bool) loc{
    NSLog(@"CALLED");
    if(tok.value > 1){
        //if the token is positive
        if(loc == self.switcher.orientation){
            //If they match
            NSLog(@"correct: need to add one to score");
        }else{
            //if they don't match
            NSLog(@"incorrect: bounces straight back");
        }
    }else{
        //if the token is negative
        if(loc == self.switcher.orientation){
            //If they match
            NSLog(@"corret: bounces diagonally");
        }else{
            //if they don't match
            NSLog(@"incorrect: end game");
        }
    }
}

-(void) collideHelper: (Token*) tok withLocation:(bool) loc{
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
