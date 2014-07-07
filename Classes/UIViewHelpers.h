//
//  UIView-Helpers.h
//  Pods
//
//  Created by Pierre-Marc Airoldi on 2014-07-07.
//
//

#import <Foundation/Foundation.h>

@interface UIViewHelpers : NSObject

+(UIView *)viewCopy:(UIView *)view needsDrawRect:(BOOL)needsDrawRect;

+(id)objectCopy:(id)object;

+(void)fixHighlighted:(UIView *)view;

+(BOOL)getHighlighted:(UIView *)view;

+(void)setHighlighted:(BOOL)isHighlighted forView:(UIView *)view;

+(void)handleSubviewsFrom:(UIView *)original to:(UIView *)copy needsDrawRect:(BOOL)needsDrawRect;

+(NSArray *)layerPropertiesToExclude;

+(NSArray *)layerPropertiesToCopy;

+(NSArray *)layerProperties;

+(void)setLayerPropertiesFrom:(CALayer *)original to:(CALayer *)copy isMask:(BOOL)isMask;

+(void)propertiesCopyFrom:(id)original to:(id)copy;

+(void)layerCopyFromView:(UIView *)original toView:(UIView *)copied;

@end
