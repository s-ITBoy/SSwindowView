//
//  SSwindowView.h
//  leeMail
//
//  Created by F S on 2017/8/2.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSContentPosition) {
    SSContentPositionCenter   = 0,
    SSContentPositionTop,
    SSContentPositionLeft,
    SSContentPositionBottom,
    SSContentPositionRight,
};

NS_ASSUME_NONNULL_BEGIN
///弹框视图基类
@interface SSwindowView : UIView

#pragma mark -------- 使用方式一 废弃 --------------
-(instancetype) customViewWithAlpha:(CGFloat) alp;
-(instancetype) customerView;
-(void) show:(BOOL)animate;
-(void) dismiss:(BOOL)animate;

#pragma mark -------- 使用方式二 添加到keywindow上的弹框（推荐使用） --------------
/**
 *弹框展示（带全属性）
 *@param contentView 需要展示的内容视图
 *@param contentPosition contentView展示的位置
 *@param offset 偏移量；当positon = center / top / bottom 时 offset为y轴的偏移量； 当position = left / right 时 offset为x轴偏移量
 *@param isCan 空白区域能否点击
 *@param bgAlpha 背景透明度值
 *param showAnimate 是否显示弹出动画 此属性默认为YES
 */
+ (void)ss_show:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan bgAlpha:(CGFloat)bgAlpha animate:(BOOL)showAnimate;
/**
 *弹框展示（默认偏移量offset == 0；空白区域能点击，bgalpha==0.65）
 *@param contentView 需要展示的内容视图
 *@param contentPosition contentView展示的位置 \n
 */
+ (void)ss_showView:(UIView*)contentView position:(SSContentPosition)contentPosition;
/**
 *弹框展示（默认空白区域能点击 bgalpha==0.65）
 *@param contentView 需要展示的内容视图
 *@param contentPosition contentView展示的位置
 *@param offset 偏移量；当positon = center / top / bottom 时 offset为y轴的偏移量； 当position = left / right 时 offset为x轴偏移量
 */
+ (void)ss_showView:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset;
/**
 *弹框展示 (默认 bgalpha==0.65)
 *@param contentView 需要展示的内容视图
 *@param contentPosition contentView展示的位置
 *@param offset 偏移量；当positon = center / top / bottom 时 offset为y轴的偏移量； 当position = left / right 时 offset为x轴偏移量
 *@param isCan 空白区域能否点击
 */
+ (void)ss_showView:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan;

+ (void)ss_showView:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan complet:(void(^)(void))complete;

+ (BOOL)ss_isShowCustomView;
///弹框关闭
+ (void)ss_dismissCustomView:(BOOL)animate;
///一次性关闭多个弹框
+ (void)ss_dismissAllCustomView;

#pragma mark -------- 使用方式三 添加到指定superView上的弹框（推荐使用） --------------
/**
 *弹框展示
 *@param contentView 需要展示的内容视图
 *@param superView 弹框将要展示的位置的视图层
 *@param contentPosition contentView展示的位置
 *@param offset 偏移量；当positon = center / top / bottom 时 offset为y轴的偏移量； 当position = left / right 时 offset为x轴偏移量
 *@param isCan 空白区域能否点击
 *@param bgAlpha 背景透明度值
 *@param showAnimate 是否显示弹出动画
 */
+ (void)ss_showView:(UIView*)contentView superView:(UIView*)superView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan bgAlpha:(CGFloat)bgAlpha animate:(BOOL)showAnimate;
/**
 *弹框展示 (默认 bgalpha==0.65 showAnimate==YES)
 *@param contentView 需要展示的内容视图
 *@param superView 弹框将要展示的位置的视图层
 *@param contentPosition contentView展示的位置
 *@param offset 偏移量；当positon = center / top / bottom 时 offset为y轴的偏移量； 当position = left / right 时 offset为x轴偏移量
 *@param isCan 空白区域能否点击
 */
+ (void)ss_showView:(UIView*)contentView superView:(UIView*)superView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan;
@end

NS_ASSUME_NONNULL_END
