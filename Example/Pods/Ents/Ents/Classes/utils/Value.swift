//
//  Value.swift
//  EntsKit
//
//  Created by Georges Boumis on 13/06/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation


public protocol Value: Comparable, Equatable, CustomStringConvertible {
    associatedtype T: Comparable, Equatable
    var value: T { get }
    init(value: T)
}

//MARK: Act as a CustomStringConvertible

extension Value {

    public var description: String {
        return "\(self.value)"
    }
}

//MARK: Act as a Equatable

extension Value {

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return (lhs.value == rhs.value)
    }

    public static func !=(lhs: Self, rhs: Self) -> Bool {
        return !(lhs == rhs)
    }
}

//MARK: Act as a Comparable

extension Value {

    public static func >(lhs: Self, rhs: Self) -> Bool {
        return (lhs.value > rhs.value)
    }

    public static func <(lhs: Self, rhs: Self) -> Bool {
        return (lhs.value < rhs.value)
    }

    public static func <=(lhs: Self, rhs: Self) -> Bool {
        return (lhs.value <= rhs.value)
    }

    public static func >=(lhs: Self, rhs: Self) -> Bool {
        return (lhs.value >= rhs.value)
    }
}

//MARK: Act as a Hashable

extension Value where T: Hashable {

    public var hashValue: Int {
        return self.value.hashValue
    }
}

//MARK: Act as a IntegerArithmetic

extension Value where T: IntegerArithmetic {

    public static func ==(lhs: Self, rhs: T) -> Bool {
        return (lhs.value == rhs)
    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        return lhs + rhs.value
    }

    public static func -(lhs: Self, rhs: Self) -> Self {
        return lhs - rhs.value
    }

    public static func *(lhs: Self, rhs: Self) -> Self {
        return lhs * rhs.value
    }

    public static func /(lhs: Self, rhs: Self) -> Self {
        return lhs / rhs.value
    }

    public static func %(lhs: Self, rhs: Self) -> Self {
        return lhs % rhs.value
    }


    //
    public static func +(lhs: Self, rhs: T) -> Self {
        return Self(value: lhs.value + rhs)
    }

    public static func -(lhs: Self, rhs: T) -> Self {
        return Self(value: lhs.value - rhs)
    }

    public static func *(lhs: Self, rhs: T) -> Self {
        return Self(value: lhs.value * rhs)
    }

    public static func /(lhs: Self, rhs: T) -> Self {
        return Self(value: lhs.value / rhs)
    }

    public static func %(lhs: Self, rhs: T) -> Self {
        return Self(value: lhs.value % rhs)
    }

    public func toIntMax() -> IntMax {
        return self.value.toIntMax()
    }

    public static func addWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        return Self.addWithOverflow(lhs, rhs.value)
    }

    public static func subtractWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        return Self.subtractWithOverflow(lhs, rhs.value)
    }

    public static func multiplyWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        return Self.multiplyWithOverflow(lhs, rhs.value)
    }

    public static func divideWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        return Self.divideWithOverflow(lhs, rhs.value)
    }

    public static func remainderWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        return Self.remainderWithOverflow(lhs, rhs.value)
    }

    //

    public static func addWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
        let res = T.addWithOverflow(lhs.value, rhs)
        return (Self(value: res.0), overflow: res.overflow)
    }

    public static func subtractWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
        let res = T.subtractWithOverflow(lhs.value, rhs)
        return (Self(value: res.0), overflow: res.overflow)
    }

    public static func multiplyWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
        let res = T.multiplyWithOverflow(lhs.value, rhs)
        return (Self(value: res.0), overflow: res.overflow)
    }

    public static func divideWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
        let res = T.divideWithOverflow(lhs.value, rhs)
        return (Self(value: res.0), overflow: res.overflow)
    }

    public static func remainderWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
        let res = T.remainderWithOverflow(lhs.value, rhs)
        return (Self(value: res.0), overflow: res.overflow)
    }

    //

    public static func +=(lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs.value
    }

    public static func -=(lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs.value
    }

    public static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs.value
    }

    public static func /=(lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs.value
    }

    public static func %=(lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs.value
    }

    //

    public static func +=(lhs: inout Self, rhs: T) {
        lhs = Self(value: lhs.value + rhs)
    }

    public static func -=(lhs: inout Self, rhs: T) {
        lhs = Self(value: lhs.value - rhs)
    }

    public static func *=(lhs: inout Self, rhs: T) {
        lhs = Self(value: lhs.value * rhs)
    }

    public static func /=(lhs: inout Self, rhs: T) {
        lhs = Self(value: lhs.value / rhs)
    }

    public static func %=(lhs: inout Self, rhs: T) {
        lhs = Self(value: lhs.value % rhs)
    }
}

//MARK: Act as a SignedInteger

extension Value where T: SignedInteger {

    public func absolute() -> Self {
        return Self(value: self.value.absolute())
    }

    public func negated() -> Self {
        return Self(value: self.value.negated())
    }

    public mutating func negate() {
        self = self.negated()
    }
}

//MARK: Act as a FloatingPoint

extension Value where T: FloatingPoint {

    public func adding(_ other: Self) -> Self {
        return self.adding(other.value)
    }
    public func subtracting(_ other: Self) -> Self {
        return self.subtracting(other.value)
    }
    public func multiplied(by other: Self) -> Self {
        return self.multiplied(by: other.value)
    }
    public func divided(by other: Self) -> Self {
        return self.divided(by: other.value)
    }


    public func adding(_ other: T) -> Self {
        return Self(value: self.value.adding(other))
    }
    public func subtracting(_ other: T) -> Self {
        return Self(value: self.value.subtracting(other))
    }
    public func multiplied(by other: T) -> Self {
        return Self(value: self.value.multiplied(by: other))
    }
    public func divided(by other: T) -> Self {
        return Self(value: self.value.divided(by: other))
    }


    public func negated() -> Self {
        return Self(value: self.value.negated())
    }

    public func absolute() -> Self {
        return Self(value: self.value.absolute())
    }


    public func minimum(_ other: Self) -> Self {
        return Self(value: self.value.minimum(other.value))
    }

    public func maximum(_ other: Self) -> Self {
        return Self(value: self.value.maximum(other.value))
    }
}

//MARK: Act as a Strideable

extension Value where T: Strideable {

    public func distance(to other: Self) -> T.Stride {
        return self.value.distance(to: other.value)
    }

    public func advanced(by amount: T.Stride) -> Self {
        return Self(value: self.value.advanced(by: amount))
    }
}


//MARK: Operators

prefix public func -<V>(x: V) -> V where V: Value, V.T : SignedNumber {
    return V(value: -x.value)
}

prefix public func +<V>(x: V) -> V where V: Value {
    return x
}

public func +<V>(lhs: V, rhs: V) -> V where V: Value, V.T: IntegerArithmetic {
    return V(value: lhs.value + rhs.value)
}

public func -<V>(lhs: V, rhs: V) -> V where V: Value, V.T: IntegerArithmetic {
    return V(value: lhs.value - rhs.value)
}

public func *<V>(lhs: V, rhs: V) -> V where V: Value, V.T: IntegerArithmetic {
    return V(value: lhs.value * rhs.value)
}

public func /<V>(lhs: V, rhs: V) -> V where V: Value, V.T: IntegerArithmetic {
    return V(value: lhs.value / rhs.value)
}

public func %<V>(lhs: V, rhs: V) -> V where V: Value, V.T: IntegerArithmetic {
    return V(value: lhs.value % rhs.value)
}


//MARK: Act as a Collection

extension Value where T: Collection {
    
    public typealias Element = T.Iterator.Element
    public typealias Index = T.Index
    public typealias IndexDistance = T.IndexDistance
    public typealias Iterator = T.Iterator

    public func makeIterator() -> Iterator { return self.value.makeIterator() }
    public var startIndex: Index { return self.value.startIndex }
    public var endIndex: Index { return self.value.endIndex }
    public var count: IndexDistance { return self.value.count }
    public subscript(i: Index) -> Element { return self.value[i] }
    public func index(after i: Index) -> Index { return self.value.index(after: i) }

    
}
