//
//  Coin.m
//  Switch
//
//  Created by Jared Weinstein on 2/4/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import "Coin.h"

@interface Coin ()

@end

@implementation Coin

-(id) init{
    NSLog(@"Loaded a default Coin");
    return self;
}

-(id) initWithX:(int)posX andY:(int)posY andValue:(int)val {
    self = [super init];
    NSLog(@"Custom Init: %@", self);
    self.locationX = posX;
    self.locationY = posY;
    self.value = val;
    self.coinImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.locationX,self.locationY,20,20)];
    self.coinImage.center = CGPointMake(self.locationX, self.locationY);
    self.coinImage.image=[UIImage imageNamed:@"coin.png"];
    return(self);
}


@end