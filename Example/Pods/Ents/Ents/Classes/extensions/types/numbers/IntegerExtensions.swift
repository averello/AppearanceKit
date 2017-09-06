//
//  IntegerExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 2/10/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension Integer {
    
    /// Evaluates the given closure as many times as the instance represents
    /// passing the current iteration.
    ///
    /// - parameter block: the closure to evaluate
    /// - precondition: The instance must by greater than zero.
    public func times(_ block: (_ i : Self) throws -> ()) rethrows {
        precondition(self >= 0)
        guard self > 0 else { return }
        
        var i = self-self // == 0
        let iterator = AnyIterator<Self> {
            defer { i = i.advanced(by: 1) }
            if i < self {
                return i
            }
            return nil
        }
        for index in iterator {
            try block(index)
        }
    }

    /// Evaluates the given closure as many times as the instance represents in 
    /// reverse.
    ///
    /// - parameter block: the closure to evaluate
    /// - precondition: The instance must by greater than zero.
    public func reversedTimes(_ block: (_ i : Self) throws -> ()) rethrows {
        try self.times { index in
            try block((self-1)-index)
        }
    }
}

public extension IntegerArithmetic {
    
    /// Returns the sum of this value and the given value.
    ///
    /// This method serves as the basis for the addition operator (`+`). For
    /// example:
    ///
    ///     let x = 1
    ///     print(x.adding(2))
    ///     // Prints "3"
    ///     print(x + 2)
    ///     // Prints "3"
    ///
    /// - Parameter other: The value to add.
    /// - Returns: The sum of this value and `other`
    ///
    /// - SeeAlso: `add(_:)`
    public func adding(_ other: Self) -> Self {
        return self + other
    }

    /// Adds the given value to this value in place.
    ///
    /// This method serves as the basis for the in-place addition operator
    /// (`+=`). For example:
    ///
    ///     var (x, y) = (2, 2)
    ///     x.add(7)
    ///     // x == 9
    ///     y += 7
    ///     // y == 9
    ///
    /// - Parameter other: The value to add.
    ///
    /// - SeeAlso: `adding(_:)`
    public mutating func add(_ other: Self) {
        self += other
    }
}

public extension IntegerArithmetic {
    
    /// Returns the difference of this value and the given value.
    ///
    /// This method serves as the basis for the subtraction operator (`-`). For
    /// example:
    ///
    ///     let x = 7
    ///     print(x.subtracting(2))
    ///     // Prints "5"
    ///     print(x - 2)
    ///     // Prints "5"
    ///
    /// - Parameter other: The value to subtract from this value.
    /// - Returns: The difference of this value and `other`.
    ///
    /// - SeeAlso: `subtract(_:)`
    public func subtracting(_ other: Self) -> Self {
        return self - other
    }

    /// Subtracts the given value from this value in place.
    ///
    /// This method serves as the basis for the in-place subtraction operator
    /// (`-=`). For example:
    ///
    ///     var (x, y) = (7, 7)
    ///     x.subtract(2)
    ///     // x == 5
    ///     y -= 2
    ///     // y == 5
    ///
    /// - Parameter other: The value to subtract.
    ///
    /// - SeeAlso: `subtracting(_:)`
    public mutating func subtract(_ other: Self) {
        self -= other
    }

    /// Returns the difference of this value and the given value.
    ///
    /// This method serves as the basis for the subtraction operator (`-`). For
    /// example:
    ///
    ///     let x = 7
    ///     print(x.difference(2))
    ///     // Prints "5"
    ///     print(x - 2)
    ///     // Prints "5"
    ///
    /// - Parameter other: The value to subtract from this value.
    /// - Returns: The difference of this value and `other`.
    ///
    /// - SeeAlso: `subtracting(_:)`
    public func difference(_ other: Self) -> Self {
        return self.subtracting(other)
    }
}

public extension IntegerArithmetic {
    
    /// Returns the product of this value and the given value.
    ///
    /// This method serves as the basis for the multiplication operator (`*`).
    /// For example:
    ///
    ///     let x = 7
    ///     print(x.multiplied(by: 2))
    ///     // Prints "14"
    ///     print(x * 2)
    ///     // Prints "14"
    ///
    /// - Parameter other: The value to multiply by this value.
    /// - Returns: The product of this value and `other`.
    ///
    /// - SeeAlso: `multiply(by:)`
    public func multiplied(by other: Self) -> Self {
        return self * other
    }

    /// Multiplies this value by the given value in place.
    ///
    /// This method serves as the basis for the in-place multiplication operator
    /// (`*=`). For example:
    ///
    ///     var (x, y) = (7, 7)
    ///     x.multiply(by: 2)
    ///     // x == 14
    ///     y *= 2
    ///     // y == 14
    ///
    /// - Parameter other: The value to multiply by this value.
    ///
    /// - SeeAlso: `multiplied(by:)`
    public mutating func multiply(by other: Self) {
        self *= other
    }
}

public extension IntegerArithmetic {
    
    /// Returns the quotient of this value and the given value.
    ///
    /// This method serves as the basis for the division operator (`/`). For
    /// example:
    ///
    ///     let x = 7
    ///     let y = x.divided(by: 2)
    ///     // y == 3
    ///     let z = x / 2
    ///     // z == 3
    ///
    /// - Parameter other: The value to use when dividing this value.
    /// - Returns: The quotient of this value and `other`.
    ///
    /// - SeeAlso: `divide(by:)`
    public func divided(by other: Self) -> Self {
        return self / other
    }

    /// Divides this value by the given value in place.
    ///
    /// This method serves as the basis for the in-place division operator
    /// (`/=`). For example:
    ///
    ///     var (x, y) = (15, 15)
    ///     x.divide(by: 2)
    ///     // x == 7
    ///     y /= 2
    ///     // y == 7
    ///
    /// - Parameter other: The value to use when dividing this value.
    ///
    /// - SeeAlso: `divided(by:)`
    public mutating func divide(by other: Self) {
        self /= other
    }
}

public extension IntegerArithmetic {
    
    /// Returns the remainder of this value divided by the given value.
    ///
    /// For two finite values `x` and `y`, the remainder `r` of dividing `x` by
    /// `y` satisfies `x == y * q + r`, where `q` is the integer nearest to
    /// `x / y`. If `x / y` is exactly halfway between two integers, `q` is
    /// chosen to be even. Note that `q` is *not* `x / y` computed in
    /// floating-point arithmetic, and that `q` may not be representable in any
    /// available integer type.
    ///
    /// The following example calculates the remainder of dividing 8.625 by 0.75:
    ///
    ///     let x = 8.625
    ///     print(x / 0.75)
    ///     // Prints "11.5"
    ///
    ///     let q = (x / 0.75).rounded(.toNearestOrEven)
    ///     // q == 12.0
    ///     let r = x.remainder(dividingBy: 0.75)
    ///     // r == -0.375
    ///
    ///     let x1 = 0.75 * q + r
    ///     // x1 == 8.625
    ///
    /// If this value and `other` are finite numbers, the remainder is in the
    /// closed range `-abs(other / 2)...abs(other / 2)`. The
    /// `remainder(dividingBy:)` method is always exact. This method implements
    /// the remainder operation defined by the [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: The value to use when dividing this value.
    /// - Returns: The remainder of this value divided by `other`.
    ///
    /// - precondition: rhs must be greater than zero.
    /// - SeeAlso: `formRemainder(dividingBy:)`,
    ///   `truncatingRemainder(dividingBy:)`
    public func remainder(dividingBy rhs: Self) -> Self {
        return self % rhs
    }
    
    /// Replaces this value with the remainder of itself divided by the given
    /// value.
    ///
    ///
    ///
    ///     var x = 9
    ///     x.formRemainder(dividingBy: 2)
    ///     // x == 1
    ///
    /// - Parameter other: The value to use when dividing this value.
    ///
    /// - precondition: rhs must be greater than zero.
    /// - SeeAlso: `remainder(dividingBy:)`
    public mutating func formRemainder(dividingBy rhs: Self) {
        self = self % rhs
    }
}

public extension IntegerArithmetic {
    
    /// Returns a Boolean value indicating whether this instance is less than the
    /// given value.
    ///
    /// This method serves as the basis for the less-than operator (`<`) for
    /// integer values.
    ///
    ///     let x = 15
    ///     x.isLessThan(20)
    ///     // true
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is less than this value; otherwise, `false`.
    public func isLessThan(_ other: Self) -> Bool {
        return (self < other)
    }

    /// Returns a Boolean value indicating whether this instance is less than or
    /// equal to the given value.
    ///
    /// This method serves as the basis for the less-than operator (`<=`) for
    /// integer values.
    ///
    ///     let x = 15
    ///     x.isLessThanOrEqualTo(20)
    ///     // true
    ///
    ///     x.isLessThanOrEqualTo(15)
    ///     // true
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is less than this value; otherwise, `false`.
    public func isLessThanOrEqualTo(_ other: Self) -> Bool {
        return (self <= other)
    }

    /// Returns a Boolean value indicating whether this instance is greater than the
    /// given value.
    ///
    ///     let x = 25
    ///     x.isGreaterThan(20)
    ///     // true
    ///
    ///     let x = 15
    ///     x.isGreaterThan(20)
    ///     // false
    ///
    /// This method serves as the basis for the greater-than operator (`>`) for
    /// integer values.
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is greater than this value; otherwise, `false`.
    public func isGreaterThan(_ other: Self) -> Bool {
        return (self > other)
    }

    /// Returns a Boolean value indicating whether this instance is greater than
    /// or equal to the given value.
    ///
    ///     let x = 25
    ///     x.isGreaterThanOrEqualTo(20)
    ///     // true
    ///
    ///     let x = 15
    ///     x.isGreaterThanOrEqualTo(20)
    ///     // false
    ///
    ///     let x = 20
    ///     x.isGreaterThanOrEqualTo(20)
    ///     // true
    ///
    /// This method serves as the basis for the greater-than operator (`>=`) for
    /// integer values.
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is greater than or equal to this this value; otherwise, `false`.
    public func isGreaterThanOrEqualTo(_ other: Self) -> Bool {
        return (self >= other)
    }
}

public extension IntegerArithmetic {
    
    /// Returns a Boolean value indicating whether this instance is equal to the
    /// given value.
    ///
    /// This method serves as the basis for the equal-to operator (`==`) for
    /// integer values. When comparing two values with this method, `-0`
    /// is equal to `+0`. For example:
    ///
    ///     let x = 15
    ///     x.isEqual(to: 15)
    ///     // true
    ///     x == 15
    ///     // true
    ///     x.isEqual(to: 17)
    ///     // false
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` has the same value as this instance;
    ///   otherwise, `false`.
    public func isEqual(to other: Self) -> Bool {
        return self == other
    }

    /// Returns a Boolean value indicating whether this instance is NOT equal to
    /// the given value.
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is a different value from this instance;
    ///   otherwise, `false`.
    public func isDifferent(from other: Self) -> Bool {
        return (self.isEqual(to: other) == false)
    }
}

public extension IntegerArithmetic {
    
    /// Returns a Boolean value indicating whether this instance is equal to the
    /// given value.
    ///
    /// This method serves as the basis for the equal-to operator (`==`) for
    /// integer values. When comparing two values with this method, `-0`
    /// is equal to `+0`. For example:
    ///
    ///     let x = 15
    ///     x.isEqual(to: 15.0)
    ///     // true
    ///     x == 15.0
    ///     // true
    ///     x.isEqual(to: 17.0)
    ///     // false
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` has the same value as this instance;
    ///   otherwise, `false`.
    public func isEqual<F>(to other: F) -> Bool where F: FloatingPoint {
        return F(self.toIntMax()).isEqual(to: other)
    }
    
    /// Returns a Boolean value indicating whether this instance is NOT equal to
    /// the given value.
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is a different value from this instance;
    ///   otherwise, `false`.
    public func isDifferent<F>(from other: F) -> Bool where F: FloatingPoint {
        return F(self.toIntMax()).isDifferent(from: other)
    }
}

public extension IntegerArithmetic {
    
    /// Returns the lesser of the two given values.
    ///
    ///     10.minimum(-25)
    ///     // -25
    ///
    /// - Parameter other: Another integer value.
    /// - Returns: The minimum of this instance and `other`.
    /// - SeeAlso: `min(:)`
    public func minimum(_ other: Self) -> Self {
        return Swift.min(self, other)
    }

    /// Returns the greater of the two given values.
    ///
    ///     10.maximum(-25)
    ///     // 10
    ///
    /// - Parameter other: Another integer value.
    /// - Returns: The greater of this instance and `other`.
    /// - SeeAlso: `max(:)`
    public func maximum(_ other: Self) -> Self {
        return Swift.max(self, other)
    }

    /// Returns the lesser of the two given values.
    ///
    ///     10.minimum(-25)
    ///     // -25
    ///
    /// - Parameter other: Another integer value.
    /// - Returns: The minimum of this instance and `other`.
    /// - SeeAlso: `minimum(:)`
    public mutating func min(_ other: Self) {
        self = self.minimum(other)
    }

    /// Returns the greater of the two given values.
    ///
    ///     10.maximum(-25)
    ///     // 10
    ///
    /// - Parameter other: Another integer value.
    /// - Returns: The greater of this instance and `other`.
    /// - SeeAlso: `maximum(:)`
    public mutating func max(_ other: Self) {
        self = self.maximum(other)
    }
}

public extension IntegerArithmetic {
    
    /// Returns the lesser of the two given values.
    ///
    ///     10.minimum(-25.0)
    ///     // -25.0
    ///
    /// - Parameter other: Another integer value.
    /// - Returns: The minimum of this instance and `other`.
    public func minimum<F>(_ other: F) -> F where F: FloatingPoint {
        return F(self.toIntMax()).minimum(other)
    }
    
    /// Returns the greater of the two given values.
    ///
    ///     10.maximum(-25.0)
    ///     // 10.0
    ///
    /// - Parameter other: Another integer value.
    /// - Returns: The greater of this instance and `other`.
    public func maximum<F>(_ other: F) -> F where F: FloatingPoint {
        return F(self.toIntMax()).maximum(other)
    }
}

public extension IntegerArithmetic where Self: SignedInteger {
    
    /// Returns the absolute value of this instance
    public func absolute() -> Self {
        return Swift.abs(self)
    }

    /// Replaces this value with its additive inverse.
    ///
    /// This example uses the `negate()` method to
    /// negate the value of the variable `x`:
    ///
    ///     var x = 21
    ///     x.negate()
    ///     // x == -21
    ///
    /// - SeeAlso: `negated()`
    public mutating func negate() {
        self = self.negated()
    }

    /// Returns the additive inverse of this value.
    ///
    /// This method serves as the basis for the
    /// negation operator (prefixed `-`). For example:
    ///
    ///     let x = 21
    ///     let y = x.negated()
    ///     // y == -21
    ///
    /// - Returns: The additive inverse of this value.
    ///
    /// - SeeAlso: `negate()`
    public func negated() -> Self {
        return -self
    }
}

public extension Integer {
    
    /// converts this `Integer` instance to a `NSNumber` instance.
    public var asNumber: NSNumber {
        return NSNumber(value: self.toIntMax())
    }
}

public extension SignedInteger {
    
    /// create a SignedInteger from a Boolean
    public init(_ v: Bool) {
        if v {
            self.init(1)
        }
        else {
            self.init(0)
        }
    }
    
    /// Returns a integer value that is raised to the power of `p`.
    /// - parameter p: an integer power.
    public func power(_ p: Self) -> Self {
        let result = Double(self.toIntMax()).power(p)
        let integer = IntMax(result)
        return Self(integer)
    }
    
    /// returns the square value of this instance.
    public var square: Self {
        return self.power(2)
    }
    
    /// returns the cube value of this instance.
    public var cube: Self {
        return self.power(3)
    }
}

public extension UnsignedInteger {
    
    /// create a UnsignedInteger from a Boolean
    public init(_ v: Bool) {
        if v {
            self.init(1)
        }
        else {
            self.init(0)
        }
    }
    
    /// Returns a integer value that is raised to the power of `p`.
    /// - parameter p: an integer power.
    public func power(_ p: Self) -> Self {
        let result = Double(self.toUIntMax()).power(p)
        let integer = UIntMax(result)
        return Self(integer)
    }
    
    /// returns the square value of this instance.
    public var square: Self {
        return self.power(2)
    }
    
    /// returns the cube value of this instance.
    public var cube: Self {
        return self.power(3)
    }
}
