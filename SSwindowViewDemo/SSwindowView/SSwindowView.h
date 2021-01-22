//
//  SSwindowView.h
//  leeMail
//
//  Created by F S on 2017/8/2.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///弹框视图基类
@interface SSwindowView : UIView

#pragma mark -------- 使用方式一 --------------

@property (strong,nonatomic,readonly) UIView* backgroundView;
@property (weak,nonatomic) UIView* contentView;
@property (assign,nonatomic) BOOL anim;
@property (assign,nonatomic) BOOL isShow;
@property (assign,nonatomic) UIViewContentMode contentMode;
-(instancetype) customViewWithAlpha:(CGFloat) alp;
-(instancetype) customerView;
-(void) show;
-(void) dismiss;

#pragma mark -------- 使用方式二（推荐使用） --------------

/**
 *弹框展示
 *contentView: 需要展示的内容
 *contentMode:  contentView展示的位置(可取值为：UIViewContentModeCenter | UIViewContentModeTop | UIViewContentModeBottom | UIViewContentModeLeft | UIViewContentModeRight,)
 */
+ (void)showView:(UIView*)contentView contentMode:(UIViewContentMode)contentMode;

+ (BOOL)isShowCustomView;
///弹框关闭
+ (void)dismissCustomView;
@end

NS_ASSUME_NONNULL_END
