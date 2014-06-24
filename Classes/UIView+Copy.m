
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
    
    UIView *copiedView = [self copyView:self];
    
    [self handleSubviewsFrom:self to:copiedView];
    
    return copiedView;
}

-(UIView *)copyView:(UIView *)view {
    
    [self fixHighlighted:view];
    
    UIView *copiedView = [self copyObject:view];
    
    [self setLayerPropertiesFrom:view.layer to:copiedView.layer];

    [self setHighlighted:[self getHighlighted:view] forView:copiedView];
    [self copyPropertiesFrom:view to:copiedView];
    
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
}

-(BOOL)getHighlighted:(UIView *)view {
    
    BOOL isHighlighted = false;
    
    if (class_getProperty([view class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        if ([[view valueForKey:HIGHLIGHT_PROPERTY] isEqual: @(1)]) {
            isHighlighted = true;
        }
    }
    
    return isHighlighted;
}

-(void)setHighlighted:(BOOL)isHighlighted forView:(UIView *)view{
    
    if (class_getProperty([view class], [HIGHLIGHT_PROPERTY UTF8String]) != NULL) {
        
        [view setValue:@(isHighlighted) forKey:HIGHLIGHT_PROPERTY];
    }
}

-(void)handleSubviewsFrom:(UIView *)original to:(UIView *)copy {
    
    for (UIView *subview in original.subviews) {
        
        UIView *copiedView = [self copyView:subview];
        
        if (subview.subviews.count > 0) {
            [self handleSubviewsFrom:subview to:copiedView];
        }
    }
}

-(void)setLayerPropertiesFrom:(CALayer *)original to:(CALayer *)copy {

    copy.bounds = original.bounds;
    copy.position = original.position;
    copy.zPosition = original.zPosition;
    copy.anchorPoint = original.anchorPoint;
    copy.transform = original.transform;
    copy.frame = original.frame;
    copy.hidden = original.hidden;
    copy.doubleSided = original.doubleSided;
    copy.geometryFlipped = original.geometryFlipped;
//    copy.superlayer = original.superlayer;
//    copy.sublayers = [original.sublayers copy];
    copy.sublayerTransform = original.sublayerTransform;
    copy.mask = [self copyObject:original.mask]; // needs to copy
    copy.masksToBounds = original.masksToBounds;
    copy.contents = original.contents;
    copy.contentsRect = original.contentsRect;
    copy.contentsGravity = [original.contentsGravity copy];
    copy.contentsScale = original.contentsScale;
    copy.contentsCenter = original.contentsCenter;
    copy.minificationFilter = [original.minificationFilter copy];
    copy.magnificationFilter = [original.magnificationFilter copy];
    copy.minificationFilterBias = original.minificationFilterBias;
    copy.opaque = copy.opaque;
    copy.needsDisplayOnBoundsChange = original.needsDisplayOnBoundsChange;
    copy.drawsAsynchronously = original.drawsAsynchronously;
    copy.edgeAntialiasingMask = original.edgeAntialiasingMask;
    copy.allowsEdgeAntialiasing = original.allowsEdgeAntialiasing;
    copy.backgroundColor = original.backgroundColor;
    copy.cornerRadius = original.cornerRadius;
    copy.borderWidth = original.borderWidth;
    copy.borderColor = original.borderColor;
    copy.opacity = original.opacity;
    copy.allowsGroupOpacity = original.allowsGroupOpacity;
    copy.compositingFilter = original.compositingFilter;
    copy.filters = [original.filters copy];
    copy.backgroundFilters = [original.backgroundFilters copy];
    copy.shouldRasterize = original.shouldRasterize;
    copy.rasterizationScale = original.rasterizationScale;
    copy.shadowColor = original.shadowColor;
    copy.shadowOpacity = original.shadowOpacity;
    copy.shadowOffset = original.shadowOffset;
    copy.shadowRadius = original.shadowRadius;
    copy.shadowPath = original.shadowPath;
    copy.actions = [original.actions copy];
    copy.name = [original.name copy];
    copy.delegate = original.delegate;
    copy.style = [original.style copy];

}

-(void)copyPropertiesFrom:(id)original to:(id)copy {
    
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
            
            NSLog(@"%@", [exception description]);
        }
        @finally {
            
        }

        @try {
            
            if (objectCopy != nil) {
                [copy setValue:objectCopy forKey:propertyName];
            }
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@", [exception description]);
        }
        @finally {
            
        }
    }
    
    free(properties);
}

@end
