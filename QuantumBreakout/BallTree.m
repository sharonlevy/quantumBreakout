//
//  BallTree.m
//  QuantumBreakout
//
//  Created by Sharon Levy on 11/15/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import "BallTree.h"
#import "Ball.h"

@implementation BallTree


struct Node {
    Ball *data;
    struct Node *parent;
    struct Node *left;
    struct Node *right;
};

-(id)init : (Ball *) firstBall{
    
}

@end
