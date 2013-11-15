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
    if(self = [super init]){
        root = (struct Node *) malloc(sizeof(struct Node));
        root->data = firstBall;
        root->parent = NULL;
        root->left = NULL;
        root->right = NULL;
    }
    return self;
}

@end
