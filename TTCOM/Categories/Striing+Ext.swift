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
    
    public func tt_trim(string: String = " ") -> String {
        let character = CharacterSet(charactersIn: string)
        return trimmingCharacters(in: character)
    }
    
    /** 替换字符
     - parameter string:        要被替换的字符串
     - parameter replaceString: 替换成的字符串
     - returns: 被替换过后的新字符串
     */
    func tt_replace(_ string: String, _ replaceString: String) -> String {
        return replacingOccurrences(of: string, with: replaceString)
    }
    
    /** 如果字符串的位数不够length长度, 左补齐padding字符
     - parameter length :   一共长度
     - parameter padding: 补齐的字符
     - returns: 返回totalLength长度的字符
     */
    mutating func tt_leftPadding(length: Int, padding: String) {
        for _ in count..<length {
            self =+ padding
        }
    }
    
    /** 如果字符串的位数不够length长度, 右补齐padding字符
     - parameter length :   一共长度
     - parameter padding: 补齐的字符
     - returns: 返回totalLength长度的字符
     */
    mutating func tt_rightPadding(length: Int, padding: String) {
        for _ in count..<length {
            self += padding
        }
    }
    
    // 中文 转 unicode
    public var tt_unicode: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}

extension String {
    
    public var tt_localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    public func tt_localized(arguments: CVarArg...) -> String {
        return String(format: tt_localized, arguments: arguments)
    }
}


#if canImport(UIKit)
import UIKit
extension String {
    public func tt_size(maxSize : CGSize, fontSize : CGFloat) -> CGSize {
        let font = UIFont.roundedCnFont(weight: .Bold, size: fontSize)!
        let attributes = [NSAttributedString.Key.font:font]
        let rect : CGRect = self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: rect.width + 1, height: rect.height + 1)
    }
    public func tt_size(maxSize : CGSize, font : UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font:font]
        let rect : CGRect = self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: rect.width + 1, height: rect.height + 1)
    }
}

#endif
#if canImport(AppKit)
import AppKit
extension String {
    public func tt_size(maxSize : CGSize, fontSize : CGFloat) -> NSSize {
        let font = NSFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font:font]
        let rect : CGRect = self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: rect.width + 1, height: rect.height + 1)
    }
}
#endif
