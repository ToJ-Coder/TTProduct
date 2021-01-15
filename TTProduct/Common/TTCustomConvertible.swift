//
//  TTCustomConvertible.swift
//  TTProduct
//
//  Created by Toj on 1/15/21.
//  基本类型强制类型转换
//

#if !TARGET_OS_IPHONE
import AppKit
#else
import UIKit
#endif

// MARK: protocol
protocol ExtString { }

protocol ExtInt { }

protocol ExtFloat { }


// MARK: - extension ExtString
extension ExtString where Self : CustomStringConvertible {
    // 转Int
    var tt_toInt: Int {
        var val = 0
        if let string = self as? String {
            val = Int(string) ?? 0
        }
        return val
    }
    
    var tt_toInt8: Int8 {
        var val:Int8 = 0
        if let string = self as? String {
            val = Int8(string) ?? 0
        }
        return val
    }
    
    var tt_toInt16: Int16 {
        var val:Int16 = 0
        if let string = self as? String {
            val = Int16(string) ?? 0
        }
        return val
    }
    
    var tt_toInt32: Int32 {
        var val:Int32 = 0
        if let string = self as? String {
            val = Int32(string) ?? 0
        }
        return val
    }
    
    var tt_toInt64: Int64 {
        var val:Int64 = 0
        if let string = self as? String {
            val = Int64(string) ?? 0
        }
        return val
    }
    
    var tt_toUInt: UInt {
        var val:UInt = 0
        if let string = self as? String {
            val = UInt(string) ?? 0
        }
        return val
    }
    
    var tt_toUInt8: UInt8 {
        var val:UInt8 = 0
        if let string = self as? String {
            val = UInt8(string) ?? 0
        }
        return val
    }
    
    var tt_toUInt16: UInt16 {
        var val:UInt16 = 0
        if let string = self as? String {
            val = UInt16(string) ?? 0
        }
        return val
    }
    
    var tt_toUInt32: UInt32 {
        var val:UInt32 = 0
        if let string = self as? String {
            val = UInt32(string) ?? 0
        }
        return val
    }
    
    var tt_toUInt64: UInt64 {
        var val:UInt64 = 0
        if let string = self as? String {
            val = UInt64(string) ?? 0
        }
        return val
    }
    
    var tt_toDouble: Double {
        var val:Double = 0
        if let string = self as? String {
            val = Double(string) ?? 0
        }
        return val
    }
    
    var tt_toFloat: Float {
        var val:Float = 0
        if let string = self as? String {
            val = Float(string) ?? 0
        }
        return val
    }
    
    var tt_toFloat32: Float32 {
        var val:Float32 = 0
        if let string = self as? String {
            val = Float32(string) ?? 0
        }
        return val
    }
    
    var tt_toFloat64: Float64 {
        return tt_toDouble
    }
    
    var tt_toFloat80: Float80 {
        var val:Float80 = 0
        if let string = self as? String {
            val = Float80(string) ?? 0
        }
        return val
    }
}


// MARK: - extension ExtInt
extension ExtInt where Self : BinaryInteger {
    var tt_toString: String {
        return String(self)
    }
    
    var tt_toInt8: Int8 {
        return Int8(self)
    }
    
    var tt_toInt16: Int16 {
        return Int16(self)
    }
    
    var tt_toInt32: Int32 {
        return Int32(self)
    }
    
    var tt_toInt64: Int64 {
        return Int64(self)
    }
    
    var tt_toUInt: UInt {
        return UInt(self)
    }
    
    var tt_toUInt8: UInt8 {
        return UInt8(self)
    }
    
    var tt_toUInt16: UInt16 {
        return UInt16(self)
    }
    
    var tt_toUInt32: UInt32 {
        return UInt32(self)
    }
    
    var tt_toUInt64: UInt64 {
        return UInt64(self)
    }
    
    // == Float64
    var tt_toDouble: Double {
        return Double(self)
    }
    
    // == Float32
    var tt_toFloat: Float {
        return Float(self)
    }
    
    // == Float
    var tt_toFloat32: Float32 {
        return Float32(self)
    }
    
    // == Double
    var tt_toFloat64: Float64 {
        return Float64(self)
    }
    
    var tt_toFloat80: Float80 {
        return Float80(self)
    }
}


// MARK: - extension ExtFloat
extension ExtFloat where Self : LosslessStringConvertible {
    var tt_toString: String {
        return String(self)
    }
}

extension ExtFloat where Self : BinaryFloatingPoint {
    var tt_toInt: Int {
        return Int(self)
    }
    
    var tt_toInt8: Int8 {
        return Int8(self)
    }
    
    var tt_toInt16: Int16 {
        return Int16(self)
    }
    
    var tt_toInt32: Int32 {
        return Int32(self)
    }
    
    var tt_toInt64: Int64 {
        return Int64(self)
    }
    
    var tt_toUInt: UInt {
        return UInt(self)
    }
    
    var tt_toUInt8: UInt8 {
        return UInt8(self)
    }
    
    var tt_toUInt16: UInt16 {
        return UInt16(self)
    }
    
    var tt_toUInt32: UInt32 {
        return UInt32(self)
    }
    
    var tt_toUInt64: UInt64 {
        return UInt64(self)
    }
    
    // == Float32
    var tt_toFloat: Float {
        return Float(self)
    }
    
    // == toFloat
    var tt_toFloat32: Float32 {
        return Float32(self)
    }
    
    var tt_toFloat80: Float80 {
        return Float80(self)
    }
}


// MARK: - extension String
extension String : ExtString {
    
    var tt_toData: Data? {
        return data(using: .utf8)
    }
    
    var tt_toDictionary: [String: Any]? {
        return tt_toDictionary(t: Any.self)
    }
    
    func tt_toDictionary<Value>(t:Value) -> [String: Value]? {
        guard let data = tt_toData else { return nil }
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        return json as? Dictionary<String, Value>
    }
    
    var tt_toArray: [Any]? {
        return tt_toArray(t: Any.self)
    }
    
    func tt_toArray<T>(t:T) -> [T]? {
        guard let data = tt_toData else { return nil }
        let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        return object as? [T]
    }
}


// MARK: - extension Int
extension Int : ExtInt { }

// MARK: extension Int8
extension Int8 : ExtInt { }

// MARK: extension Int16
extension Int16 : ExtInt  { }

// MARK: extension Int32
extension Int32 : ExtInt  { }

// MARK: extension Int64
extension Int64 : ExtInt  { }

// MARK: extension UInt
extension UInt : ExtInt  { }

// MARK: extension UInt8
extension UInt8 : ExtInt  { }

// MARK: extension UInt16
extension UInt16 : ExtInt  { }

// MARK: extension UInt32
extension UInt32 : ExtInt  { }

// MARK: extension UInt64
extension UInt64 : ExtInt  { }


// MARK: - extension Float
// Float == Float32
extension Float : ExtFloat { }

// MARK: extension Double
// Double == Float64
extension Double: ExtFloat { }

// MARK: extension Float80
extension Float80 : ExtFloat { }

extension Dictionary {
    
    var tt_toJson: String? {
        guard let data = tt_toData else { return nil }
        let json = String(data: data, encoding:.utf8)
        return json
    }
    
    var tt_toData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
    }
}

extension Array {
    
    var tt_toJson: String? {
        guard let data = tt_toData else { return nil }
        let json = String(data: data, encoding:.utf8)
        return json
    }
    
    var tt_toData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
    }
}

extension Data {
    
    var tt_toJson: String? {
        return String(data: self, encoding:.utf8)
    }
    
    var tt_toDictionary: [String: Any]? {
        return tt_toDictionary(t: Any.self)
    }
    
    func tt_toDictionary<Value>(t:Value) -> [String: Value]? {
        let json = try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
        
        return json as? Dictionary<String, Value>
    }
    
    var tt_toArray: [Any]? {
        return tt_toArray(t: Any.self)
    }
    
    func tt_toArray<T>(t:T) -> [T]? {
        let object = try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
        
        return object as? [T]
    }
}
