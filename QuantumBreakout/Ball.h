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
}

@property(nonatomic, retain)UIImageView *ballImage;
@property(nonatomic, assign)NSInteger dx;
@property(nonatomic, assign)NSInteger dy;
@property(nonatomic, assign)BOOL intersectsSplitter;
-(id)initWithCoordinate: (CGPoint)point ;
-(id)initWithVelocity: (CGPoint)point : (NSInteger) xVel : (NSInteger) yVel ;

@end
