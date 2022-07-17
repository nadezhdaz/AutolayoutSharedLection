//
//  IBErrorsViewController.m
//  DebuggingConstraints
//
//  Created by Nadezhda Zenkova on 10.06.2022.
//

#import "UIView+AutoLayoutDebugging.h"
#import "IBErrorsViewController.h"

@interface IBErrorsViewController ()

// UIScreen, UIWindow, UIViewController
// UIView, UIPresentationController
@property(nonatomic, readonly) UITraitCollection *traitCollection;

@property (weak, nonatomic) IBOutlet UIView *blueLoopView;

@end

@implementation IBErrorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.blueLoopView.layer.cornerRadius = self.blueLoopView.bounds.size.width / 25;
    
    // The following line is a mistake that causes a
    // layout loop
    //[self.view setNeedsLayout];
    
    puts("called");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
