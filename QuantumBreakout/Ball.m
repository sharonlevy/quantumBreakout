//
//  Ball.m
//  QuantumBreakout
//
//  Created by Sharon Levy on 10/24/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import "Ball.h"
//#import "BallTree.h"

@implementation Ball 
@synthesize ballImage;
@synthesize dx;
@synthesize dy;
@synthesize intersectsSplitter;
@synthesize isReal;
-(id)initWithCoordinate: (CGPoint)point
{
    if (self = [super init])
    {
        x = point.x;
        y = point.y;
        ballImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
        ballImage.frame = CGRectMake(x, y, 34, 27);
    }
    return self;
}

-(id)initWithVelocity: (CGPoint)point : (NSInteger)xVel : (NSInteger)yVel
{
    if (self = [super init])
    {
        x = point.x;
        y = point.y;
        dx = xVel;
        dy = yVel;
        ballImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
        ballImage.frame = CGRectMake(x, y, 34, 27);
        intersectsSplitter = NO;
        isReal = NO;
    }
    return self;
}

-(void)decrementOpacity
{
    if(ballImage.layer.opacity>0.1){
        ballImage.layer.opacity -= 0.1;
    }
}

-(void)matchOpacity: (Ball*) otherBall
{
    ballImage.layer.opacity = otherBall.ballImage.layer.opacity;
}

-(void)resetOpacity
{
    ballImage.layer.opacity = 1.0;
}



@end
