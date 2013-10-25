//
//  Ball.h
//  QuantumBreakout
//
//  Created by Sharon Levy on 10/24/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ball : NSObject {
    float x;
    float y;
    NSInteger dx;
    NSInteger dy;
}

@property(nonatomic, retain)UIImageView *ball;
-(id)initWithCoordinate: (CGPoint)point ;

@end