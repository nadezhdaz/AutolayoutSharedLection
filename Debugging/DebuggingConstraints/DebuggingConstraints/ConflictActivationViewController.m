//
//  ConflictActivationViewController.m
//  DebuggingConstraints
//
//  Created by Nadezhda Zenkova on 16.06.2022.
//

#import "LoopView.h"
#import "UIView+AutoLayoutDebugging.h"
#import "ConflictActivationViewController.h"

@interface ConflictActivationViewController ()

@property (nonatomic, retain) UIButton *updateButton;
@property (nonatomic, retain) UIView *greenView;
@property (nonatomic, retain) UIView *redView;
@property (nonatomic, retain) LoopView *loopView;

@end

@implementation ConflictActivationViewController

- (UIButton *)updateButton {
    if (!_updateButton) {
        _updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _updateButton.translatesAutoresizingMaskIntoConstraints = false;
        [_updateButton setTitle:@"Update" forState:UIControlStateNormal];
        [_updateButton addTarget:self action:@selector(update) forControlEvents:UIControlEventTouchUpInside];
        _updateButton.accessibilityIdentifier = @"UpdateButton";
    }
    return _updateButton;
}

- (UIView *)greenView {
    if (!_greenView) {
        _greenView = [UIView new];
        [_greenView setBackgroundColor:[UIColor systemGreenColor]];
        _greenView.accessibilityIdentifier = @"GreenView";
        _greenView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _greenView;
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [UIView new];
        [_redView setBackgroundColor:[UIColor systemRedColor]];
        _redView.accessibilityIdentifier = @"RedView";
        _redView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _redView;
}

- (LoopView *)loopView {
    if (!_loopView) {
        _loopView = [LoopView new];
        [_loopView setBackgroundColor:[UIColor systemGrayColor]];
        _loopView.accessibilityIdentifier = @"LoopView";
        _loopView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _loopView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.greenView.layer.cornerRadius = self.greenView.bounds.size.width / 25;
    
    // The following line is a mistake that causes a
    // layout loop
    [self.view setNeedsLayout];
    
    //puts("called");
}

- (NSArray <NSLayoutConstraint *>*)greenPriorityConstraints {
    return @[
    [self.greenView.widthAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.widthAnchor multiplier:1.0],
    [self.redView.widthAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.widthAnchor multiplier:0.25]
    ];
}

- (NSArray <NSLayoutConstraint *>*)redPriorityConstraints {
    [self.greenView constraintsAffectingLayoutForAxis:UILayoutConstraintAxisHorizontal];
    return @[
        [self.greenView.widthAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.widthAnchor multiplier:0.25],
        [self.redView.widthAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.widthAnchor multiplier:1.0]
    ];
}

- (NSArray <NSLayoutConstraint *>*)commonConstraints {
    return @[
        [self.updateButton.centerXAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.centerXAnchor],
        [self.updateButton.topAnchor constraintEqualToSystemSpacingBelowAnchor:self.view.layoutMarginsGuide.topAnchor multiplier:2.0],
        
        [self.greenView.centerXAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.centerXAnchor],
        [self.greenView.topAnchor constraintEqualToSystemSpacingBelowAnchor:self.updateButton.bottomAnchor multiplier:2.0],
        [self.greenView.heightAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.heightAnchor multiplier:0.2],
        
        [self.redView.centerXAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.centerXAnchor],
        [self.redView.topAnchor constraintEqualToSystemSpacingBelowAnchor:self.greenView.bottomAnchor multiplier:2.0],
        [self.redView.heightAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.heightAnchor multiplier:0.2],
        
        //[self.loopView.topAnchor constraintEqualToSystemSpacingBelowAnchor:self.redView.bottomAnchor multiplier:2.0],
        //[self.loopView.centerXAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.centerXAnchor],
        //[self.loopView.heightAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.heightAnchor multiplier:0.2],
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemTealColor];
    [self setupViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self.view printAutoLayoutTrace];
    [self.view exerciseAmbiguityInLayoutRepeatedly:YES];
}

- (void)setupViews {
    self.view.accessibilityIdentifier = @"RootView";
    
    [self.view addSubview:self.updateButton];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.redView];
    //[self.view addSubview:self.loopView];
    
    NSMutableArray *initialConstraints = [NSMutableArray arrayWithArray:[self commonConstraints]];
    [initialConstraints addObjectsFromArray:[self greenPriorityConstraints]];
    
    [NSLayoutConstraint activateConstraints:initialConstraints];
    [self.view printAutoLayoutTrace];
    //[self.view checkAmbiguousLayoutWithSubviews];
}

- (void)update{
    // Forgetting to deactivate first creates a conflict
    // [NSLayoutConstraint deactivateConstraints:[self greenPriorityConstraints]];
    [NSLayoutConstraint activateConstraints:[self redPriorityConstraints]];
}

@end
