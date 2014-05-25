//
//  RMStep.m
//  RMStepsController
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers
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
//

#import "RMStep.h"

@interface RMStep ()
{
    UIFont *_stepTitleFont;
    UIFont *_numberFont;
}
@property (nonatomic, strong, readwrite) UIView *stepView;
@property (nonatomic, strong, readwrite) UILabel *numberLabel;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@property (nonatomic, strong, readwrite) CAShapeLayer *circleLayer;

@end

@implementation RMStep

#pragma mark Properties
- (UIView *)stepView {
    if(!_stepView) {
        self.stepView = [[UIView alloc] initWithFrame:CGRectZero];
        _stepView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_stepView.layer addSublayer:self.circleLayer];
        
        [_stepView addSubview:self.numberLabel];
        [_stepView addSubview:self.titleLabel];
        
        UILabel *titleLabel = self.titleLabel;
        UILabel *numberLabel = self.numberLabel;
        NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(titleLabel, numberLabel);
        
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(40)-[titleLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[titleLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(11)-[numberLabel]-(9)-[titleLabel]" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(3)-[numberLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    }
    
    return _stepView;
}

- (UILabel *)numberLabel {
    if(!_numberLabel) {
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.text = @"0";
        _numberLabel.textColor = self.disabledTextColor;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.font = self.numberFont;
        _numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _numberLabel;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = self.title;
        _titleLabel.textColor = self.disabledTextColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = self.stepTitleFont;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

- (CAShapeLayer *)circleLayer {
    if(!_circleLayer) {
        NSInteger radius = 12;
        
        self.circleLayer = [CAShapeLayer layer];
        _circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius].CGPath;
        _circleLayer.position = CGPointMake(9, 27);
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = self.disabledTextColor.CGColor;
        _circleLayer.lineWidth = 1;
    }
    
    return _circleLayer;
}

- (void)setTitle:(NSString *)newTitle {
    if(_title != newTitle) {
        _title = newTitle;
        
        self.titleLabel.text = newTitle;
    }
}

- (UIColor *)selectedBarColor {
    if(!_selectedBarColor) {
        self.selectedBarColor = [UIColor colorWithRed:23./255. green:220./255. blue:108./255. alpha:1];
    }
    
    return _selectedBarColor;
}

- (UIColor *)enabledBarColor {
    if(!_enabledBarColor) {
        self.enabledBarColor = [UIColor colorWithWhite:142./255. alpha:0.5];
    }
    
    return _enabledBarColor;
}

- (UIColor *)disabledBarColor {
    if(!_disabledBarColor) {
        self.disabledBarColor = [UIColor clearColor];
    }
    
    return _disabledBarColor;
}

- (UIColor *)selectedTextColor {
    if(!_selectedTextColor) {
        self.selectedTextColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
    return _selectedTextColor;
}

- (UIColor *)enabledTextColor {
    if(!_enabledTextColor) {
        self.enabledTextColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
    return _enabledTextColor;
}

- (UIColor *)disabledTextColor {
    if(!_disabledTextColor) {
        self.disabledTextColor = [UIColor colorWithWhite:0.75 alpha:1];
    }
    
    return _disabledTextColor;
}

- (UIFont *)stepTitleFont
{
    if(!_stepTitleFont) {
        self.stepTitleFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    }
    
    return _stepTitleFont;
}

- (UIFont *)numberFont
{
    if(!_numberFont) {
        self.numberFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    }
    
    return _numberFont;
}

- (void)setStepTitleFont:(UIFont *)stepTitleFont
{
    _stepTitleFont = stepTitleFont;
    
    self.titleLabel.font = stepTitleFont;
}

- (void)setNumberFont:(UIFont *)numberFont
{
    _numberFont = numberFont;
    
    self.numberLabel.font = numberFont;
}

@end
