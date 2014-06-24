//
//  ViewController.m
//  UIView+Copy-Example
//
//  Created by Pierre-Marc Airoldi on 2014-06-19.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import <UIView+Copy/UIView+Copy.h>

@interface ViewController ()


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
    CustomView *copiedView = (CustomView *)[originalView pm_copy];
    /**** implementation ****/

    [self.view addSubview:copiedView];
    
    copiedView.frame = CGRectMake(CGRectGetMinX(bottom), CGRectGetMinY(bottom), CGRectGetWidth(copiedView.frame), CGRectGetHeight(copiedView.frame));
    
    [self addText:@"Original" toView:originalView];
    [self addText:@"Copy" toView:copiedView];
    
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

@end
