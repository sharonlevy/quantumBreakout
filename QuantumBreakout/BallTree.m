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
@synthesize root;

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
        firstBall.node = root;
    }
    return self;
}

-(void)splitBall : (Ball *) ball{
    Ball *newBall = [[Ball alloc] initWithVelocity:ball.ballImage.center :ball.dx :(-1) * ball.dy ];
    newBall.intersectsSplitter = YES;
    
    if(ball.isReal){
        //50% chance
        int maybe = arc4random()%2;
        //NSLog(@"%d", maybe);
        if(maybe == 0){
            ball.isReal = NO;
            newBall.isReal = YES;
        }
    }
    //thisBall.ballImage.layer.opacity -= 0.1;
    //testBall.ballImage.layer.opacity = thisBall.ballImage.layer.opacity;
    [ball decrementOpacity];
    [newBall matchOpacity:ball];
    //[balls addObject:newBall];
    struct Node * currNode = (struct Node *) ball.node;
    currNode->data = NULL;
    struct Node * leftChild = (struct Node *) malloc(sizeof(struct Node));
    
    leftChild->data = ball;
    leftChild->parent = currNode;
    leftChild->left = NULL;
    leftChild->right = NULL;
    
    struct Node * rightChild = (struct Node *) malloc(sizeof(struct Node));
    rightChild->data = newBall;
    rightChild->parent = currNode;
    rightChild->left = NULL;
    rightChild->right = NULL;
    ball.node = rightChild;
    
    
    currNode->left = leftChild;
    currNode->right = rightChild;
    //[self.view.superview addSubview:testBall.ballImage];
}


@end
