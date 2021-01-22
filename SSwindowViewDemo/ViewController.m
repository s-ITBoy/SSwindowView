//
//  ViewController.m
//  SSwindowViewDemo
//
//  Created by F S on 2021/1/22.
//

#import "ViewController.h"
#import "SSwindowView.h"

@interface ViewController ()
@property(nonatomic,strong) UILabel* lab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 140)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"十分劳务费射流风机\n射流风机违法是";
    self.lab = lab;
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 88, 100, 50)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickBtn {
    if ([SSwindowView isShowCustomView]) {
        [SSwindowView dismissCustomView];
    }else {
        [SSwindowView showView:self.lab contentMode:UIViewContentModeRight];
    }
    
}


@end
