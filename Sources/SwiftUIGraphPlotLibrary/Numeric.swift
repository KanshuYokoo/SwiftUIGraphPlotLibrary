//
//  File.swift
//  
//
//  Created by 観周 横尾 on 29/08/2021.
//

import Foundation
import CoreGraphics


//Castting number type to CGFloat with a robust way
//This solution was from stockoverfolw
//https://stackoverflow.com/questions/39486362/how-to-cast-generic-number-type-t-to-cgfloat

protocol Numeric : Comparable {

    init(_ v:Float)
    init(_ v:Double)
    init(_ v:Int)
    init(_ v:UInt)
    init(_ v:Int8)
    init(_ v:UInt8)
    init(_ v:Int16)
    init(_ v:UInt16)
    init(_ v:Int32)
    init(_ v:UInt32)
    init(_ v:Int64)
    init(_ v:UInt64)
    init(_ v:CGFloat)

    func _asOther<T:Numeric>() -> T
}

extension Numeric {
    init<T:Numeric>(fromNumeric numeric: T) { self = numeric._asOther() }
}

extension Float   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Double  : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension CGFloat : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int     : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int8    : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int16   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int32   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int64   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt    : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt8   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt16  : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt32  : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt64  : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
