//
//  ViewController.m
//  DebuggingConstraints
//
//  Created by Nadezhda Zenkova on 09.06.2022.
//


#import "IBErrorsViewController.h"
#import "Conflict1ViewController.h"
#import "ConflictActivationViewController.h"
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) UIStackView *stackView;

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    [self configureViewFor:self.traitCollection];
}

- (void)setupView {
    UIStackView *stackView = [[UIStackView alloc] init];
    //stackView.axis = UILayoutConstraintAxisVertical;
    //stackView.spacing = 40.0;
    //stackView.alignment = UIStackViewAlignmentFill;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView = stackView;
    [self.view addSubview:stackView];
    [NSLayoutConstraint activateConstraints:@[
        [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stackView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor],
        [stackView.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor],
        //[stackView.topAnchor constraintGreaterThanOrEqualToAnchor:self.view.topAnchor],
        //[stackView.bottomAnchor constraintLessThanOrEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    UIButton *openIBErrorsVCButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [openIBErrorsVCButton addTarget:self
                              action:@selector(openIBErrorsVC)
                    forControlEvents:UIControlEventTouchUpInside];
    [openIBErrorsVCButton setTitle:@"Interface Builder Errors" forState:UIControlStateNormal];
    openIBErrorsVCButton.frame = CGRectMake(0.0, 0.0, 160.0, 40.0);
    openIBErrorsVCButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    openIBErrorsVCButton.titleLabel.numberOfLines = 0;
    openIBErrorsVCButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    openIBErrorsVCButton.titleLabel.adjustsFontForContentSizeCategory = true;
    [stackView addArrangedSubview:openIBErrorsVCButton];
    
    UIButton *openConflict1VCButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [openConflict1VCButton addTarget:self
                          action:@selector(openConflict1VC)
                forControlEvents:UIControlEventTouchUpInside];
    [openConflict1VCButton setTitle:@"Conflicting constraints 1" forState:UIControlStateNormal];
    openConflict1VCButton.frame = CGRectMake(0.0, 0.0, 160.0, 40.0);
    openConflict1VCButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    openConflict1VCButton.titleLabel.numberOfLines = 0;
    openConflict1VCButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    openConflict1VCButton.titleLabel.adjustsFontForContentSizeCategory = true;
    [stackView addArrangedSubview:openConflict1VCButton];
    
    UIButton *openConflict2VCButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [openConflict2VCButton addTarget:self
                              action:@selector(openConflict2VC)
                    forControlEvents:UIControlEventTouchUpInside];
    [openConflict2VCButton setTitle:@"Conflicting constraints 2" forState:UIControlStateNormal];
    openConflict2VCButton.frame = CGRectMake(0.0, 0.0, 160.0, 40.0);
    openConflict2VCButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    openConflict2VCButton.titleLabel.numberOfLines = 0;
    openConflict2VCButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    openConflict2VCButton.titleLabel.adjustsFontForContentSizeCategory = true;
    [stackView addArrangedSubview:openConflict2VCButton];
}

-(void)openIBErrorsVC {
    [self.navigationController pushViewController:[IBErrorsViewController new] animated:YES];
}

-(void)openConflict1VC {
    [self.navigationController pushViewController:[Conflict1ViewController new] animated:YES];
}

-(void)openConflict2VC {
    [self.navigationController pushViewController:[ConflictActivationViewController new] animated:YES];
}

// MARK: - Trait Collection

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (previousTraitCollection.verticalSizeClass != self.traitCollection.verticalSizeClass) {
        [self configureViewFor:self.traitCollection];
    }
}

- (void)configureViewFor:(UITraitCollection *)traitCollection {
    UIContentSizeCategory contentSize = traitCollection.preferredContentSizeCategory;
    if (traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact && !(UIContentSizeCategoryIsAccessibilityCategory(contentSize))) {
        self.stackView.axis = UILayoutConstraintAxisHorizontal;
        self.stackView.spacing = 10.0;
    } else if (traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        self.stackView.axis = UILayoutConstraintAxisVertical;
        self.stackView.spacing = 10.0;
    } else {
        self.stackView.axis = UILayoutConstraintAxisVertical;
        self.stackView.spacing = 40.0;
    }
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

// MARK: - Trait Collection Dynamic Type
/*
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (previousTraitCollection.preferredContentSizeCategory != self.traitCollection.preferredContentSizeCategory) {
        [self configureViewFor:self.traitCollection];
    }
}

- (void)configureViewFor:(UITraitCollection *)traitCollection {
    UIContentSizeCategory contentSize = traitCollection.preferredContentSizeCategory;
    if (traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact && !(UIContentSizeCategoryIsAccessibilityCategory(contentSize))) {
        self.stackView.axis = UILayoutConstraintAxisHorizontal;
        self.stackView.spacing = 10.0;
    } else if (traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        self.stackView.axis = UILayoutConstraintAxisVertical;
        self.stackView.spacing = 10.0;
    } else {
        self.stackView.axis = UILayoutConstraintAxisVertical;
        self.stackView.spacing = 40.0;
    }
}

*/
@end
