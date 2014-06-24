//
//  ProgressView.m
//  UIView+Copy-Example
//
//  Created by Pierre-Marc Airoldi on 2014-06-24.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "ProgressView.h"
#import "CircleView.h"

@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        self.opaque = NO;
        
        CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        
        [self addSubview:circleView];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef color = CGColorRetain([UIColor blueColor].CGColor);
    
    CGContextSetFillColorWithColor(context, color);

    CGContextFillEllipseInRect(context, rect);
    
    CGColorRelease(color);
}

@end
