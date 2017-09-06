//
//  FloatingPointExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 2/10/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension FloatingPoint {

    /// the floored value
	public var floored: Self {
		return self.rounded(FloatingPointRoundingRule.down)
	}

    /// the ceiled value
	public var ceiled: Self {
		return self.rounded(FloatingPointRoundingRule.up)
	}
}

public extension FloatingPoint {
    
    /// the absolute value of this instance
	public func absolute() -> Self {
		return Self.abs(self)
	}
}

public extension FloatingPoint {
    
    /// the half of this value
    public var half: Self {
        return self.divided(by: Self(2))
    }
    /// the double of this value
    public var doubled: Self {
        return self.multiplied(by: Self(2))
    }
    /// the triple of this value
    public var tripled: Self {
        return self.multiplied(by: Self(3))
    }
    /// a quarter of this value
    public var quarter: Self {
        return self.divided(by: Self(4))
    }
}

public extension FloatingPoint {
    
    /// Returns the product of this value and the given value, rounded to a
    /// representable value.
    ///
    /// This method serves as the basis for the multiplication operator (`*`).
    /// For example:
    ///
    ///     let x = 7.5
    ///     print(x.multiplied(by: 2))
    ///     // Prints "15.0"
    ///     print(x * 2)
    ///     // Prints "15.0"
    ///
    /// The `multiplied(by:)` method implements the multiplication operation
    /// defined by the [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: The value to multiply by this value.
    /// - Returns: The product of this value and `other`, rounded to a
    ///   representable value.
    ///
    /// - SeeAlso: `multiply(by:)`
    public func multiplied<I>(by other: I) -> Self where I: Integer {
        return self.multiplied(by: Self(other.toIntMax()))
    }

    /// Multiplies this value by the given value in place, rounding to a
    /// representable value.
    ///
    /// This method serves as the basis for the in-place multiplication operator
    /// (`*=`). For example:
    ///
    ///     var (x, y) = (7.5, 7.5)
    ///     x.multiply(by: 2)
    ///     // x == 15
    ///     y *= 2
    ///     // y == 15
    ///
    /// - Parameter other: The value to multiply by this value.
    ///
    /// - SeeAlso: `multiplied(by:)`
    public mutating func multiply<I>(by other: I) where I: Integer {
        self.multiply(by: Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns the quotient of this value and the given value, rounded to a
    /// representable value.
    ///
    /// This method serves as the basis for the division operator (`/`). For
    /// example:
    ///
    ///     let x = 7.5
    ///     let y = x.divided(by: 2)
    ///     // y == 3.75
    ///     let z = y * 2
    ///     // z == 7.5
    ///
    /// The `divided(by:)` method implements the division operation
    /// defined by the [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: The value to use when dividing this value.
    /// - Returns: The quotient of this value and `other`, rounded to a
    ///   representable value.
    ///
    /// - SeeAlso: `divide(by:)`
    public func divided<I>(by other: I) -> Self where I: Integer {
        return self.divided(by: Self(other.toIntMax()))
    }
    
    /// Divides this value by the given value in place, rounding to a
    /// representable value.
    ///
    /// This method serves as the basis for the in-place division operator
    /// (`/=`). For example:
    ///
    ///     var (x, y) = (15.0, 15.0)
    ///     x.divide(by: 2)
    ///     // x == 7.5
    ///     y /= 2
    ///     // y == 7.5
    ///
    /// - Parameter other: The value to use when dividing this value.
    ///
    /// - SeeAlso: `divided(by:)`
    public mutating func divide<I>(by other: I) where I: Integer {
        self.divide(by: Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns the difference of this value and the given value, rounded to a
    /// representable value.
    ///
    /// This method serves as the basis for the subtraction operator (`-`). For
    /// example:
    ///
    ///     let x = 7.5
    ///     print(x.subtracting(2))
    ///     // Prints "5.5"
    ///     print(x - 2)
    ///     // Prints "5.5"
    ///
    /// The `subtracting(_:)` method implements the subtraction operation
    /// defined by the [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: The value to subtract from this value.
    /// - Returns: The difference of this value and `other`, rounded to a
    ///   representable value.
    ///
    /// - SeeAlso: `subtract(_:)`
    public func subtracting<I>(by other: I) -> Self where I: Integer {
        return self.subtracting(Self(other.toIntMax()))
    }
    
    /// Subtracts the given value from this value in place, rounding to a
    /// representable value.
    ///
    /// This method serves as the basis for the in-place subtraction operator
    /// (`-=`). For example:
    ///
    ///     var (x, y) = (7.5, 7.5)
    ///     x.subtract(2)
    ///     // x == 5.5
    ///     y -= 2
    ///     // y == 5.5
    ///
    /// - Parameter other: The value to subtract.
    ///
    /// - SeeAlso: `subtracting(_:)`
    public mutating func subtract<I>(by other: I) where I: Integer {
        self.subtract(Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns the sum of this value and the given value, rounded to a
    /// representable value.
    ///
    /// This method serves as the basis for the addition operator (`+`). For
    /// example:
    ///
    ///     let x = 1.5
    ///     print(x.adding(2))
    ///     // Prints "3.4"
    ///     print(x + 2)
    ///     // Prints "3.5"
    ///
    /// The `adding(_:)` method implements the addition operation defined by the
    /// [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: The value to add.
    /// - Returns: The sum of this value and `other`, rounded to a representable
    ///   value.
    ///
    /// - SeeAlso: `add(_:)`
    public func adding<I>(by other: I) -> Self where I: Integer {
        return self.adding(Self(other.toIntMax()))
    }
    
    /// Adds the given value to this value in place, rounded to a representable
    /// value.
    ///
    /// This method serves as the basis for the in-place addition operator
    /// (`+=`). For example:
    ///
    ///     var (x, y) = (2.25, 2.25)
    ///     x.add(7)
    ///     // x == 9.25
    ///     y += 7
    ///     // y == 9.25
    ///
    /// - Parameter other: The value to add.
    ///
    /// - SeeAlso: `adding(_:)`
    public mutating func add<I>(by other: I) where I: Integer {
        self.add(Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns the remainder of this value divided by the given value.
    ///
    /// - Parameter other: The value to use when dividing this value.
    /// - Returns: The remainder of this value divided by `other`.
    ///
    /// - SeeAlso: `formRemainder(dividingBy:)`,
    ///   `truncatingRemainder(dividingBy:)`
    public func remainder<I>(dividingBy rhs: I) -> Self where I:Integer {
        return self.remainder(dividingBy: Self(rhs.toIntMax()))
    }
    
    /// Returns the remainder of this value divided by the given value using
    /// truncating division.
    ///
    /// - Parameter other: The value to use when dividing this value.
    /// - Returns: The remainder of this value divided by `other` using
    ///   truncating division.
    ///
    /// - SeeAlso: `formTruncatingRemainder(dividingBy:)`,
    ///   `remainder(dividingBy:)`
    public func truncatingRemainder<I>(dividingBy other: I) -> Self where I:Integer {
        return self.truncatingRemainder(dividingBy: Self(other.toIntMax()))
    }
    
    /// Replaces this value with the remainder of itself divided by the given
    /// value.
    ///
    /// - Parameter other: The value to use when dividing this value.
    ///
    /// - SeeAlso: `remainder(dividingBy:)`,
    ///   `formTruncatingRemainder(dividingBy:)`
    public mutating func formRemainder<I>(dividingBy rhs: I) where I:Integer {
        self.formRemainder(dividingBy: Self(rhs.toIntMax()))
    }
    
    /// Replaces this value with the remainder of itself divided by the given
    /// value using truncating division.
    ///
    /// - Parameter other: The value to use when dividing this value.
    ///
    /// - SeeAlso: `truncatingRemainder(dividingBy:)`,
    ///   `formRemainder(dividingBy:)`
    public mutating func formTruncatingRemainder<I>(dividingBy other: I) where I:Integer {
        self.formTruncatingRemainder(dividingBy: Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns a Boolean value indicating whether this instance is less than the
    /// given value.
    ///
    /// This method serves as the basis for the less-than operator (`<`) for
    /// floating-point values. Some special cases apply:
    ///
    /// - Because NaN compares not less than nor greater than any value, this
    ///   method returns `false` when called on NaN or when NaN is passed as
    ///   `other`.
    /// - `-infinity` compares less than all values except for itself and NaN.
    /// - Every value except for NaN and `+infinity` compares less than
    ///   `+infinity`.
    ///
    ///     let x = 15.0
    ///     x.isLessThan(20.0)
    ///     // true
    ///     x.isLessThan(.nan)
    ///     // false
    ///     Double.nan.isLessThan(x)
    ///     // false
    ///
    /// The `isLess(than:)` method implements the less-than predicate defined by
    /// the [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is less than this value; otherwise, `false`.
    public func isLessThan(_ other: Self) -> Bool {
        return self.isLess(than: other)
    }

    /// Returns a Boolean value indicating whether this instance is less than the
    /// given value.
    ///
    /// This method serves as the basis for the less-than operator (`<`) for
    /// floating-point values. Some special cases apply:
    ///
    /// - Because NaN compares not less than nor greater than any value, this
    ///   method returns `false` when called on NaN or when NaN is passed as
    ///   `other`.
    /// - `-infinity` compares less than all values except for itself and NaN.
    /// - Every value except for NaN and `+infinity` compares less than
    ///   `+infinity`.
    ///
    ///     let x = 15.0
    ///     x.isLessThan(20)
    ///     // true
    ///
    /// The `isLess(than:)` method implements the less-than predicate defined by
    /// the [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is less than this value; otherwise, `false`.
    public func isLessThan<I>(_ other: I) -> Bool where I: Integer {
        return self.isLessThan(Self(other.toIntMax()))
    }
    
    /// Returns a Boolean value indicating whether this instance is less than
    /// or equal to the given value.
    ///
    /// This method serves as the basis for the greater-than operator (`<=`) for
    /// floating-point values.
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is less than or equal to this this value; otherwise, `false`.
    public func isLessThanOrEqualTo(_ other: Self) -> Bool {
        return self <= other
    }
    
    /// Returns a Boolean value indicating whether this instance is less than
    /// or equal to the given value.
    ///
    /// This method serves as the basis for the greater-than operator (`<=`) for
    /// floating-point values.
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is less than or equal to this this value; otherwise, `false`.
    public func isLessThanOrEqualTo<I>(_ other: I) -> Bool where I: Integer {
        return self.isLessThanOrEqualTo(Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns a Boolean value indicating whether this instance is greater than the
    /// given value.
    ///
    /// This method serves as the basis for the greater-than operator (`>`) for
    /// floating-point values.
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is greater than this value; otherwise, `false`.
    public func isGreaterThan(_ other: Self) -> Bool {
        return self > other
    }

    /// Returns a Boolean value indicating whether this instance is greater than the
    /// given value.
    ///
    /// This method serves as the basis for the greater-than operator (`>`) for
    /// floating-point values.
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is greater than this value; otherwise, `false`.
    public func isGreaterThan<I>(_ other: I) -> Bool where I: Integer {
        return self.isGreaterThan(Self(other.toIntMax()))
    }

    /// Returns a Boolean value indicating whether this instance is greater than
    /// or equal to the given value.
    ///
    /// This method serves as the basis for the greater-than operator (`>=`) for
    /// floating-point values.
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is greater than or equal to this this value; otherwise, `false`.
    public func isGreaterThanOrEqualTo(_ other: Self) -> Bool {
        return self >= other
    }

    /// Returns a Boolean value indicating whether this instance is greater than
    /// or equal to the given value.
    ///
    /// This method serves as the basis for the greater-than operator (`>=`) for
    /// floating-point values.
    ///
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is greater than or equal to this this value; otherwise, `false`.
    public func isGreaterThanOrEqualTo<I>(_ other: I) -> Bool where I: Integer {
        return self.isGreaterThanOrEqualTo(Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns the lesser of the two given values.
    ///
    ///     10.0.minimum(-25.0)
    ///     // -25.0
    ///     10.0.minimum(.nan)
    ///     // 10.0
    ///     Double.nan.minimum(-25.0)
    ///     // -25.0
    ///     Double.nan.minimum(.nan)
    ///     // nan
    ///
    /// The `minimum` method implements the `minNum` operation defined by the
    /// [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: Another floating-point value.
    /// - Returns: The minimum of this instance and `other` , or whichever is a number if the
    ///   other is NaN.
	public func minimum(_ other: Self) -> Self {
		return Self.minimum(self, other)
	}

    /// Returns the lesser of the two given values.
    ///
    ///     10.0.minimum(-25)
    ///     // -25.0
    ///     10.0.minimum(30)
    ///     // 10.0
    ///     Double.nan.minimum(-25)
    ///     // -25.0
    ///
    /// The `minimum` method implements the `minNum` operation defined by the
    /// [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: Another integer value.
    /// - Returns: The minimum of this instance and `other`, or whichever is a number if the
    ///   other is NaN.
    public func minimum<I>(_ other: I) -> Self where I: Integer {
        return Self.minimum(self, Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns the greater of the two given values.
    ///
    ///     10.0.maximum(-25.0)
    ///     // 10.0
    ///     10.0.maximum(.nan)
    ///     // 10.0
    ///     Double.nan.maximum(-25.0)
    ///     // -25.0
    ///     Double.nan.maximum(.nan)
    ///     // nan
    ///
    /// The `maximum` method implements the `maxNum` operation defined by the
    /// [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: Another floating-point value.
    /// - Returns: The greater of this instance and `other`, or whichever is a number if the
    ///   other is NaN.
    public func maximum(_ other: Self) -> Self {
        return Self.maximum(self, other)
    }

    /// Returns the greater of the two given values.
    ///
    ///     10.0.maximum(-25)
    ///     // 10.0
    ///     10.0.maximum(8)
    ///     // 10.0
    ///
    /// The `maximum` method implements the `maxNum` operation defined by the
    /// [IEEE 754 specification][spec].
    ///
    /// [spec]: http://ieeexplore.ieee.org/servlet/opac?punumber=4610933
    ///
    /// - Parameter other: Another floating-point value.
    /// - Returns: The greater of this instance and `other` , or whichever is a number if the
    ///   other is NaN.
    public func maximum<I>(_ other: I) -> Self where I: Integer {
        return Self.maximum(self, Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// Returns a Boolean value indicating whether this instance is NOT equal to
    /// the given value.
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is a different value from this instance;
    ///   otherwise, `false`.
	public func isDifferent(from other: Self) -> Bool {
        if self.isNaN && other.isNaN { return false }
		return not(self.isEqual(to: other))
	}

    /// Returns a Boolean value indicating whether this instance is NOT equal to
    /// the given `Integer` value.
    /// - Parameter other: The value to compare with this value.
    /// - Returns: `true` if `other` is a different value from this instance;
    ///   otherwise, `false`.
    public func isDifferent<I>(from other: I) -> Bool where I: Integer {
        if self.isNaN { return true }
        return self.isDifferent(from: Self(other.toIntMax()))
    }
}

public extension FloatingPoint {
    
    /// if the instance value is considered to represent degrees then this 
    /// property returns the a converted value that represents radians.
	public var radians: Self {
		return self.divided(by: Self(180)).multiplied(by: Self.pi)
	}

    /// if the instance value is considered to represent radians then this 
    /// property returns the a converted value that represents degrees.
	public var degrees: Self {
		return self.multiplied(by: Self(180)).divided(by: Self.pi)
	}
}
