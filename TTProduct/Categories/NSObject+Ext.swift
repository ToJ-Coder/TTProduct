//
//  NSObject+Ext.swift
//  TTProduct
//
//  Created by Toj on 1/11/21.
//

import AppKit

extension NSObject {
    
    #if DEBUG
    
    class func tt_propertyList() -> [String] {
        var ptyList: [String] = []
        
        // 1.获取“类”的属性列表
        var count: UInt32 = 0
        guard let list = class_copyPropertyList(self, &count) else { return ptyList}
        
        print("属性数量：\(count)")
        // 2.遍历数组
        for i in 0..<Int(count) {
            // 3.根据下标获取属性
            let pty = list[i]
            
            // 4.获取“属性”的名称的C语言字符串
            let cName = property_getName(pty)
            // 5.转换成String的字符串
            if let name = String(utf8String: cName) {
                print(name)
                ptyList.append(name)
            }
        }
        
        // 6.释放C语言的对象
        free(list)
        return ptyList
    }
    
    class func tt_ivarList() -> [String] {
        var ptyList: [String] = []
        
        // 1.获取“类”的属性列表
        var count: UInt32 = 0
        guard let list = class_copyIvarList(self, &count) else { return ptyList }
        
        // 2.遍历数组
        for i in 0..<Int(count) {
            // 3.根据下标获取属性
            let pty = list[i]
            // 4.获取“属性”的名称的C语言字符串
            guard let cName = ivar_getName(pty) else { continue }
            
            // 5.转换成String的字符串
            if let name = String(utf8String: cName) {
                print(name)
                ptyList.append(name)
            }
        }
        
        // 6.释放C语言的对象
        free(list)
        return ptyList
    }
    
    #endif
}
