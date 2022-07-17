//
//  AdaptiveTextViewController.m
//  SizeClasses
//
//  Created by Nadezhda Zenkova on 30.06.2022.
//

#import "AdaptiveTextViewController.h"

@interface AdaptiveTextViewController ()
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation AdaptiveTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    NSString *startTitle = NSLocalizedString(@"Start", @"Start");
    [self.startButton setTitle:startTitle forState:UIControlStateNormal];
    
    NSString *stopTitle = NSLocalizedString(@"Abort", @"Abort button");
    [self.stopButton setTitle:stopTitle forState:UIControlStateNormal];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    if (self.traitCollection.verticalSizeClass != newCollection.verticalSizeClass) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.stackView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            UIViewPropertyAnimator *animator = [UIViewPropertyAnimator
                                                runningPropertyAnimatorWithDuration:0.3
                                                delay:0.0
                                                options:UIViewAnimationOptionCurveLinear
                                                animations:^{
                self.stackView.transform = CGAffineTransformIdentity;
            } completion:^(UIViewAnimatingPosition finalPosition) {
                
            }];
            
        }];
    }
}

@end
