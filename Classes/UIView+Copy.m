//
//  UIView+UIView_Copy.m
//  Pods
//
//  Created by Pierre-Marc Airoldi on 2014-06-19.
//
//

#import "UIView+Copy.h"
#import <objc/runtime.h>

#define HIGHLIGHT_PROPERTY @"highlighted"

@implementation UIView (Copy)

-(UIView *)pm_copy {
    
    BOOL isHighlighted = false;
    
    if (class_getProperty([self class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        if ([[self valueForKey:HIGHLIGHT_PROPERTY] isEqual: @(1)]) {
            isHighlighted = true;
        }
    }
    
    [self fixHighlighted:self];
    
    NSData *tempArchivedView = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    UIView *copiedView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchivedView];
    
    if (class_getProperty([self class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        [copiedView setValue:@(isHighlighted) forKey:HIGHLIGHT_PROPERTY];
    }
    
    return copiedView;
}

-(void)fixHighlighted:(UIView *)view {
    
    if (class_getProperty([view class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        [view setValue:@(0) forKey:HIGHLIGHT_PROPERTY];
    }
    
    for (UIView *subview in view.subviews) {
        
        [self fixHighlighted:subview];
    }
}

@end
