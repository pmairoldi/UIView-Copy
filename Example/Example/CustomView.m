//
//  CustomView.m
//  UIView+Copy-Example
//
//  Created by Pierre-Marc Airoldi on 2014-06-24.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        self.layer.cornerRadius = 10.0;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        
        CGRect top;
        CGRect bottom;
        
        [self getRects:&top bottomRect:&bottom];
        
        _circleView = [[CircleView alloc] initWithFrame:top];
        
        _progressView = [[ProgressView alloc] initWithFrame:bottom];
        
        [self addSubview:_circleView];
        [self addSubview:_progressView];
    }
    
    return self;
}

-(void)getRects:(CGRect *)top bottomRect:(CGRect *)bottom {
    
    CGRect frame = self.frame;
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
