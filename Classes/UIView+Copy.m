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
#define LAYER_PROPERTY @"layer"

@implementation UIView (Copy)

-(UIView *)pm_copy {
    
    BOOL isHighlighted = false;
    
    if (class_getProperty([self class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        if ([[self valueForKey:HIGHLIGHT_PROPERTY] isEqual: @(1)]) {
            isHighlighted = true;
        }
    }
    
    [self fixHighlighted:self];
    
    UIView *copiedView = [self copyObject:self];
    
    if (class_getProperty([self class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        [copiedView setValue:@(isHighlighted) forKey:HIGHLIGHT_PROPERTY];
    }
    
    [self copyProperitesFrom:self to:copiedView];
    
    [self handleSubviewsFrom:self to:copiedView];
    
    return copiedView;
}

-(id)copyObject:(id)object {
    
    NSData *tempArchivedView = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchivedView];
}

-(void)fixHighlighted:(UIView *)view {
    
    if (class_getProperty([view class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        [view setValue:@(0) forKey:HIGHLIGHT_PROPERTY];
    }
    
    for (UIView *subview in view.subviews) {
        
        [self fixHighlighted:subview];
    }
}

-(void)handleSubviewsFrom:(UIView *)original to:(UIView *)copy {
    
    for (UIView *subview in original.subviews) {
        
        UIView *copiedSubview = [self copyObject:subview];
        [self copyProperitesFrom:subview to:copiedSubview];
        
        [copy addSubview:copiedSubview];
        
        if (subview.subviews.count > 0) {
            [self handleSubviewsFrom:subview to:copiedSubview];
        }
    }
}

-(void)copyProperitesFrom:(UIView *)original to:(UIView *)copy {
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([copy class], &outCount);
    
    for (i = 0; i < outCount; i++) {
    	
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        id objectCopy;
        
        if ([[original valueForKey:propertyName] conformsToProtocol:@protocol(NSCopying)]) {
            objectCopy = [[original valueForKey:propertyName] copy];
        }
        
        else {
            objectCopy = [self copyObject:[original valueForKey:propertyName]];
        }
        
        @try {
            [copy setValue:objectCopy forKey:propertyName];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    free(properties);
}

@end
