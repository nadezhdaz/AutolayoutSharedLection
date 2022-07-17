//
//  UIView+AutoLayoutDebugging.h
//  DebuggingConstraints
//
//  Created by Nadezhda Zenkova on 20.06.2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AutoLayoutDebugging)

- (void)checkAmbiguousLayoutWithSubviews;
- (void)printAutoLayoutTrace;
- (void)exerciseAmbiguityInLayoutRepeatedly:(BOOL)recursive;

@end

NS_ASSUME_NONNULL_END
