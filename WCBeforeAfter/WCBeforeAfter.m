//
//  WCBeforeAfter.m
//  BeforeAfter
//
//  Created by Michał Zaborowski on 21.11.2012.
//  Copyright (c) 2012 whitecode. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "WCBeforeAfter.h"
#import <QuartzCore/QuartzCore.h>

#define SLIDE_ANIMATION_DURATION 1.0

@interface WCBeforeAfter ()
@property (nonatomic,assign) BOOL isSliderTouched;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@end

@implementation WCBeforeAfter

- (id)initWithLeftSideImage:(UIImage *)leftImage rightSideImage:(UIImage *)rightImage
{
    if (self = [super initWithFrame:CGRectMake(0, 0, leftImage.size.width, leftImage.size.height)]) {
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftImage.size.width, leftImage.size.height)];
        _leftImageView.contentMode = UIViewContentModeLeft;
        _leftImageView.clipsToBounds = YES;
        _leftImageView.image = leftImage;
        
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftImage.size.width, leftImage.size.height)];
        _rightImageView.contentMode = UIViewContentModeRight;
        _rightImageView.image = rightImage;
        _rightImageView.clipsToBounds = YES;
        
        _leftImageView.center = self.center;
        _rightImageView.center = self.center;
        
        [self addSubview:_leftImageView];
        [self addSubview:_rightImageView];
        
        self.sliderPosition = leftImage.size.width/2;
    }
    return self;
}

- (void)setSliderView:(UIView *)sliderView
{
    [_sliderView removeFromSuperview];
    
    _sliderView = sliderView;
    _sliderView.center = self.center;
    
    [self addSubview:_sliderView];
}

- (void)setSliderPosition:(float)sliderPosition animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:SLIDE_ANIMATION_DURATION delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.sliderPosition = sliderPosition;
        } completion:nil];
        
    } else {
        self.sliderPosition = sliderPosition;
    }
}

- (void)setSliderPosition:(float)sliderPosition
{

    if ((sliderPosition < self.frame.size.width) && (sliderPosition > self.bounds.origin.x)) {
        _sliderPosition = sliderPosition;
        
        if (self.sliderView) {
            self.sliderView.center = CGPointMake(sliderPosition, self.sliderView.center.y);
        } 

        CGRect leftImageRect = self.leftImageView.frame;
        leftImageRect.size.width = sliderPosition;
        self.leftImageView.frame = leftImageRect;
        
        CGRect rightImageRect = self.rightImageView.frame;
        rightImageRect.origin.x = sliderPosition;
        rightImageRect.size.width = self.frame.size.width - sliderPosition;
        self.rightImageView.frame = rightImageRect;
        
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:self.sliderView];
    
    if (CGRectContainsPoint(self.sliderView.bounds, currentPoint)) {
        self.isSliderTouched = YES;
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.isSliderTouched) {
        UITouch *touch = [touches anyObject];
        
        CGPoint currentPoint = [touch locationInView:self];
        
        if (currentPoint.x >= self.sliderView.bounds.size.width/2 && currentPoint.x <= self.bounds.size.width - self.sliderView.bounds.size.width/2) {
            self.sliderPosition = currentPoint.x;
        }
        
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    if (self.isSliderTouched == NO) {
        UITouch *touch = [touches anyObject];
        
        CGPoint currentPoint = [touch locationInView:self];
        
        [self setSliderPosition:currentPoint.x animated:YES];
    }
    
    self.isSliderTouched = NO;
    
    
}


@end
