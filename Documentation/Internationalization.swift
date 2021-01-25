//
//  Internationalization.swift
//  Documentation
//
//  Created by Toj on 1/25/21.
//  国际化
//

// MARK: -
/**
 1. 需要对工程设置支持哪几种语言做国际化, 并且对当前xib文件做国际化
 1.1 找到Project, 注意不是TARGETS
 1.2 找到 Localization 添加对应的语言, 并且把项目中xib文件生成对应的语言包
 # xib也可以不生成, 用代码去设置
 
 2. app 名字国际化
 2.1 创建 InfoPlist.strings文件
 2.2 设置app 名字
 "CFBundleDisplayName" = "TT";
 #需要对中英文都设置, 否则默认值是英文对应值
 2.3 需要告诉项目支持国际化(Mac)
 找到 info.plist文件, 添加如下字段, 设置YES
 Application has localized display name = YES
 
 3. 文案国际化
 3.1 创建 Localizable.strings文件
 3.2 定义变量就可以
 "关闭" = "关闭";
 3.3 利用系统函数直接调用
 NSLocalizedString("关闭", comment: "")
 */
