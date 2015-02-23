//
//  Positive.m
//  Switch
//
//  Created by Jared Weinstein on 2/9/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import "Positive.h"
#import "MainViewController.h"

@implementation Positive

-(id) init{
    NSLog(@"Loaded a default Pos Token");
    return self;
}

-(id) initWithSpeed: (int)spd{
    self = [super init];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    super.locationX = screenSize.width / 2;
    NSLog(@"%d", super.locationX);
    self.value = 1;
    if(spd > 0)
        super.locationY = -20;
    else if(spd < 0)
        super.locationY = screenSize.height + 20;
    super.speed = spd;
    self.tokenImage =[[UIImageView alloc] initWithFrame:CGRectMake(super.locationX,super.locationY,40,40)];
    self.tokenImage.center = CGPointMake(self.locationX, self.locationY);
    self.tokenImage.image=[UIImage imageNamed:@"plus.png"];
    return(self);
}

-(void) move{
    [super move];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2]; //NEED TO ADD VARIABLE SPEED
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
    [UIView setAnimationCurve: UIViewAnimationCurveLinear];
    int yFinishLocation = self.tokenImage.superview.center.y;
    if(super.speed > 0){
        yFinishLocation -= 45;
    }else if(super.speed < 0){
        yFinishLocation += 45;
    }
#warning needs to be standardized to size of switcher
    self.tokenImage.center = CGPointMake(self.tokenImage.superview.center.x, yFinishLocation);
    [UIView commitAnimations];
}

- (void)transitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    NSLog(@"transition stoped in Positive");
    bool location = false;
    self.collided = true;
    if(self.speed > 0){
        //If the token is moving from the top
        location = true;
    }
    NSLog(@"%@", self.tokenImage.class);
}

-(void) bounce{
    //Bounces straight back the same direction
    NSLog(@"here");
    [super bounce];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceFinished:finished:context:)];
    [UIView setAnimationCurve: UIViewAnimationCurveLinear];
    int yFinishLocation;
    if(super.speed > 0){
        yFinishLocation -= 30;
    }else if(super.speed <= 0){
        yFinishLocation += [[UIScreen mainScreen] bounds].size.height + 30;
    }
    self.tokenImage.center = CGPointMake(self.tokenImage.superview.center.x, yFinishLocation);
    [UIView commitAnimations];
}

- (void)bounceFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    NSLog(@"transition stoped in Positive");
    self.needsToBeRemoved = true;
}

@end
