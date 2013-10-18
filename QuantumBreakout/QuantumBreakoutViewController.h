//
//  QuantumBreakoutViewController.h
//  QuantumBreakout
//
//  Created by Sharon Levy on 10/2/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuantumBreakoutViewController : UIViewController {
    NSTimer *timer;
    NSInteger dx;
    NSInteger dy;
}
@property (strong, nonatomic) IBOutlet UIImageView *ball;
@property (strong, nonatomic) IBOutlet UIImageView *paddle;
@property (strong, nonatomic) IBOutlet UIView *paddleView;

- (IBAction)pan:(UIPanGestureRecognizer *)sender;
- (void) AnimateBall;

@end
