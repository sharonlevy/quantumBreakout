//
//  QuantumBreakoutViewController.h
//  QuantumBreakout
//
//  Created by Sharon Levy on 10/2/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "BallTree.h"
@interface QuantumBreakoutViewController : UIViewController <UIAlertViewDelegate> {
    NSTimer *timer;
    NSInteger dx;
    NSInteger dy;
    NSInteger score;
    BOOL alertShown;
    NSMutableArray *balls;
    BOOL shouldAnimate;
    NSTimer *timeGame;
}
@property (strong, nonatomic) Ball *ball;
@property (strong, nonatomic) IBOutlet UIImageView *paddle;
@property (strong, nonatomic) IBOutlet UIView *paddleView;
@property (strong, nonatomic) IBOutlet UIImageView *beamSplitter;
@property (strong, nonatomic) BallTree *tree;

- (IBAction)pan:(UIPanGestureRecognizer *)sender;
- (void) AnimateBall: (UIImageView *)ball;
- (void)lose;
- (void)splitBalls:(Ball *)thisBall;

@end
