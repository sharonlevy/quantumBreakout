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
@synthesize tree;

- (void)AnimateBall:(NSTimer *)time{
    if(shouldAnimate){
        balls = [tree getBallArray];
        if([balls count]>12){
            [self win];
        }
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
    //sides of paddle
    if(CGRectIntersectsRect(thisBall.ballImage.frame, CGRectMake(paddle.frame.origin.x, paddle.frame.origin.y, 1, paddle.frame.size.height))){
        thisBall.dx = -abs(thisBall.dx);
    }
    if(CGRectIntersectsRect(thisBall.ballImage.frame, CGRectMake(paddle.frame.origin.x + paddle.frame.size.width, paddle.frame.origin.y, 1, paddle.frame.size.height))){
        thisBall.dx = abs(thisBall.dx);
    }
    //top of paddle
    if(CGRectIntersectsRect(thisBall.ballImage.frame, CGRectMake(paddle.frame.origin.x + 1, paddle.frame.origin.y, paddle.frame.size.width - 2, 1))){
        thisBall.dy = -abs(thisBall.dy);
    }
    //beamsplitter
    if(CGRectIntersectsRect(thisBall.ballImage.frame, beamSplitter.frame)) {
        if (thisBall.intersectsSplitter == NO) {
            thisBall.intersectsSplitter = YES;
            Ball * newBall = [tree splitBall:thisBall];
            [self.view.superview addSubview:newBall.ballImage];
        }
    }
    if(!CGRectIntersectsRect(thisBall.ballImage.frame, beamSplitter.frame)) {
        thisBall.intersectsSplitter = NO;
    }

}

-(void)splitBalls:(Ball *)thisBall {
   /* if(thisBall.dx > 0){
        dx = 3 + arc4random()%3;
    }else{
        dx = -6 + arc4random()%3;
    }
    if (thisBall.dy< 0) {
        dy = 3 + arc4random()%3;
    }
    else {
        dy = -6 + arc4random()%3;
    } */
    Ball *testBall = [[Ball alloc] initWithVelocity:thisBall.ballImage.center :thisBall.dx :(-1) * thisBall.dy];
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
    //thisBall.ballImage.layer.opacity -= 0.1;
    //testBall.ballImage.layer.opacity = thisBall.ballImage.layer.opacity;
    [thisBall decrementOpacity];
    [testBall matchOpacity:thisBall];
    [balls addObject:testBall];
    [self.view.superview addSubview:testBall.ballImage];
}

-(void)addPoints {
    score +=10;
}

-(void)lose{
    //NSInteger adjustedScore = score/10;
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"SCORE"
                              message:[NSString stringWithFormat:@"%d", score]
                              delegate:self
                              cancelButtonTitle:@"Play Again!"
                              otherButtonTitles:nil];
    
    [alertView show];
    //[timer invalidate];
    shouldAnimate = NO;
   
}

-(void)win{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"You Win!"
                              message:[NSString stringWithFormat:@"%d", score]
                              delegate:self
                              cancelButtonTitle:@"Next Level!"
                              otherButtonTitles:nil];
    
    [alertView show];
    dy++;
    //[timer invalidate];
    shouldAnimate = NO;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    for (int i = [balls count]-1; i>=0; i--) {
        [[[balls objectAtIndex:i] ballImage] removeFromSuperview];
       // [balls removeObjectAtIndex:i];
     }
    [tree deleteTree];
    [self getNewVelocity];
    ball =[[Ball alloc] initWithVelocity:CGPointMake(142.0, 245.0) :dx :dy ];
    ball.ballImage.center = CGPointMake(self.view.center.x,self.view.center.y);
    alertShown = NO;
    ball.intersectsSplitter = NO;
    ball.isReal = YES;
    [self.view addSubview:ball.ballImage];
    //initialize dx and dy
    [ball resetOpacity];
    paddle.center = CGPointMake(160, 449);
    paddleView.center = CGPointMake(160, 449);
    shouldAnimate = YES;
    score = 0;
    tree = [[BallTree alloc] init:ball];
}

- (void)getNewVelocity
{
    int maybe = arc4random()%2;
    if(maybe == 0){
        dx = dy - 3 + arc4random()%3;
    }else{
        dx = -dy + arc4random()%3;
    }
    //dy = 3 + arc4random()%3;
    //dy = 7;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize timer
    dy = 5;
    [self getNewVelocity];
    ball =[[Ball alloc] initWithVelocity:CGPointMake(142.0, 245.0) :dx :dy ];
    ball.isReal = YES;
    //initialize dx and dy
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:nil repeats:YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addPoints)  userInfo:nil repeats:YES];
    [self.view addSubview:ball.ballImage];
    alertShown = NO;
    shouldAnimate = YES;
    balls = [[NSMutableArray alloc] init];
   // [balls addObject:ball];
    score = 0;
    tree = [[BallTree alloc] init:ball];
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
