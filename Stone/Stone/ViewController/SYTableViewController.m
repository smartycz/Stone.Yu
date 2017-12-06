//
//  SYTableViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/12/5.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTableViewController.h"
#import "SYViewControllerTransitioningDelegate.h"
#import "SYTableViewPresentationController.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

typedef enum : NSInteger {
    Vertical,
    Horizontal
} PanDirection;

@interface PanDirectionGestureRecognizer : UIPanGestureRecognizer {
    PanDirection direction;
}

-(id)initWithTarget:(id)target action:(SEL)action andDirection:(PanDirection) panDirections;

@end

@implementation PanDirectionGestureRecognizer

-(id)initWithTarget:(id)target action:(SEL)action andDirection:(PanDirection) panDirections{
    if(self = [super initWithTarget:target action:action]){
        direction = panDirections;
    }
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if(self.state == UIGestureRecognizerStateBegan){
        CGPoint velocity =  [self velocityInView:self.view];
        switch (direction) {
            case Horizontal: {
                if (fabs(velocity.y) > fabs(velocity.x)) {
                    self.state = UIGestureRecognizerStateCancelled;
                }
            }
                break;
                
            case Vertical: {
                if (fabs(velocity.x) > fabs(velocity.y)) {
                    self.state = UIGestureRecognizerStateCancelled;
                }
            }
                break;
                
            default:
                break;
        }
    }
}

@end

@interface SYTableViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) SYViewControllerTransitioningDelegate *transitionDelegate;
@property (nonatomic, assign) CGRect originRect;

@end

@implementation SYTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.transitionDelegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"TableViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    PanDirectionGestureRecognizer *pan = [[PanDirectionGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:) andDirection:Horizontal];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    CGPoint translation = [panGestureRecognizer translationInView:UIApplication.sharedApplication.delegate.window];
    
    CGFloat left = self.view.left + translation.x;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (left <= Screen_Width - self.view.width * 3 / 4) {
            [UIView animateWithDuration:0.15 animations:^{
                self.view.left = Screen_Width / 2;
            }];
        } else {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
        return;
    }
    
    if (left <= Screen_Width - self.view.width) {
        return;
    }
    self.view.left = left;

    [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
//    if ([gestureRecognizer locationInView:self.view].x > 60) {
//        return NO;
//    }
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row + 1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (SYViewControllerTransitioningDelegate *)transitionDelegate
{
    if (!_transitionDelegate) {
        _transitionDelegate = [[SYViewControllerTransitioningDelegate alloc] initWithAnimationClassString:@"SYRightMoveToLeftTransitionAnimator" animatDuration:0.35 animatorDataSource:nil];
    }
    
    return _transitionDelegate;
}

@end
