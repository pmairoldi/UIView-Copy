#import "UIView+PMCopy.h"
#import "PMUIViewHelpers.h"

@implementation UIView (PMCopy)

-(UIView *)pm_copy {
    
    UIView *copiedView = [PMUIViewHelpers viewCopy:self needsDrawRect:NO];
    
    [PMUIViewHelpers handleSubviewsFrom:self to:copiedView needsDrawRect:NO];
    
    return copiedView;
}

-(UIView *)pm_copyWithNeedsDrawRect:(BOOL)needsDrawRect {
    
    UIView *copiedView = [PMUIViewHelpers viewCopy:self needsDrawRect:needsDrawRect];
    
    [PMUIViewHelpers handleSubviewsFrom:self to:copiedView needsDrawRect:needsDrawRect];
    
    return copiedView;
}

-(UIView *)pm_copyToImage {
    
    return [self pm_copyToImageWithLayerProperties:NO];
}

-(UIView *)pm_copyToImageWithLayerProperties:(BOOL)needsLayerProperties {

    if (needsLayerProperties) {
        
        UIView *copiedView = [self snapshotViewAfterScreenUpdates:YES];
        
        [PMUIViewHelpers layerCopyFromView:self toView:copiedView];
        
        return copiedView;
    }
    
    else {
        return [self snapshotViewAfterScreenUpdates:YES];
    }
}

@end
