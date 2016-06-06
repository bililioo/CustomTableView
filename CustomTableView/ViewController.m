//
//  ViewController.m
//  CustomTableView
//
//  Created by chenbin on 16/6/6.
//  Copyright © 2016年 CB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *listArr;

//@property (nonatomic, strong) NSMutableArray *testArr;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Action
- (void)customBtnAction:(UIButton *)button
{
    
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
    static NSString *identifier = @"11";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.listArr[indexPath.row];
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.backgroundColor = [UIColor redColor];
    [customBtn addTarget:self action:@selector(customBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(100, 0, 64, 64);
    customBtn.tag = 100 + indexPath.row;
    [cell addSubview:customBtn];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.listArr insertObject:@"hahh" atIndex:indexPath.row + 1];
//    NSIndexPath *currentIndex = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
//    [tableView insertRowsAtIndexPaths:@[currentIndex] withRowAnimation:UITableViewRowAnimationBottom];

//    NSLog(@"%@", self.listArr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
