//
//  Switcher.m
//  Switch
//
//  Created by Jared Weinstein on 2/12/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import "Switcher.h"

@implementation Switcher

-(id) init{
    NSLog(@"Loaded the Switcher");
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    self.orientation = true;
    self.switcherImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,50)];
    self.switcherImage.center = CGPointMake(screenBound.size.width / 2, screenBound.size.height / 2);
    self.switcherImage.image=[UIImage imageNamed:@"switchUp.png"];
    NSLog(@"Created the switcher");
    return self;
}

-(void) switchAction{
    if(self.orientation == TRUE){
        //Switch the switcher to down
        NSLog(@"Orientation is down");
        self.switcherImage.image=[UIImage imageNamed:@"switchDown.png"];
        self.orientation = FALSE;
    }else if(self.orientation == FALSE){
        //Switch the view to up
        NSLog(@"Orientation is up");
        self.switcherImage.image=[UIImage imageNamed:@"switchUp.png"];
        self.orientation = TRUE;
    }
}

-(int) getOrientation{
    return self.orientation;
}

@end
