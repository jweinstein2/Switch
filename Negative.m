//
//  Negative.m
//  Switch
//
//  Created by Jared Weinstein on 2/9/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import "Negative.h"
#import "MainViewController.h"

@implementation Negative

-(id) init{
    NSLog(@"Loaded a default Neg Token");
    return self;
}

-(id) initWithSpeed: (int)spd{
    self = [super init];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    super.locationX = screenSize.width / 2;
    if(spd > 0)
        super.locationY = -20;
    else if(spd < 0)
        super.locationY = screenSize.height + 20;
    self.value = -1;
    super.speed = spd;
    self.negativeImage =[[UIImageView alloc] initWithFrame:CGRectMake(super.locationX,super.locationY,40,40)];
    self.negativeImage.center = CGPointMake(self.locationX, self.locationY);
    self.negativeImage.image=[UIImage imageNamed:@"minus.png"];
    return(self);
}

-(void) move{
    [super move];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:5.00];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
    [UIView setAnimationCurve: UIViewAnimationCurveLinear];
    
    int yFinishLocation = self.negativeImage.superview.center.y;
    if(super.speed > 0){
        yFinishLocation -= 45;
    }else if(super.speed < 0){
        yFinishLocation += 45;
    }
#warning needs to be standardized to size of switcher
    self.negativeImage.center = CGPointMake(self.negativeImage.superview.center.x, yFinishLocation);
    [UIView commitAnimations];
}

- (void)transitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    NSLog(@"transition stoped in Negative");
    bool location = false;
    if(self.speed > 0){
        //If the token is moving from the top
        location = true;
    }
    [MainViewController collide:self withLocation:location];
}

@end
