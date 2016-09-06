//
//  YNSlidingMultiInterfaceView.m
//  YNSlidingMultiInterface
//
//  Created by Abel on 16/9/5.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "YNSlidingMultiInterfaceView.h"
#import "YNSlidingMultiInterfaceSubView.h"

#define VIEWFLAG 10000
#define HEADERLABFLAG 100
#define kHeadHeight  64.0f

#define TextColor [UIColor grayColor]
#define LineColor [UIColor colorWithRed:207.0f/255.0f green:210.0f/255.0f blue:213.0f/255.0f alpha:1.0f]//#EAEDED
#define DefaultColor [UIColor colorWithRed:220.0f/255.0f green:15.0f/255.0f blue:36.0f/255.0f alpha:1.0f]

#define APP_HEIGHYREAL [ UIScreen mainScreen ].bounds.size.height
#define APP_WIDTHYREAL [ UIScreen mainScreen ].bounds.size.width

@interface YNSlidingMultiInterfaceView ()<UIScrollViewDelegate>

@property(weak,nonatomic)UIViewController *selfVC;
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIScrollView *headerScrollView;
@property(strong,nonatomic)UIView *lineView;
@property(copy,nonatomic)NSArray *keyArray;
@property(copy,nonatomic)NSString *key;
@property(assign,nonatomic)NSInteger listTypeInt;
@property(assign,nonatomic)CGFloat labWidth;

@end

@implementation YNSlidingMultiInterfaceView
- (id)initWithFrame:(CGRect)frame
     viewController:(UIViewController *)selfVC
           KeyArray:(NSArray *)keyArray;{
    
    if (self = [super initWithFrame:frame]) {
        _selfVC = selfVC;
        _keyArray = keyArray;
        [self createView];
    }
    return self;
}

- (void)createView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width*self.keyArray.count, self.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.bounces = NO;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    
    
    
    
    _labWidth = APP_WIDTHYREAL/self.keyArray.count;
    
    _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    _headerScrollView.contentSize = CGSizeMake(_labWidth*self.keyArray.count, 44);
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.showsVerticalScrollIndicator = NO;
    _headerScrollView.pagingEnabled = YES;
    _headerScrollView.delegate = self;
    //    _scrollView.bounces = NO;
    _headerScrollView.userInteractionEnabled = YES;
    _headerScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_headerScrollView];
    
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/self.keyArray.count/4, 42, self.frame.size.width/self.keyArray.count/2, 2)];
    _lineView.backgroundColor = DefaultColor;
    [_headerScrollView addSubview:_lineView];
    
    self.listTypeInt = 0;
    
    for(int i=0;i<self.keyArray.count;i++){
        UILabel  *projectLab = [[UILabel alloc] initWithFrame:CGRectMake(_labWidth*i, 0, _labWidth, 44)];
        projectLab.text = [[self.keyArray objectAtIndex:i] objectForKey:@"name"];
        projectLab.textColor = TextColor;
        projectLab.textAlignment = NSTextAlignmentCenter;
        projectLab.userInteractionEnabled = YES;
        projectLab.font = [UIFont systemFontOfSize:12];
        projectLab.tag = HEADERLABFLAG+i;
        projectLab.backgroundColor = [UIColor clearColor];
        [_headerScrollView addSubview:projectLab];
        if(i==self.listTypeInt)projectLab.textColor = DefaultColor;
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(projectLabTap:)];
        [projectLab addGestureRecognizer:tap1];
        
        if(i != self.keyArray.count-1){
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_labWidth*(i+1)-0.5, 7, 0.5, 44-14)];
            line.backgroundColor = LineColor;
            [_headerScrollView addSubview:line];
        }
    }
    _key = [[self.keyArray objectAtIndex:0] objectForKey:@"key"];
    [self createSubView:VIEWFLAG+self.listTypeInt];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _headerScrollView.frame.size.height-0.5, _headerScrollView.frame.size.width , 0.5)];
    line.backgroundColor = LineColor;
    [_headerScrollView addSubview:line];
}
- (void)createSubView:(NSInteger)flag
{
    YNSlidingMultiInterfaceSubView *view = [[YNSlidingMultiInterfaceSubView alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width*(flag-VIEWFLAG), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) viewController:_selfVC key:[[self.keyArray objectAtIndex:flag-VIEWFLAG] objectForKey:@"key"]];
    view.userInteractionEnabled = YES;
    view.tag = flag;
    [_scrollView addSubview:view];
}
//项目
- (void)projectLabTap:(UITapGestureRecognizer *)tap
{
    for(int i=0;i<self.keyArray.count;i++){
        if(tap.view.tag-HEADERLABFLAG == i){
            
            if(self.listTypeInt == i)return;
            YNSlidingMultiInterfaceSubView *view = (YNSlidingMultiInterfaceSubView *)[_scrollView viewWithTag:VIEWFLAG+i];
            if(!view){
                _key = [[self.keyArray objectAtIndex:i] objectForKey:@"key"];
                [self createSubView:i+VIEWFLAG];
            }
            self.listTypeInt = i;
            UILabel *lab = (UILabel *)tap.view;
            lab.textColor = DefaultColor;
            [UIView animateWithDuration:0.3 animations:^{
                _scrollView.contentOffset = CGPointMake(i*_scrollView.frame.size.width, 0);
                _lineView.frame =  CGRectMake(self.frame.size.width/self.keyArray.count/4+self.frame.size.width/self.keyArray.count*i, 42, self.frame.size.width/2/self.keyArray.count, 2);
            }];
            
        }else{
            UILabel *lab = (UILabel *)[_headerScrollView viewWithTag:i+HEADERLABFLAG];
            lab.textColor = TextColor;
        }
    }
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == _scrollView){
        NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
        for(int i=0;i<self.keyArray.count;i++){
            if(page == i){
                if(self.listTypeInt == i)return;
                YNSlidingMultiInterfaceSubView *view = (YNSlidingMultiInterfaceSubView *)[_scrollView viewWithTag:VIEWFLAG+i];
                if(!view){
                    _key = [[self.keyArray objectAtIndex:i] objectForKey:@"key"];
                    [self createSubView:i+VIEWFLAG];
                }
                self.listTypeInt = i;
                UILabel *lab = (UILabel *)[_headerScrollView viewWithTag:page+HEADERLABFLAG];
                lab.textColor = DefaultColor;
                [UIView animateWithDuration:0.3 animations:^{
                    _scrollView.contentOffset = CGPointMake(i*_scrollView.frame.size.width, 0);
                    _lineView.frame =  CGRectMake(self.frame.size.width/self.keyArray.count/4+self.frame.size.width/self.keyArray.count*i, 42, self.frame.size.width/2/self.keyArray.count, 2);
                }];
            }else{
                UILabel *lab = (UILabel *)[_headerScrollView viewWithTag:i+HEADERLABFLAG];
                lab.textColor = TextColor;
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
