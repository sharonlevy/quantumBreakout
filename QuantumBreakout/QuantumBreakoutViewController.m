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
@synthesize beamSplitter;

- (void)AnimateBall:(NSTimer *)time{
    UIImageView *image = [time userInfo];
    image.center = CGPointMake(image.center.x + dx, ball.center.y + dy);
    //handle collisions
    [self handleCollision:ball];

}

-(void)handleCollision:(UIImageView*) thisBall{
    int width = self.view.center.x * 2;
    int height = self.view.center.y * 2;
    
    if(thisBall.center.x + thisBall.bounds.size.width/2 > width
       || thisBall.center.x - thisBall.bounds.size.width/2 < 0){
        dx = -dx;
    }
    if(thisBall.center.y + thisBall.bounds.size.height/2 > height){
        if (alertShown == NO) {
            [self lose];
            alertShown = YES;
        }
    }
    if(thisBall.center.y - thisBall.bounds.size.height/2 < 0){
        dy = -dy;
    }
    
    if(CGRectIntersectsRect(thisBall.frame, CGRectMake(paddle.frame.origin.x, paddle.frame.origin.y, paddle.frame.size.width, 1))){
        dy = -abs(dy);
    }
    if(CGRectIntersectsRect(thisBall.frame, beamSplitter.frame)) {
        if (intersectSplitter == NO) {
            [self splitBalls];
            intersectSplitter = YES;
        }
    }

}

-(void)splitBalls {
    NSLog(@"split");
    intersectSplitter = YES;
    Ball *testBall = [[Ball alloc] initWithCoordinate:CGPointMake(100.0, 100.0)];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:testBall.ball repeats:YES];
    //probably not going to use
  /*  UIImage *fakerBall = [UIImage imageNamed:@"ball.png"];
    UIImageView *fakeBall = [[UIImageView alloc] initWithImage:fakerBall];
    fakeBall.hidden = NO;
    fakeBall.frame = CGRectMake(50.0, 50.0, 100.0, 100.0);
    [self.view addSubview:fakeBall];
    newTime = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:fakeBall repeats:YES];
    [balls addObject:fakeBall];
    [balls objectAtIndex:0]; */
    [self.view addSubview:testBall.ball];
}

-(void)lose{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"YOU LOSE"
                              message:@"HAHAHAHA"
                              delegate:self
                              cancelButtonTitle:@"Play Again!"
                              otherButtonTitles:nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    ball.center = CGPointMake(self.view.center.x,self.view.center.y);
    alertShown = NO;
   // [self startNewRound];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize timer
   // Ball *tester =[[Ball alloc] initWithCoordinate:CGPointMake(100.0, 100.0)];
   // timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:tester.ball repeats:YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:ball repeats:YES];
   // [self.view addSubview:tester.ball];
    //initialize dx and dy
    dx = 5;//experiment with different values
    dy = 5;
    paddle.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 300);
    NSLog(@"view size: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
    alertShown = NO;
    intersectSplitter = NO;
    balls = [[NSMutableArray alloc] init];
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
