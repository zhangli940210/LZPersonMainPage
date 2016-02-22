//
//  ViewController.m
//  LZ个人主页
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"
#define photoH 200
#define OrignY -244

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/** tableView属性*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 图片高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImageViewHLc;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 从iOS7开始当scrollView在导航控制器,会自动调用边距64
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置tableView最开始偏移量,调用该方法，默认会调用
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
    // 隐藏导航条2步
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 设置主页标题
    UILabel *titleT = [[UILabel alloc] init];
    titleT.text = @"LZ主页";
    // 尺寸自适应
    [titleT sizeToFit];
    // 隐藏标题
    [titleT setTextColor:[UIColor colorWithWhite:0 alpha:0]];
    // 添加到导航条上去
    self.navigationItem.titleView = titleT;
}

#pragma mark - UITableViewDelegate方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算tableView偏移量
    CGFloat offsetY = scrollView.contentOffset.y - OrignY;
    // 计算图片剩下的量
    CGFloat h = photoH - offsetY;
    if (h <= 64) {
        h = 64;
    }
    self.bgImageViewHLc.constant = h;
    
    // 设置透明度
    CGFloat alpha = 1 * offsetY / 136.0;
    if (alpha >= 1) {
        alpha = 0.99;
    }
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 拿到titleT
    UILabel *titleT = (UILabel *)self.navigationItem.titleView;
    [titleT setTextColor:[UIColor colorWithWhite:0 alpha:alpha]];
}

#pragma mark - UITableViewDataSource方法
// 返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
// 每行显示什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"hello";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"hello---%zd", indexPath.row];
    return cell;
}


@end
