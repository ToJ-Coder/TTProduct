//
//  Documentation.swift
//  TTProduct

//  Created by Taurin on 1/6/21.
//  Specification Document
//  Swift 总结开发中规范
//

// MARK: - e.g.1 MARK, FIXME, TUDO

// MARK：理清逻辑 ，将方法属性归类整理
// TODO：提醒
// FIXME：待修改
/** MARK:  代码文件结构标记，可以显示文件的大致结构和模块，说明建议使用首字母大写
 * // MARK: - Properties
 * // MARK: Lazy
 * // MARK: UI
 * // MARK: - Cycle
 * // MARK: - Override
 * // MARK: - IBAction Method
 * // MARK: - Public
 * // MARK: - Private
 * // MARK: - Setup / Initialization
 * // MARK: - XXXDelegate
 *
 * // FIXME: 这里做出修改
 * // TUDO:  进入这个方法表示已接收到内存警告，需要做出处理
 */

// MARK: - e.g.2 方法注释

/// 求和
/// - parameter value:  数值1
/// - parameter value2: 数值2
/// - returns : 返回结果是
///
///  ```
///  let _ = tt_sum(value: 1, value2: 2)
///  ```
/// 必须是2个整数
/// 
/// Note: 2个数不能太大
func tt_sum(value: Int, value2: Int) -> Int {
    return value + value2
}

// MARK: - e.g.3 文档注释

/** 求和
 # 支持markdown
 - https://nshipster.com/swift-documentation/
 # 一级标题
 ## 二级标题
 
 注释参考2
 隔一行标识换行
 
 三个"***"代表一条分割线
 ***
 ## 使用实例
 ```
 let _ = tt_sum2(value: 1, value2: 2)
 ```
 ***
 - important: 测试
 - parameter value: 值1
 - parameter value2: 值2
 - returns: 2个值的加值
 - Throws: `MyError.BothNilError` if both item1 and item2 are nil. 抛出异常
 - Author: toj 作者
 */
func tt_sum2(value: Int, value2: Int) -> Int {
    return value + value2
}

/// 求和
/// - parameter value: This is item1
/// - parameter value2: This is item2
/// - Returns: the result string. 返回值
func tt_sum3(value: Int, value2: Int) -> Int {
    return value + value2
}


func draw() {
    
    let _ = tt_sum(value: 1, value2: 2)
    
    let _ = tt_sum2(value: 1, value2: 2)
    
    let _ = tt_sum3(value: 1, value2: 2)
    let _ = tt_sum4(value: 1, value2: 2)
}

/// fasdf
func tt_sum4(value: Int, value2: Int) -> Int {
    return value + value2
}
