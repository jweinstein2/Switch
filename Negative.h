//
//  Negative.h
//  Switch
//
//  Created by Jared Weinstein on 2/9/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import "Token.h"

@interface Negative : Token

-(id) init;
-(id) initWithSpeed: (int)spd;
-(void) move;
-(void) bounce;

@end
