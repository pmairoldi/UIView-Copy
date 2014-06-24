
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
#define LOGS 0

@implementation UIView (Copy)

-(UIView *)pm_copy {
    
    UIView *copiedView = [[self class] copyView:self needsDrawRect:NO];
    
    [[self class] handleSubviewsFrom:self to:copiedView needsDrawRect:NO];
    
    return copiedView;
}

-(UIView *)pm_copyWithNeedsDrawRect:(BOOL)needsDrawRect {
    
    UIView *copiedView = [[self class] copyView:self needsDrawRect:needsDrawRect];
    
    [[self class] handleSubviewsFrom:self to:copiedView needsDrawRect:needsDrawRect];
    
    return copiedView;
}

+(UIView *)copyView:(UIView *)view needsDrawRect:(BOOL)needsDrawRect {
    
    [self fixHighlighted:view];
    
    UIView *copiedView = [self copyObject:view];
    
    if (!needsDrawRect) {
        CALayer *copiedLayer = [self copyObject:view.layer];
        [copiedView setValue:copiedLayer forKey:LAYER_PROPERTY];
    }
    
    else {
        [self setLayerPropertiesFrom:view.layer to:copiedView.layer isMask:NO];
    }
    
    [self setHighlighted:[self getHighlighted:view] forView:copiedView];
    [self copyPropertiesFrom:view to:copiedView];
    
    return copiedView;
}

+(id)copyObject:(id)object {
    
    NSData *tempArchivedView = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchivedView];
}

+(void)fixHighlighted:(UIView *)view {
    
    if (class_getProperty([view class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        [view setValue:@(0) forKey:HIGHLIGHT_PROPERTY];
    }
}

+(BOOL)getHighlighted:(UIView *)view {
    
    BOOL isHighlighted = false;
    
    if (class_getProperty([view class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        if ([[view valueForKey:HIGHLIGHT_PROPERTY] isEqual: @(1)]) {
            isHighlighted = true;
        }
    }
    
    return isHighlighted;
}

+(void)setHighlighted:(BOOL)isHighlighted forView:(UIView *)view{
    
    if (class_getProperty([view class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        [view setValue:@(isHighlighted) forKey:HIGHLIGHT_PROPERTY];
    }
}

+(void)handleSubviewsFrom:(UIView *)original to:(UIView *)copy needsDrawRect:(BOOL)needsDrawRect {
    
    for (UIView *subview in original.subviews) {
        
        UIView *copiedView = [self copyView:subview needsDrawRect:needsDrawRect];
        
        if (subview.subviews.count > 0) {
            [self handleSubviewsFrom:subview to:copiedView needsDrawRect:needsDrawRect];
        }
    }
}

+(NSArray *)exludeLayerProperties {
    
    return @[@"superlayer", @"sublayers"];
}

+(NSArray *)copyLayerProperties {
    
    return @[@"contentsGravity", @"minificationFilter", @"magnificationFilter", @"filters", @"backgroundFilters", @"actions", @"name", @"style"];
}

+(NSArray *)layerProperties {
    
    return @[@"mask"];
}

+(void)setLayerPropertiesFrom:(CALayer *)original to:(CALayer *)copy isMask:(BOOL)isMask {
    
    NSArray *exludeProperties = [self exludeLayerProperties];
    NSArray *copyProperties = [self copyLayerProperties];
    NSArray *layerProperties = [self layerProperties];

    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([copy class], &outCount);
    
    for (i = 0; i < outCount; i++) {
    	
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        if ([exludeProperties containsObject:propertyName]) {
            continue;
        }
        
        else if ([layerProperties containsObject:propertyName] && !isMask) {
            
            id copiedValue = [self copyObject:[original valueForKey:propertyName]];
            
            if (copiedValue != nil) {
                
                [copy setValue:copiedValue forKey:propertyName];
                
                [self setLayerPropertiesFrom:original.mask to:copy.mask isMask:YES];
            }
        }
        
        else if ([copyProperties containsObject:propertyName]) {
            
            id value = [[original valueForKey:propertyName] copy];
            
            [copy setValue:value forKey:propertyName];
        }

        else {
            
            id value = [original valueForKey:propertyName];
            
            [copy setValue:value forKey:propertyName];
        }
    }
    
    free(properties);
}

+(void)copyPropertiesFrom:(id)original to:(id)copy {
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([copy class], &outCount);
    
    for (i = 0; i < outCount; i++) {
    	
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        id objectCopy = nil;
        
        @try {
            
            id objectProperty = [original valueForKey:propertyName];
            
            if ([objectProperty conformsToProtocol:@protocol(NSCopying)]) {
                objectCopy = [[original valueForKey:propertyName] copy];
            }
            
            else {
                objectCopy = [self copyObject:objectProperty];
            }
        }
        @catch (NSException *exception) {
            
#if LOGS == 1
            NSLog(@"%@", [exception description]);
#endif
        }
        @finally {
            
        }
        
        @try {
            
            if (objectCopy != nil) {
                [copy setValue:objectCopy forKey:propertyName];
            }
        }
        @catch (NSException *exception) {
            
#if LOGS == 1
            NSLog(@"%@", [exception description]);
#endif
        }
        @finally {
            
        }
    }
    
    free(properties);
}

@end
