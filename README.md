# SSwindowView

Installation

Installation with CocoaPods

when you will use the all Categories:

pod 'SSwindowView'

Usage

import the header file into any class where you wish to make use of the functionality such as

#import <SSwindowView.h>

[SSwindowView showView:contentView contentMode:UIViewContentModeCenter];


当您不使用cocoapod导入时，也可以直接下载代码导入到您的项目中，只需要将SSwindowView.h和SSwindowView.m文件导入到您的项目中即可,下载的代码中有关于SSwindowView的使用教程demo

在SSwindowView.h文件中 有公开的方法如下：
/**
 *弹框展示
 *contentView: 需要展示的内容
 *contentMode:  contentView展示的位置(可取值为：UIViewContentModeCenter | UIViewContentModeTop | UIViewContentModeBottom | UIViewContentModeLeft | UIViewContentModeRight,)
 */
+ (void)showView:(UIView*)contentView contentMode:(UIViewContentMode)contentMode;
在需要使用的地方调用此方法即可

在您需要使用的类中导入头文件：
#import <SSwindowView.h>

然后在对应需求的地方直接调用方法：

[SSwindowView showView:contentView contentMode:UIViewContentModeCenter];
