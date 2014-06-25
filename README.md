# UIView+Copy

[![Version](https://img.shields.io/cocoapods/v/UIView+Copy.svg?style=flat)](http://cocoadocs.org/docsets/UIView+Copy)
[![License](https://img.shields.io/cocoapods/l/UIView+Copy.svg?style=flat)](http://cocoadocs.org/docsets/UIView+Copy)
[![Platform](https://img.shields.io/cocoapods/p/UIView+Copy.svg?style=flat)](http://cocoadocs.org/docsets/UIView+Copy)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

	#import <UIView+Copy/UIView+Copy.h>

	//If you need drawRect: drawing
	UIView *copiedView = [originalView pm_copy];

	//if you need mask layer property
    UIView *copiedViewWithDrawRect = (UIView *)[originalView pm_copyWithNeedsDrawRect:YES];

## Requirements
	
	iOS 6.0+ and ARC. 

## Installation

UIView+Copy is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "UIView+Copy"

## Author

pierremarcairoldi, pierremarcairoldi@gmail.com

## License

UIView+Copy is available under the MIT license. See the LICENSE file for more info.

