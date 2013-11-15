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
    if(shouldAnimate){
        for (int i = 0; i<[balls count]; i++) {
            Ball *current = [balls objectAtIndex:i];
            current.ballImage.center = CGPointMake(current.ballImage.center.x + current.dx, current.    ballImage.center.y + current.dy);
            [self handleCollision:current];
        }
    }
}

-(void)handleCollision:(Ball*) thisBall{
    int width = self.view.center.x * 2;
    int height = self.view.center.y * 2;
    
    if(thisBall.ballImage.center.x + thisBall.ballImage.bounds.size.width/2 > width){
        thisBall.dx = -abs(thisBall.dx);
    }
    if(thisBall.ballImage.center.x - thisBall.ballImage.bounds.size.width/2 < 0){
        thisBall.dx = abs(thisBall.dx);
    }
    if(thisBall.isReal){
        if(thisBall.ballImage.center.y + thisBall.ballImage.bounds.size.height/2 > height){
            if (alertShown == NO) {
                [self lose];
                alertShown = YES;
            }
        }
    }
    if(thisBall.ballImage.center.y - thisBall.ballImage.bounds.size.height/2 < 0){
        thisBall.dy = abs(thisBall.dy);
    }
    
    if(CGRectIntersectsRect(thisBall.ballImage.frame, CGRectMake(paddle.frame.origin.x, paddle.frame.origin.y, paddle.frame.size.width, 1))){
        thisBall.dy = -abs(thisBall.dy);
    }
    if(CGRectIntersectsRect(thisBall.ballImage.frame, beamSplitter.frame)) {
        if (thisBall.intersectsSplitter == NO) {
            thisBall.intersectsSplitter = YES;
            [self splitBalls:thisBall];
        }
    }
    if(!CGRectIntersectsRect(thisBall.ballImage.frame, beamSplitter.frame)) {
        thisBall.intersectsSplitter = NO;
    }

}

-(void)splitBalls:(Ball *)thisBall {
    Ball *testBall = [[Ball alloc] initWithVelocity:thisBall.ballImage.center :thisBall.dx :(-1) * thisBall.dy ];
    testBall.intersectsSplitter = YES;
    
    if(thisBall.isReal){
        //50% chance
        int maybe = arc4random()%2;
        NSLog(@"%d", maybe);
        if(maybe == 0){
            thisBall.isReal = NO;
            testBall.isReal = YES;
        }
    }
    thisBall.ballImage.layer.opacity = 0.7;
    testBall.ballImage.layer.opacity = 0.7;
    [balls addObject:testBall];
    [self.view.superview addSubview:testBall.ballImage];
}

-(void)lose{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"YOU LOSE"
                              message:@"HAHAHAHA"
                              delegate:self
                              cancelButtonTitle:@"Play Again!"
                              otherButtonTitles:nil];
    
    [alertView show];
    //[timer invalidate];
    shouldAnimate = NO;
   
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    for (int i = [balls count]-1; i>0; i--) {
        [[[balls objectAtIndex:i] ballImage] removeFromSuperview];
        [balls removeObjectAtIndex:i];
     }
     
    ball.ballImage.center = CGPointMake(self.view.center.x,self.view.center.y);
    alertShown = NO;
    ball.intersectsSplitter = NO;
    ball.isReal = YES;
    //initialize dx and dy
    [self getNewVelocity];
    ball.dx = dx;//experiment with different values
    ball.dy = dy;
    paddle.center = CGPointMake(160, 449);
    paddleView.center = CGPointMake(160, 449);
    shouldAnimate = YES;
}

- (void)getNewVelocity
{
    //stub
    dx = 5;
    dy = 5;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize timer
    ball =[[Ball alloc] initWithVelocity:CGPointMake(142.0, 245.0) :5 :5 ];
    ball.isReal = YES;
    //initialize dx and dy
    [self getNewVelocity];
    ball.dx = dx;//experiment with different values
    ball.dy = dy;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:nil repeats:YES];
   // timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:ball repeats:YES];
    [self.view addSubview:ball.ballImage];
    alertShown = NO;
    shouldAnimate = YES;
    balls = [[NSMutableArray alloc] init];
    [balls addObject:ball];
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
