//
//  ViewController.m
//  UIView+Copy-Example
//
//  Created by Pierre-Marc Airoldi on 2014-06-19.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "ViewController.h"
#import <UIView+Copy/UIView+Copy.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect top;
    CGRect bottom;
    
    [self getRects:&top bottomRect:&bottom];
   
    UIView *originalView = [[UIView alloc] initWithFrame:top];
    originalView.backgroundColor = [UIColor redColor];
    originalView.layer.borderColor = [UIColor blackColor].CGColor;
    originalView.layer.borderWidth = 2.0;
    
    /**** implementation ****/
    UIView *copiedView = [originalView pm_copy];
    /**** implementation ****/

    copiedView.frame = CGRectMake(CGRectGetMinX(bottom), CGRectGetMinY(bottom), CGRectGetWidth(copiedView.frame), CGRectGetHeight(copiedView.frame));
    
    UILabel *originalLabel = [[UILabel alloc] initWithFrame:top];
    originalLabel.textAlignment = NSTextAlignmentCenter;
    originalLabel.backgroundColor = [UIColor clearColor];
    originalLabel.text = @"Original";
    
    UILabel *copyLabel = [[UILabel alloc] initWithFrame:bottom];
    copyLabel.textAlignment = NSTextAlignmentCenter;
    copyLabel.backgroundColor = [UIColor clearColor];
    copyLabel.text = @"Copy";
    
    [self.view addSubview:originalView];
    [self.view addSubview:copiedView];
    
    [self.view addSubview:originalLabel];
    [self.view addSubview:copyLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
