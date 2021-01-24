//
//  CodeSegment.swift
//  TTProduct
//
//  Created by Toj on 1/8/21.
//  代码规范
//

// MARK: - e.g.1 MARK 区分大体段落
/**
 * 详细看 CodeComment.swift 【e.g.1】
 */

// MARK: - e.g.2 命名规则
// MARK: e.g.2.1 bid
/** 域名倒写
 *  com.edu.520it.www
 */

// MARK: e.g.2.2 项目名
/** 简介明了,能表达App的意义
 *  Wechat
 */

// MARK: e.g.2.3 文件
/** 为了复用扩展考虑, 尽量通用名, 利用扩展/ 继承实现不同功能
 *  尽量不要用一个"词"代表一个文件, 复用性差, 表达不清
 *
 *  TTButtonResponderProtocol 不推荐
 *  TTResponderProtocol 推荐
 */

// MARK: e.g.2.4 变量
/**
 * 驼峰方式/ 下划线
 * 驼峰方式: TTStateTitleKey
 * 下划线:  tt_state_title_key
 *
 * 不推荐混用: TT_State_Title_Key
 */

// MARK: e.g.2.4.1 全局变量
/**
 * 1. 推荐增加前缀, 区分个人唯一变量, 不排除多人开发命名冲突
 * 2. 可以全部大写, 驼峰方式, 看个人喜欢
 * 3. 建议: 全局变量写在一个文件里, 好维护, 也方便多人开发复用率
 */

// MARK: e.g.2.4.1 局部变量
/**
 * 1. 首字母小写, 驼峰方式, 看个人喜欢
 * 2. 推荐 增加前缀, 区分局部变量,
 * 2.1. 局部方法名首字母/ 固定字母开头: aAction
 * 2.2. 下划线开头: _action, Objective-C不推荐, oc:用_直接去属性值
 */

// MARK: e.g.2.4.1 属性
/**
 * 1. 首字母小写, 驼峰方式(不推荐), 看个人喜欢
 * 2. 推荐 增加前缀, 区分文件私有属性/ 对外属性,
 * 3. 如果值可能为nil, 建议swift可选类型
 * 2.1. 内部属性: 建议用1个字母前缀: t_action
 * 2.2. 对外属性: 建议用2个字母前缀: tt_action
 */
