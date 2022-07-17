//
//  UIView+AutoLayoutDebugging.m
//  DebuggingConstraints
//
//  Created by Nadezhda Zenkova on 20.06.2022.
//

#import "UIView+AutoLayoutDebugging.h"

@implementation UIView (AutoLayoutDebugging)

- (void)checkAmbiguousLayoutWithSubviews {
#ifdef DEBUG
    for (UIView *subview in self.subviews) {
        BOOL isAmbiguous = subview.hasAmbiguousLayout;
        [subview checkAmbiguousLayoutWithSubviews];
    }
#endif
}

- (void)printAutoLayoutTrace {
#ifdef DEBUG
    NSLog(@"%@", [self performSelector:@selector(_autolayoutTrace)]);
#endif
}

- (void)exerciseAmbiguityInLayoutRepeatedly:(BOOL)recursive {
#ifdef DEBUG
    if (self.hasAmbiguousLayout) {
        [NSTimer scheduledTimerWithTimeInterval:.5
                                         target:self
                                       selector:@selector(exerciseAmbiguityInLayout)
                                       userInfo:nil
                                        repeats:YES];
    }
    if (recursive) {
        for (UIView *subview in self.subviews) {
            [subview exerciseAmbiguityInLayoutRepeatedly:YES];
        }
    }
#endif
}

@end
