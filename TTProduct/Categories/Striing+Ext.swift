//
//  Striing+Ext.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

import Foundation

extension String {
    /** 分割成数组
     - parameter separator: 分割符
     - returns: 分割的数组
     */
    func tt_split(_ separator: String) -> [String] {
        return components(separatedBy: CharacterSet(charactersIn:separator))
    }
    
    /** 去除左右空格 */
    var tt_trim: String {
        return trimmingCharacters(in: .whitespaces)
    }
    
    /** 替换字符
     - parameter oldString:     要被替换的字符串
     - parameter replaceString: 替换成的字符串
     - returns: 被替换过后的新字符串
     */
    func tt_replace(_ string: String, _ replaceString: String) -> String {
        return replacingOccurrences(of: string, with: replaceString)
    }
    
    /** 如果字符串的位数不够totalLength长度, 左补齐paddingString字符
     - parameter totalLength:   一共长度
     - parameter paddingString: 补齐的字符
     - returns: 返回totalLength长度的字符
     */
    mutating func tt_leftPadding(length: Int, padding: String) {
        for _ in count..<length {
            self =+ padding
        }
    }
    
    /**
     如果字符串的位数不够totalLength长度, 右补齐paddingString字符
     
     - parameter totalLength:   一共长度
     - parameter paddingString: 补齐的字符
     
     - returns: 返回totalLength长度的字符
     */
    mutating func tt_rightPadding(length: Int, padding: String) {
        for _ in count..<length {
            self += padding
        }
    }
}
