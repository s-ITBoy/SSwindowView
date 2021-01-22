//
//  SSwindowView.m
//  leeMail
//
//  Created by F S on 2017/8/2.
//  Copyright © 2017 F S. All rights reserved.
//

#define is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#import "SSwindowView.h"

@implementation SSwindowView {
    CGRect _beforeFrame;
    CGRect _showFrame;
    CGFloat _alpha ;
    CGFloat _yyy;
}

-(instancetype)customViewWithAlpha:(CGFloat) alp {
    if([super initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]){
        _alpha = alp;
        _backgroundView = [[UIView alloc]initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];
        [self addSubview:_backgroundView];
        _contentMode = UIViewContentModeCenter;
        self.tag = 999;
    }
    return self;
}
-(instancetype)customerView {
    [self customViewWithAlpha:0.65];
    return self;
}

-(void)setContentMode:(UIViewContentMode)contentMode {
    _contentMode = contentMode;
    CGSize size = _contentView.frame.size;
    CGFloat offset = is_iPhoneX ? 34 : 0;
    switch (_contentMode) {
        case UIViewContentModeTop:
            _showFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , 0.0f, size.width, size.height);
            _beforeFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , -size.height, size.width, size.height);
            break;
        case UIViewContentModeBottom:
            _showFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , self.frame.size.height-size.height - offset, size.width, size.height + offset);
            _beforeFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , self.frame.size.height+size.height, size.width, size.height);
            break;
        case UIViewContentModeLeft:
            _showFrame = CGRectMake(0, (self.frame.size.height-size.height)/2, size.width, size.height);
            _beforeFrame = CGRectMake(-size.width, (self.frame.size.height-size.height)/2, size.width, size.height);
            break;
        case UIViewContentModeRight:
            _showFrame = CGRectMake(self.frame.size.width - size.width , (self.frame.size.height-size.height)/2, size.width, size.height);
            _beforeFrame = CGRectMake( self.frame.size.width +size.width , (self.frame.size.height-size.height)/2, size.width, size.height);
            break;
        case UIViewContentModeCenter:
        default:
            _showFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , (self.frame.size.height-size.height)/2.0f, size.width, size.height);
            _beforeFrame = CGRectMake( (self.frame.size.width - size.width)/2.0f , -size.height, size.width, size.height);
            break;
    }
}

-(void)show {
    [self addSubview:_contentView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _contentView.frame = _beforeFrame;
    _backgroundView.alpha = 0.0f;
    [UIView animateWithDuration:0.35f animations:^{
        self.backgroundView.alpha = self->_alpha;
        self.contentView.frame = self->_showFrame;
    }];
    _isShow = YES;
    
}
-(void)dismiss {
    [UIView animateWithDuration:0.35 animations:^{
        self->_backgroundView.alpha = 0.0f;
        self->_contentView.frame = self->_beforeFrame;
    } completion:^(BOOL finished) {
        self.contentView = nil;
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
    }];
    _isShow = NO;
}

+ (void)showView:(UIView*)contentView contentMode:(UIViewContentMode)contentMode {
    SSwindowView* view = [[SSwindowView alloc] customerView];
    view.contentView = contentView;
    view.contentMode = contentMode;
    [view show];
//    return view;
    
}

+ (BOOL)isShowCustomView {
    SSwindowView* view = [[UIApplication sharedApplication].keyWindow viewWithTag:999];
    return view != nil;
}

+ (void)dismissCustomView {
    SSwindowView* view = [[UIApplication sharedApplication].keyWindow viewWithTag:999];
    if(view)
        [view dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
