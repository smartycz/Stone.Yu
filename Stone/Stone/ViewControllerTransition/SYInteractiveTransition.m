//
//  SYInteractiveTransition.m
//  Stone
//
//  Created by Stone.Yu on 2017/12/11.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYInteractiveTransition.h"
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

@interface SYInteractiveTransition ()

@property (nonatomic, weak) UIViewController *presentedViewController;
@property (nonatomic, strong) PanDirectionGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign) CGFloat fraction;

@end

@implementation SYInteractiveTransition

- (instancetype)init
{
    if (self = [super init]) {
        _panGestureRecognizer = [[PanDirectionGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizer:) andDirection:Horizontal];
    }
    return self;
}

- (void)wireToViewController:(UIViewController *)viewController
{
    self.presentedViewController = viewController;
    if (self.panGestureRecognizer.view) {
        [self.panGestureRecognizer.view removeGestureRecognizer:self.panGestureRecognizer];
    }
    [viewController.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)handleGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interacting = YES;
            [self.presentedViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            [self updateInteractiveTransition:0];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat total, part;
            CGSize presentedViewSize = self.presentedViewController.view.bounds.size;
            
            total = presentedViewSize.width;
            part = translation.x;
            
            CGFloat fraction = part / total;
            self.fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            NSLog(@"%f, %f", part, self.fraction);
            [self updateInteractiveTransition:self.fraction];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            self.interacting = NO;
            if (!(self.fraction > 0.5) || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
