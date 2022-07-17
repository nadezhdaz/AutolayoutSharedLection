//
//  LoopView.m
//  DebuggingConstraints
//
//  Created by Nadezhda Zenkova on 20.06.2022.
//

#import "LoopView.h"

@implementation LoopView

-(void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsLayout];
}

@end
