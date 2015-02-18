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
    self.positiveImage =[[UIImageView alloc] initWithFrame:CGRectMake(super.locationX,super.locationY,40,40)];
    self.positiveImage.center = CGPointMake(self.locationX, self.locationY);
    self.positiveImage.image=[UIImage imageNamed:@"plus.png"];
    return(self);
}

-(void) move{
    [super move];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:5.00];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
    [UIView setAnimationCurve: UIViewAnimationCurveLinear];
    int yFinishLocation = self.positiveImage.superview.center.y;
    if(super.speed > 0){
        yFinishLocation -= 45;
    }else if(super.speed < 0){
        yFinishLocation += 45;
    }
#warning needs to be standardized to size of switcher
    self.positiveImage.center = CGPointMake(self.positiveImage.superview.center.x, yFinishLocation);
    [UIView commitAnimations];
}

- (void)transitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    NSLog(@"transition stoped in Positive");
    bool location = false;
    if(self.speed > 0){
        //If the token is moving from the top
        location = true;
    }
    [MainViewController collide:self withLocation:location];
}

@end
