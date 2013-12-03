//
//  BallTree.h
//  QuantumBreakout
//
//  Created by Sharon Levy on 11/15/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ball.h"

@interface BallTree : NSObject {
    struct Node *root;
    NSMutableArray *ballArray;
}

//@property(nonatomic, assign)struct Node *root;
-(id)init: (Ball*)firstBall;

-(Ball *)splitBall: (Ball*)ball;
-(void)getBallArrayRec: (struct Node *)node;
-(NSMutableArray *)getBallArray;
-(void)deleteTreeRec: (struct Node *)node;
-(void)deleteTree;
@end
