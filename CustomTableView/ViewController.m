//
//  ViewController.m
//  CustomTableView
//
//  Created by chenbin on 16/6/6.
//  Copyright © 2016年 CB. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, assign) NSInteger lastSelectCell;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSUInteger lastClick;

@property (nonatomic, copy) NSString *str;

@end

@implementation ViewController

- (NSMutableArray *)listArr
{
    if (!_listArr)
    {
        _listArr = [NSMutableArray array];
        
        for (int i = 0; i < 20; i++)
        {
            [_listArr addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _listArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lastSelectCell = -1;
    
    _lastClick = -1;
    
    _tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height-300);
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(50, 50, 30, 60);
    label.text = [self thmod];
    [self.view addSubview:label];
    
}

#pragma mark - Action
- (NSString *)thmod
{
    return @"-----";
}

#pragma mark- CustomCellDelegate
- (void)selectBtn:(UIButton *)button
{
    NSLog(@"%ld", button.tag);
    
    NSInteger index = button.tag - 1000;
    
    if ([self.listArr containsObject:@"secondCell"]) // 包含 secondCell
    {
        self.lastClick = [self.listArr indexOfObject:@"secondCell"]; // 获得secondCell的下标
        [self.listArr removeObjectAtIndex:self.lastClick];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.lastClick inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        if (self.lastClick != index + 1) // 如果上次点击的下标不等于当前的下标, 就insert一个新的 secondCell
        {
            if (self.listArr.count < index + 1)
            {
                [self.listArr addObject:@"secondCell"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[self.listArr indexOfObject:@"secondCell"] inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            else
            {
                [self.listArr insertObject:@"secondCell" atIndex:index + 1];
                NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:index + 1 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath2] withRowAnimation:UITableViewRowAnimationAutomatic];
            }

        }
    }
    else
    {
        if (self.listArr.count < index + 1)
        {
            [self.listArr addObject:@"secondCell"];
        }
        else
        {
            [self.listArr insertObject:@"secondCell" atIndex:index + 1];
        }
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:index + 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath2] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

    NSLog(@"%@", self.listArr);
}

#pragma mark- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.listArr[indexPath.row] isEqualToString:@"secondCell"])
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:nil];
        cell.textLabel.text = self.listArr[indexPath.row];
        return cell;
    }
    CustomCell *cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.listArr[indexPath.row];
    cell.customBtn.tag = 1000 + indexPath.row;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
