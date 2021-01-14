/**
 基本类型强制类型转换
 */

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
    var toInt: Int {
        var val = 0
        if let string = self as? String {
            val = Int(string) ?? 0
        }
        return val
    }
    
    var toInt8: Int8 {
        var val:Int8 = 0
        if let string = self as? String {
            val = Int8(string) ?? 0
        }
        return val
    }
    
    var toInt16: Int16 {
        var val:Int16 = 0
        if let string = self as? String {
            val = Int16(string) ?? 0
        }
        return val
    }
    
    var toInt32: Int32 {
        var val:Int32 = 0
        if let string = self as? String {
            val = Int32(string) ?? 0
        }
        return val
    }
    
    var toInt64: Int64 {
        var val:Int64 = 0
        if let string = self as? String {
            val = Int64(string) ?? 0
        }
        return val
    }
    
    var toUInt: UInt {
        var val:UInt = 0
        if let string = self as? String {
            val = UInt(string) ?? 0
        }
        return val
    }
    
    var toUInt8: UInt8 {
        var val:UInt8 = 0
        if let string = self as? String {
            val = UInt8(string) ?? 0
        }
        return val
    }
    
    var toUInt16: UInt16 {
        var val:UInt16 = 0
        if let string = self as? String {
            val = UInt16(string) ?? 0
        }
        return val
    }
    
    var toUInt32: UInt32 {
        var val:UInt32 = 0
        if let string = self as? String {
            val = UInt32(string) ?? 0
        }
        return val
    }
    
    var toUInt64: UInt64 {
        var val:UInt64 = 0
        if let string = self as? String {
            val = UInt64(string) ?? 0
        }
        return val
    }
    
    var toDouble: Double {
        var val:Double = 0
        if let string = self as? String {
            val = Double(string) ?? 0
        }
        return val
    }
    
    var toFloat: Float {
        var val:Float = 0
        if let string = self as? String {
            val = Float(string) ?? 0
        }
        return val
    }
    
    var toFloat32: Float32 {
        var val:Float32 = 0
        if let string = self as? String {
            val = Float32(string) ?? 0
        }
        return val
    }
    
    var toFloat64: Float64 {
        return toDouble
    }
    
    var toFloat80: Float80 {
        var val:Float80 = 0
        if let string = self as? String {
            val = Float80(string) ?? 0
        }
        return val
    }
}


// MARK: - extension ExtInt
extension ExtInt where Self : BinaryInteger {
    var toString: String {
        return String(self)
    }
    
    var toInt8: Int8 {
        return Int8(self)
    }
    
    var toInt16: Int16 {
        return Int16(self)
    }
    
    var toInt32: Int32 {
        return Int32(self)
    }
    
    var toInt64: Int64 {
        return Int64(self)
    }
    
    var toUInt: UInt {
        return UInt(self)
    }
    
    var toUInt8: UInt8 {
        return UInt8(self)
    }
    
    var toUInt16: UInt16 {
        return UInt16(self)
    }
    
    var toUInt32: UInt32 {
        return UInt32(self)
    }
    
    var toUInt64: UInt64 {
        return UInt64(self)
    }
    
    // == Float64
    var toDouble: Double {
        return Double(self)
    }
    
    // == Float32
    var toFloat: Float {
        return Float(self)
    }
    
    // == Float
    var toFloat32: Float32 {
        return Float32(self)
    }
    
    // == Double
    var toFloat64: Float64 {
        return Float64(self)
    }
    
    var toFloat80: Float80 {
        return Float80(self)
    }
}


// MARK: - extension ExtFloat
extension ExtFloat where Self : LosslessStringConvertible {
    var toString: String {
        return String(self)
    }
}

extension ExtFloat where Self : BinaryFloatingPoint {
    var toInt: Int {
        return Int(self)
    }
    
    var toInt8: Int8 {
        return Int8(self)
    }
    
    var toInt16: Int16 {
        return Int16(self)
    }
    
    var toInt32: Int32 {
        return Int32(self)
    }
    
    var toInt64: Int64 {
        return Int64(self)
    }
    
    var toUInt: UInt {
        return UInt(self)
    }
    
    var toUInt8: UInt8 {
        return UInt8(self)
    }
    
    var toUInt16: UInt16 {
        return UInt16(self)
    }
    
    var toUInt32: UInt32 {
        return UInt32(self)
    }
    
    var toUInt64: UInt64 {
        return UInt64(self)
    }
    
    // == Float32
    var toFloat: Float {
        return Float(self)
    }
    
    // == toFloat
    var toFloat32: Float32 {
        return Float32(self)
    }
    
    var toFloat80: Float80 {
        return Float80(self)
    }
}


// MARK: - extension String
extension String : ExtString  {}


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
