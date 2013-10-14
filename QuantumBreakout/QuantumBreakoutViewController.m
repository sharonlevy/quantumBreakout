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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
