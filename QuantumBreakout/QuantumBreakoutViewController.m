//
//  QuantumBreakoutViewController.m
//  QuantumBreakout
//
//  Created by Sharon Levy on 10/2/13.
//  Copyright (c) 2013 Sharon Levy. All rights reserved.
//

#import "QuantumBreakoutViewController.h"

@interface QuantumBreakoutViewController ()

@end

@implementation QuantumBreakoutViewController

@synthesize ball;
@synthesize paddle;
@synthesize paddleView;

- (void)AnimateBall{
    ball.center = CGPointMake(ball.center.x + dx, ball.center.y + dy);
    //handle collisions
    
    //temporary values--need to find robust way of getting boundaries of application
    int width = self.view.center.x * 2;
    int height = self.view.center.y * 2;
    
    if(ball.center.x > width || ball.center.x < 0){
        dx = -dx;
    }
    if(ball.center.y > height || ball.center.y < 0){
        dy = -dy;
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize timer
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall) userInfo:nil repeats:YES];
    //initialize dx and dy
    dx = 5;//experiment with different values
    dy = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    CGPoint difference = [sender translationInView:self.view];
    if (difference .x+paddle.center.x<45.0)
    {
        paddle.center = CGPointMake(45.0, paddle.center.y);
        paddleView.center = CGPointMake(45.0, paddleView.center.y);
    }
    else if (difference .x+paddle.center.x>275.0) {
        paddle.center = CGPointMake(275.0, paddle.center.y);
        paddleView.center = CGPointMake(275.0, paddleView.center.y);
    }
    else {
        paddle.center = CGPointMake(paddle.center.x + difference.x, paddle.center.y);
        paddleView.center = CGPointMake(paddleView.center.x + difference.x, paddleView.center.y);
    }
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
}

@end
