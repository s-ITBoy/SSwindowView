//
//  SSwindowView.m
//  leeMail
//
//  Created by F S on 2017/8/2.
//  Copyright © 2017 F S. All rights reserved.
//

//#define is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#import "SSwindowView.h"

@interface UIView (superView)

@end
@implementation UIView (superView)

@end
@interface SSwindowView ()
@property (nonatomic,strong,readonly) UIView* backgroundView;
@property (nonatomic,weak) UIView* contentView;
@property (nonatomic,assign) BOOL anim;
@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,assign) SSContentPosition contentPosition;
///偏移量
@property(nonatomic,assign) CGFloat offset;
///空白区域能搜点击
@property (nonatomic,assign) BOOL isCanClickEmpt;

@end
@implementation SSwindowView {
    CGRect _beforeFrame;
    CGRect _showFrame;
    CGFloat _alpha ;
    CGFloat _yyy;
}

- (instancetype)customViewWithAlpha:(CGFloat) alp {
    if([super initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]){
        _alpha = alp;
        _backgroundView = [[UIView alloc]initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDismiss)]];
        [self addSubview:_backgroundView];
        _contentPosition = SSContentPositionCenter;
        self.tag = 999;
    }
    return self;
}
- (instancetype)customerView {
    [self customViewWithAlpha:0.65];
    return self;
}

- (void)setContentPosition:(SSContentPosition)contentPosition {
    _contentPosition = contentPosition;
    CGSize size = _contentView.frame.size;
    switch (contentPosition) {
        case SSContentPositionTop:
            _showFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , 0.0f + self.offset, size.width, size.height);
            _beforeFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , -size.height, size.width, size.height);
            break;
        case SSContentPositionBottom: {
//            CGFloat bottomSafeArea = isIphoneX ? 34 : 0;
//            _showFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , self.frame.size.height-size.height - bottomSafeArea + self.offset, size.width, size.height + bottomSafeArea);
            _showFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , self.frame.size.height-size.height + self.offset, size.width, size.height);
            _beforeFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , self.frame.size.height+size.height, size.width, size.height);
        }
            break;
        case SSContentPositionLeft:
            _showFrame = CGRectMake(0 + self.offset, (self.frame.size.height-size.height)/2, size.width, size.height);
            _beforeFrame = CGRectMake(-size.width, (self.frame.size.height-size.height)/2, size.width, size.height);
            break;
        case SSContentPositionRight:
            _showFrame = CGRectMake(self.frame.size.width - size.width + self.offset , (self.frame.size.height-size.height)/2, size.width, size.height);
            _beforeFrame = CGRectMake( self.frame.size.width +size.width , (self.frame.size.height-size.height)/2, size.width, size.height);
            break;
        case SSContentPositionCenter:
//            _showFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , (self.frame.size.height-size.height)/2.0f, size.width, size.height);
            _showFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , (self.frame.size.height-size.height)/2.0f + self.offset, size.width, size.height);
            _beforeFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , -size.height, size.width, size.height);
            break;
            
        default:
            
            break;
    }
}

- (void)show:(BOOL)animate {
    [self addSubview:_contentView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _contentView.frame = _beforeFrame;
    _backgroundView.alpha = 0.0f;
    if (animate) {
        [UIView animateWithDuration:0.35f animations:^{
            self.backgroundView.alpha = self->_alpha;
            self.contentView.frame = self->_showFrame;
        }];
    } else {
        self.backgroundView.alpha = _alpha;
        self.contentView.frame = _showFrame;
    }
    
    _isShow = YES;
    
}

- (void)clickDismiss {
    if (self.isCanClickEmpt) {
        [self dismiss:YES];
    }
}

- (void)dismiss:(BOOL)animate {
    if (animate) {
        [UIView animateWithDuration:0.35 animations:^{
            self->_backgroundView.alpha = 0.0f;
            self->_contentView.frame = self->_beforeFrame;
        } completion:^(BOOL finished) {
            self.contentView = nil;
            [self.contentView removeFromSuperview];
            [self removeFromSuperview];
        }];
        
    } else {
        _backgroundView.alpha = 0.0f;
        _contentView.frame = _beforeFrame;
        [self.contentView removeFromSuperview];
        self.contentView = nil;
        [self removeFromSuperview];
    }
    _isShow = NO;
}

- (void)ss_setSub:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan bgAlpha:(CGFloat)bgAlpha {
    self.contentView = contentView;
    self.contentPosition = contentPosition;
    self.offset = offset;
    self.isCanClickEmpt = isCan;
    _alpha = bgAlpha;
}

+ (void)ss_show:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan bgAlpha:(CGFloat)bgAlpha animate:(BOOL)showAnimate {
    SSwindowView* view = [[SSwindowView alloc] customerView];
    [view ss_setSub:contentView position:contentPosition offset:offset ClickEmpt:isCan bgAlpha:bgAlpha];
    [view show:showAnimate];
}

+ (void)ss_showView:(UIView*)contentView position:(SSContentPosition)contentPosition {
    [self ss_show:contentView position:contentPosition offset:0 ClickEmpt:YES bgAlpha:0.65 animate:YES];
}

+ (void)ss_showView:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset {
    [self ss_show:contentView position:contentPosition offset:offset ClickEmpt:YES bgAlpha:0.65 animate:YES];
}

+ (void)ss_showView:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan {
    [self ss_show:contentView position:contentPosition offset:offset ClickEmpt:isCan bgAlpha:0.65 animate:YES];
}

+ (void)ss_showView:(UIView*)contentView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan complet:(void(^)(void))complete {
    SSwindowView* view = [[SSwindowView alloc] customerView];
    [view ss_setSub:contentView position:contentPosition offset:offset ClickEmpt:isCan bgAlpha:0.65];
    [view showWithBlock:complete];
}

- (void)showWithBlock:(void(^)(void))complete {
    [self addSubview:_contentView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _contentView.frame = _beforeFrame;
    _backgroundView.alpha = 0.0f;
    [UIView animateWithDuration:0.35f animations:^{
        self.backgroundView.alpha = self->_alpha;
        self.contentView.frame = self->_showFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            complete();
        }
    }];
    _isShow = YES;
    
}

+ (BOOL)ss_isShowCustomView {
    SSwindowView* view = [[UIApplication sharedApplication].keyWindow viewWithTag:999];
    return view != nil;
}

+ (void)ss_dismissCustomView:(BOOL)animate {
    SSwindowView* view = [[UIApplication sharedApplication].keyWindow viewWithTag:999];
    if(view)
        [view dismiss:animate];
}

+ (void)ss_dismissAllCustomView {
    for (UIView* view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 999) {
            SSwindowView* w = (SSwindowView*)view;
            [w dismiss:YES];
        }
    }
}

#pragma mark -------- 使用方式三 添加到指定superView上的弹框（推荐使用） --------------

+ (void)ss_showView:(UIView*)contentView superView:(UIView*)superView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan bgAlpha:(CGFloat)bgAlpha animate:(BOOL)showAnimate {
    SSwindowView* view = [[SSwindowView alloc] initWithSuper:superView];
    [view ss_setSub:contentView position:contentPosition offset:offset ClickEmpt:isCan bgAlpha:bgAlpha];
    [view showWithSuper:superView animate:showAnimate];
}

+ (void)ss_showView:(UIView*)contentView superView:(UIView*)superView position:(SSContentPosition)contentPosition offset:(CGFloat)offset ClickEmpt:(BOOL)isCan {
    [self ss_showView:contentView superView:superView position:contentPosition offset:offset ClickEmpt:isCan bgAlpha:0.65 animate:YES];
}

- (void)showWithSuper:(UIView*)superView animate:(BOOL)showAnimate {
    [self addSubview:_contentView];
    [superView addSubview:self];
    _contentView.frame = _beforeFrame;
    _backgroundView.alpha = 0.0f;
    if (showAnimate) {
        [UIView animateWithDuration:0.35f animations:^{
            self.backgroundView.alpha = self->_alpha;
            self.contentView.frame = self->_showFrame;
        }];
    } else {
        self.backgroundView.alpha = _alpha;
        self.contentView.frame = _showFrame;
    }
    
    _isShow = YES;
}

- (instancetype)initWithSuper:(UIView*)superView {
    if ([super initWithFrame:superView.bounds]) {
        _alpha = 0.65;
        _backgroundView = [[UIView alloc]initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDismiss)]];
        [self addSubview:_backgroundView];
        _contentPosition = SSContentPositionCenter;
        self.tag = 999;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
