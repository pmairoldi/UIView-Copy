//
//  UIView+UIView_Copy.h
//  Pods
//
//  Created by Pierre-Marc Airoldi on 2014-06-19.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Copy)

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

@end
