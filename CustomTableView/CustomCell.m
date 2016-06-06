//
//  CustomCell.m
//  CustomTableView
//
//  Created by Bin on 16/6/6.
//  Copyright © 2016年 CB. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _customBtn.backgroundColor = [UIColor redColor];
        [_customBtn addTarget:self action:@selector(customBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _customBtn.frame = CGRectMake(100, 0, 64, 64);
        [self addSubview:self.customBtn];
    }
    return self;
}

- (void)customBtnAction:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(selectBtn:)])
    {
        [self.delegate selectBtn:button];
    }
}

@end
