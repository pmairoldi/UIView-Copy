//  UIView+UIView_Copy.m
//  Pods
//
//  Created by Pierre-Marc Airoldi on 2014-06-19.
//
//

#import "UIView+Copy.h"
#import "UIViewHelpers.h"

@implementation UIView (Copy)

-(UIView *)pm_copy {
    
    UIView *copiedView = [UIViewHelpers viewCopy:self needsDrawRect:NO];
    
    [UIViewHelpers handleSubviewsFrom:self to:copiedView needsDrawRect:NO];
    
    return copiedView;
}

-(UIView *)pm_copyWithNeedsDrawRect:(BOOL)needsDrawRect {
    
    UIView *copiedView = [UIViewHelpers viewCopy:self needsDrawRect:needsDrawRect];
    
    [UIViewHelpers handleSubviewsFrom:self to:copiedView needsDrawRect:needsDrawRect];
    
    return copiedView;
}

-(UIView *)pm_copyToImage {
    
    return [self pm_copyToImageWithLayerProperties:NO];
}

-(UIView *)pm_copyToImageWithLayerProperties:(BOOL)needsLayerProperties {

    if (needsLayerProperties) {
        
        UIView *copiedView = [self snapshotViewAfterScreenUpdates:YES];
        
        [UIViewHelpers layerCopyFromView:self toView:copiedView];
        
        return copiedView;
    }
    
    else {
        return [self snapshotViewAfterScreenUpdates:YES];
    }
}

@end
