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
int score;

- (void)viewDidLoad {
    [super viewDidLoad];
    playing = false;
    self.tokens = [[NSMutableArray alloc] init];
    self.coins = [[NSMutableArray alloc] init];
    self.switcher = [[Switcher alloc] init];
    [self.view addSubview: self.switcher.switcherImage];
    [self.view bringSubviewToFront: self.switcher.switcherImage];
    // Do any additional setup after loading the view
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
        score = 0;
        self.centerScoreLabel.text = [NSString stringWithFormat:@"0"];
        //[self addNegativeTokenWithSpeed:-1];
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
    [self.centerScoreLabel setAlpha: .45];
    
}

-(void)gameLoop{
    for(Token *tok in self.tokens) {
        //Check if tokens have completed animation
        if(tok.collided == true){
            bool loc = false;
            if(tok.speed > 0)
                loc = true;
            [self collide:tok withLocation:loc];
        }else if(tok.needsToBeRemoved == true){
            //NSLog(@"Removed:");
            [self.tokens removeObject:tok];
            [self addNegativeTokenWithSpeed:1];
        }
    }
    self.centerScoreLabel.text = [NSString stringWithFormat: @"%d", score];
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
    [self.view addSubview: token.tokenImage];
    [self.tokens addObject: token];
    [self.view bringSubviewToFront: token.tokenImage];
    [token move];
}

-(void)addNegativeTokenWithSpeed:(int)spd{
    NSLog(@"Adding a Negative Token");
    Negative *token = [[Negative alloc] initWithSpeed:spd];
    [self.view addSubview: token.tokenImage];
    [self.tokens addObject: token];
    [self.view bringSubviewToFront: token.tokenImage];
    [token move];
}

-(void) collide: (Token*) tok withLocation:(bool) loc{
    if(tok.value > 0){
        //if the token is positive
        if(loc == self.switcher.orientation){
            //If they match
            score += 1;
            [self.tokens removeObject:tok];
            [tok.tokenImage removeFromSuperview];
            NSLog(@"correct: need to add one to score");
            [self addPositiveTokenWithSpeed:-1];
        }else{
            NSLog(@"incorrect: end game");
            [self.tokens removeObject:tok];
            [tok.tokenImage removeFromSuperview];
            [self endGame];
            playing = false;
        }
    }else{
        //if the token is negative
        if(loc != self.switcher.orientation){
            //If they match
            [tok bounce];
            NSLog(@"corret: bounces diagonally");
        }else{
            NSLog(@"incorrect: end game");
            [self.tokens removeObject:tok];
            [tok.tokenImage removeFromSuperview];
            [self endGame];
            playing = false;
        }
    }
    tok.collided = false;
}

-(void)endGame{
    //NEED TO COMPLETELY CLEAR THE SCREEN
    [self.view bringSubviewToFront:self.gamecenter];
    [self.view bringSubviewToFront:self.store];
    [self.view bringSubviewToFront:self.settings];
    [self.view bringSubviewToFront:self.information];
    [self.centerScoreLabel setAlpha: 1];
    self.tokens = [[NSMutableArray alloc] init];
    self.coins = [[NSMutableArray alloc] init];
    [self.switcher.switcherImage removeFromSuperview];
    self.switcher = [[Switcher alloc] init];
    [self.view addSubview: self.switcher.switcherImage];
    [self.view bringSubviewToFront: self.switcher.switcherImage];
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
