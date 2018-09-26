//
//  HYDRedPacketSegmentControl.m
//  HC-HYD
//
//  Created by jiabaozhang on 2018/6/22.
//  Copyright © 2018年 cheyy. All rights reserved.
//

#import "HYDRedPacketSegmentControl.h"
#import <Masonry.h>

#define kSegmentHeight 44

/// ********** HYDSegmentControlButton *********** ///
@implementation HYDSegmentControlButton
{
    UIColor *_lineColor;
}

- (void)setColor:(UIColor *)color
{
    _lineColor = [color copy];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat descender = self.titleLabel.font.descender;
    CGFloat lineWidth = 2;
    if ([_lineColor isKindOfClass:[UIColor class]]) {
        CGContextSetStrokeColorWithColor(contextRef, _lineColor.CGColor);
    }
    CGContextSetLineWidth(contextRef, lineWidth);
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + lineWidth);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender + lineWidth);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

- (void)setSelected:(BOOL)selected
{
    if (selected == YES) {
        [self setColor:UIColorFromRGB(0x10A8EA)];
    } else {
        [self setColor:[UIColor clearColor]];
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleWidth = 40;
    CGFloat titleHeight = 35;
    CGFloat titleX = (self.bounds.size.width - titleWidth) / 2;
    CGFloat titleY = self.bounds.size.height - titleHeight;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end


/// ********** HYDRedPacketSegmentControl *********** ///
@interface HYDRedPacketSegmentControl ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) HYDSegmentControlButton *selectedButton;
@property (nonatomic, copy) SelectIndexBlock indexBlock;
@end

@implementation HYDRedPacketSegmentControl

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        [self layoutPageSubviews];
    }
    return self;
}

#pragma mark - public
- (void)setSelectIndexActionBlock:(SelectIndexBlock)aIndexActionBlock
{
    if (aIndexActionBlock) {
        _indexBlock = aIndexActionBlock;
    }
}

- (void)setDefaultSelectedIndex:(NSInteger)index
{
    if (index >= _titles.count || index < 0) {
        NSString *selectorName = NSStringFromSelector(@selector(setDefaultSelectedIndex:));
        NSString *reason = [NSString stringWithFormat:@"%@类%@方法中，index的值必须是[0, %zd)之间的正整数。", NSStringFromClass([self class]), selectorName, _titles.count];
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:reason
                                     userInfo:nil];
    }

    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:[HYDSegmentControlButton class]] && btn.tag == index) {
            [self buttonClickAction:(HYDSegmentControlButton *)btn];
        }
    }
}


#pragma mark - private
- (void)layoutPageSubviews
{
    self.backgroundColor = UIColorFromRGB(0xFFFFFF);

    NSInteger btnCount = _titles.count;
    CGFloat padding = 10;
    CGFloat buttonWidth = (SCREEN_WIDTH - (btnCount + 1) * padding) / btnCount;
    CGFloat buttonHeight = kSegmentHeight;
    CGFloat buttonX = 0;
    CGFloat buttonY = kSegmentHeight - buttonHeight;
    for (int i = 0; i < _titles.count; i++) {
        buttonX = i * buttonWidth + (i + 1) * padding;
        HYDSegmentControlButton *button = [[HYDSegmentControlButton alloc] init];
        [button setColor:[UIColor clearColor]];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateSelected];
        button.tag = i;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        [self addSubview:button];
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - actions
- (void)buttonClickAction:(HYDSegmentControlButton *)sender
{
    if (_indexBlock && sender.tag < _titles.count) {
        _indexBlock(sender.tag);
    }
    
    if (sender != self.selectedButton) {
        self.selectedButton.selected = NO;
        sender.selected = YES;
        self.selectedButton = sender;
    }
}


@end
