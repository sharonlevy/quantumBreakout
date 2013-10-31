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
    Ball *image =[time userInfo];
    image.ballImage.center = CGPointMake(image.ballImage.center.x + image.dx, image.ballImage.center.y + image.dy);
    //handle collisions
    //put this in a loop
    [self handleCollision:image];

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
    if(ball.ballImage.center.y + ball.ballImage.bounds.size.height/2 > height){
        if (alertShown == NO) {
            [self lose];
            alertShown = YES;
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
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:testBall repeats:YES];
    //probably not going to use
  /*  UIImage *fakerBall = [UIImage imageNamed:@"ball.png"];
    UIImageView *fakeBall = [[UIImageView alloc] initWithImage:fakerBall];
    fakeBall.hidden = NO;
    fakeBall.frame = CGRectMake(50.0, 50.0, 100.0, 100.0);
    [self.view addSubview:fakeBall];
    newTime = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:fakeBall repeats:YES];
    [balls addObject:fakeBall];
    [balls objectAtIndex:0]; */
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
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    ball.ballImage.center = CGPointMake(self.view.center.x,self.view.center.y);
    alertShown = NO;
    ball.intersectsSplitter = NO;
   // [self startNewRound];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize timer
    ball =[[Ball alloc] initWithVelocity:CGPointMake(142.0, 245.0) :5 :5 ];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:ball repeats:YES];
   // timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(AnimateBall:)  userInfo:ball repeats:YES];
    [self.view addSubview:ball.ballImage];
    //initialize dx and dy
    dx = 5;//experiment with different values
    dy = 5;
    paddle.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 300);
    alertShown = NO;
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
