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

@end

@implementation ViewController

- (NSArray *)listArr
{
    if (!_listArr)
    {
        _listArr = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    }
    return _listArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lastSelectCell = -1;
    
    _tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Action


#pragma mark- CustomCellDelegate
- (void)selectBtn:(UIButton *)button
{
    NSLog(@"%ld", button.tag);
    
    NSInteger index = button.tag - 100;

    for (int i = 0; i < self.listArr.count; i++)
    {
        if ([self.listArr[i] isEqualToString:@"secondCell"])
        {
            [self.listArr removeObjectAtIndex:i];
            NSIndexPath *currentIndex = [NSIndexPath indexPathForRow:i + 1 inSection:0];
            [self.tableView deleteRowsAtIndexPaths:@[currentIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
//    if (self.lastSelectCell == index)
//    {
//        [self.listArr removeObjectAtIndex:index + 1];
//        NSIndexPath *currentIndex = [NSIndexPath indexPathForRow:index + 1 inSection:0];
//        [self.tableView deleteRowsAtIndexPaths:@[currentIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
//        self.lastSelectCell = -1;
//    }
//    
    if (self.lastSelectCell != index)
    {
        [self.listArr insertObject:@"secondCell" atIndex:index + 1];
        NSIndexPath *currentIndex = [NSIndexPath indexPathForRow:index + 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[currentIndex] withRowAnimation:UITableViewRowAnimationBottom];
        self.lastSelectCell = index;
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
    return self.listArr.count;
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
    cell.customBtn.tag = 100 + indexPath.row;
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
