//
//  YNSlidingMultiInterfaceSubView.m
//  YNSlidingMultiInterface
//
//  Created by Abel on 16/9/5.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "YNSlidingMultiInterfaceSubView.h"

@interface YNSlidingMultiInterfaceSubView()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_arrayData;
}
@property(strong,nonatomic)UITableView *tableView;
@property(weak,nonatomic)UIViewController *selfVC;
@property(copy,nonatomic)NSString *key;

@end


@implementation YNSlidingMultiInterfaceSubView

- (id)initWithFrame:(CGRect)frame
     viewController:(UIViewController *)selfVC
                key:(NSString *)key{
    
    if (self = [super initWithFrame:frame]) {
        self.selfVC = selfVC;
        self.key = key;
        self.backgroundColor = [UIColor redColor];
        
        _arrayData = [[NSMutableArray alloc] init];
        [self createTableView];
    }
    return self;
}

//创建表视图
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
}
//行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
//列数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"YNSlidingMultiInterfaceSubViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    for(UIView *view in cell.contentView.subviews){
        [view removeFromSuperview];
    }
    UIView *view = [self createCellView:nil and:indexPath];
    [cell.contentView addSubview:view];
//    if([self.key isEqualToString:@"1"]){
//        UIView *view = [self createCellView:[_arrayData objectAtIndex:indexPath.section] and:indexPath];
//        [cell.contentView addSubview:view];
//    }else if([self.key isEqualToString:@"2"]){
//        UIView *view = [self createCellView:[_arrayData objectAtIndex:indexPath.section] and:indexPath];
//        [cell.contentView addSubview:view];
//    }else if([self.key isEqualToString:@"3"]){
//        UIView *view = [self createCellView:[_arrayData objectAtIndex:indexPath.section] and:indexPath];
//        [cell.contentView addSubview:view];
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.key isEqualToString:@"3"])return 80;
    return  110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)return 0;
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/*
 
 NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"643587234u24821731",@"number",
 @"2016-4-25",@"time",
 @"baby",@"from",
 @"100",@"money",nil];
 */
- (UIView *)createCellView:(NSDictionary *)dic and:(NSIndexPath *)index
{
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
    cellView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellView.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor yellowColor];
    [cellView addSubview:lineView];
    
    //12 22 btn2
    UILabel *labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (self.frame.size.width-20)/3*2, 30)];
    labelNumber.backgroundColor = [UIColor whiteColor];
    labelNumber.font = [UIFont systemFontOfSize:15];
    labelNumber.text = @"滑动";
    labelNumber.textColor = [UIColor grayColor];
    [cellView addSubview:labelNumber];
    return cellView;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
