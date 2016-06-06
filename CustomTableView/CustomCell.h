//
//  CustomCell.h
//  CustomTableView
//
//  Created by Bin on 16/6/6.
//  Copyright © 2016年 CB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCellDelegate <NSObject>

- (void)selectBtn:(UIButton *)button;

@end

@interface CustomCell : UITableViewCell

@property (nonatomic, strong) UIButton *customBtn;

@property (nonatomic, weak) id<CustomCellDelegate> delegate;

@end
