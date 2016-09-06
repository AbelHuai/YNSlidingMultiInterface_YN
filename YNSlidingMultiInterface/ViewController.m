//
//  ViewController.m
//  YNSlidingMultiInterface
//
//  Created by Abel on 16/9/5.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "ViewController.h"
#import "YNSlidingMultiInterfaceView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    //看需要可自行添加
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"key",@"佣金来源",@"name", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"key",@"佣金消费",@"name", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"3",@"key",@"佣金提现",@"name", nil];
    NSArray *keyArray = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
    //    self.keyArray = [NSArray arrayWithObjects:dic1,dic2, nil];
    
    YNSlidingMultiInterfaceView *view = [[YNSlidingMultiInterfaceView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)viewController:self KeyArray:keyArray];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
