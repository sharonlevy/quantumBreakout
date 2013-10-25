//
//  Ball.m
//  QuantumBreakout
//
//  Created by Sharon Levy on 10/24/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import "Ball.h"

@implementation Ball {
    float x, y;
}
@synthesize ball;
-(id)initWithCoordinate: (CGPoint)point
{
    if (self = [super init])
    {
        x = point.x;
        y = point.y;
        ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
        ball.frame = CGRectMake(x, y, 34, 27);
    }
    return self;
}


@end
