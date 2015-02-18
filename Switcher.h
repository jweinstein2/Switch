//
//  Switcher.h
//  Switch
//
//  Created by Jared Weinstein on 2/12/15.
//  Copyright (c) 2015 Jared Weinstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Switcher : NSObject

-(id) init;
-(void)switchAction;

@property UIImageView *switcherImage;
@property bool orientation; //TRUE represents up FALSE represents down

@end
