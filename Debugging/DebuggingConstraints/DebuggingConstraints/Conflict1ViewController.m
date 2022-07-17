//
//  Conflict1ViewController.m
//  DebuggingConstraints
//
//  Created by Nadezhda Zenkova on 10.06.2022.
//

#import "UIView+AutoLayoutDebugging.h"
#import "Conflict1ViewController.h"

@interface Conflict1ViewController ()

@end

@implementation Conflict1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemPurpleColor];
    [self setupView];
}

- (void)setupView {
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // Always remember to disable the automatic translation
    // of the autoresizing mask into constraints!!
    //okButton.translatesAutoresizingMaskIntoConstraints = false;
    
    [okButton setTitle:@"Broken button" forState:UIControlStateNormal];
    okButton.accessibilityIdentifier = @"BrokenButton";
    self.view.accessibilityIdentifier = @"RootView";
    [self.view addSubview:okButton];
    
    NSArray *centerConstraints = @[
                             [okButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                             [okButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ];
    
    for (NSLayoutConstraint *constraint in centerConstraints) {
        constraint.identifier = @"BrokenButtonCenter";
    }
    
    [NSLayoutConstraint activateConstraints:centerConstraints];
}

@end
