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
  //  Ball *image =[time userInfo];
   // image.ballImage.center = CGPointMake(image.ballImage.center.x + image.dx, image.ballImage.center.y + image.dy);
    //handle collisions
    //put this in a loop
    for (int i = 0; i<[balls count]; i++) {
        Ball *current = [balls objectAtIndex:i];
        current.ballImage.center = CGPointMake(current.ballImage.center.x + current.dx, current.ballImage.center.y + current.dy);
        [self handleCollision:current];
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
    /*for (int i = 1; i<[balls count]; i++) {
        [[balls objectAtIndex:i] release];
    }
    */
    [timer invalidate];
    paddle.center = CGPointMake(160, 449);
    paddleView.center = CGPointMake(160, 449);
   
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    ball.ballImage.center = CGPointMake(self.view.center.x,self.view.center.y);
    alertShown = NO;
    ball.intersectsSplitter = NO;
    ball.isReal = YES;
   // [self startNewRound];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize timer
    ball =[[Ball alloc] initWithVelocity:CGPointMake(142.0, 245.0) :5 :5 ];
    ball.isReal = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:nil repeats:YES];
   // timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:ball repeats:YES];
    [self.view addSubview:ball.ballImage];
    //initialize dx and dy
    dx = 5;//experiment with different values
    dy = 5;
    alertShown = NO;
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
