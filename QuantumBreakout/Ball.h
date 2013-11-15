//
//  Ball.h
//  QuantumBreakout
//
//  Created by Sharon Levy on 10/24/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BallTree.h"

@interface Ball : NSObject {
    float x;
    float y;
    //float realness;
}

@property(nonatomic, retain)UIImageView *ballImage;
@property(nonatomic, assign)NSInteger dx;
@property(nonatomic, assign)NSInteger dy;
@property(nonatomic, assign)BOOL intersectsSplitter;
@property(nonatomic, assign)BOOL isReal;
@property(nonatomic, assign)struct Node * node;
-(id)initWithCoordinate: (CGPoint)point ;
-(id)initWithVelocity: (CGPoint)point : (NSInteger) xVel : (NSInteger) yVel ;
-(void)decrementOpacity;
-(void)matchOpacity: (Ball*) otherBall;
-(void)resetOpacity;

@end
