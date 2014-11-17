//
//  ViewController.m
//  Example
//
//  Created by Pierre-Marc Airoldi on 2014-11-16.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import <UIView+Copy/UIView+PMCopy.h>

@interface ViewController ()

@property CustomView *copiedView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect top;
    CGRect bottom;
    
    [self getRects:&top bottomRect:&bottom];
    
    CustomView *originalView = [[CustomView alloc] initWithFrame:top];
    
    [self.view addSubview:originalView];
    
    /**** implementation ****/
    
    double startTime = CACurrentMediaTime();
    
#ifdef NEEDS_DRAW_RECT
    _copiedView = (CustomView *)[originalView pm_copyWithNeedsDrawRect:YES]; //YES:0.006631 NO:0.128084
#elif IMAGE
    _copiedView = (CustomView *)[originalView pm_copyToImageWithLayerProperties:YES]; //YES:0.087293 NO:0.033197
#else
    _copiedView = (CustomView *)[originalView pm_copy]; //0.128084
#endif
    
    _copiedView.backgroundColor = [UIColor redColor];
    
    NSLog(@"%f", CACurrentMediaTime() - startTime);
    
    /**** implementation ****/
    
    [self.view addSubview:_copiedView];
    
    _copiedView.frame = CGRectMake(CGRectGetMinX(bottom), CGRectGetMinY(bottom), CGRectGetWidth(_copiedView.frame), CGRectGetHeight(_copiedView.frame));
    
    [self addText:@"Original" toView:originalView];
    [self addText:@"Copy" toView:_copiedView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addText:(NSString *)text toView:(UIView *)view {
    
    CGRect frame = view.frame;
    frame.origin = CGPointZero;
    
    UILabel *originalLabel = [[UILabel alloc] initWithFrame:frame];
    originalLabel.textAlignment = NSTextAlignmentCenter;
    originalLabel.backgroundColor = [UIColor clearColor];
    originalLabel.text = text;
    
    [view addSubview:originalLabel];
}

-(void)getRects:(CGRect *)top bottomRect:(CGRect *)bottom {
    
    CGRect frame = self.view.frame;
    frame.origin = CGPointZero;
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        frame.origin.y += 20;
        frame.size.height -= 20;
    }
    
    CGRectDivide(frame, top, bottom, CGRectGetHeight(frame)/2, CGRectMinYEdge);
    
    top->origin.x += 5;
    top->origin.y += 5;
    top->size.width -= 10;
    top->size.height -= 10;
    
    bottom->origin.x += 5;
    bottom->origin.y += 5;
    bottom->size.width -= 10;
    bottom->size.height -= 10;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1ull * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        color.fromValue = (id)[UIColor blackColor].CGColor;
        color.toValue   = (id)[UIColor redColor].CGColor;
        color.fillMode = kCAFillModeForwards;
        color.removedOnCompletion = NO;
        color.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        [_copiedView.layer addAnimation:color forKey:@"color"];
    });
}

@end
