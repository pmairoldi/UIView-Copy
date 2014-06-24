//
//  CircleView.m
//  UIView+Copy-Example
//
//  Created by Pierre-Marc Airoldi on 2014-06-24.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "CircleView.h"

@interface CircleView ()

@property UIImageView *imageView;

@end

@implementation CircleView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code

        CGRect frame = self.frame;
        frame.origin = CGPointZero;
        
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.path = [UIBezierPath bezierPathWithOvalInRect:frame].CGPath;
        
        self.layer.mask = mask;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = [UIImage imageNamed:@"image.jpg"];
        
        [self addSubview:_imageView];
    }

    return self;
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
