#import <UIKit/UIKit.h>

@interface UIView (PMCopy)

/**
 *  Creates a copy of a view with needsDrawRect set to NO. See -(UIView *)pm_copyWithNeedsDrawRect:(BOOL)needsDrawRect for more information.
 *
 *  @return UIView copy
 */
-(UIView *)pm_copy;

/**
 *  Creates a copy of a view.
 *
 *  @param needsDrawRect setting needsDrawRect to YES will allow drawing that occurs in drawRect: happen but it will disable the view's mask layer. Setting it to NO will not draw things from drawRect: but will have the mask layer enabled.
 *
 *  @return UIView copy
 */
-(UIView *)pm_copyWithNeedsDrawRect:(BOOL)needsDrawRect;

/**
 *  Create a copy of a view with needsLayerProperties set to NO. See -(UIView *)pm_copyToImageWithLayerProperties:(BOOL)needsLayerProperties for more information.
 *
 *  @return UIView copy
 */
-(UIView *)pm_copyToImage NS_AVAILABLE_IOS(7_0);

/**
 *  Create a copy of a view and creates an image. Copies the layer properties for the superview if needsLayerProperties is set to YES (ie. borderColor, borderWidth...)
 *
 *  @return UIView copy
 */
-(UIView *)pm_copyToImageWithLayerProperties:(BOOL)needsLayerProperties  NS_AVAILABLE_IOS(7_0);

@end
