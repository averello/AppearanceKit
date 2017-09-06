//
//  CGSizeRounding.swift
//  UIViewPosition
//
//  Created by Georges Boumis on 12/04/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import CoreGraphics

/// Compose two `CGFloat` to form a CGSize operator
infix operator |: AdditionPrecedence

public func | (lhs: CGFloat, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs, height: rhs)
}

public func | (lhs: Int, rhs: Int) -> CGSize {
    return CGSize(width: lhs, height: rhs)
}

public func | (lhs: Double, rhs: Double) -> CGSize {
    return CGSize(width: CGFloat(lhs), height: CGFloat(rhs))
}

public func | (lhs: Float, rhs: Float) -> CGSize {
    return CGSize(width: CGFloat(lhs), height: CGFloat(rhs))
}

public extension CGSize {
    
    /// returns a new CGSize with floored `width` and `height` of the receiver
    public var floored: CGSize {
		var size = self
		size.width  = self.width.floored
		size.height = self.height.floored
		return size
    }


    /// floors `width` and `height`
    public mutating func floor() {
		self = self.floored
    }

    /// returns a new CGSize with ceiled `width` and `height` of the receiver
    public var ceiled: CGSize {
		var size = self
		size.width  = self.width.ceiled
		size.height = self.height.ceiled
		return size
    }

    /// ceils `width` and `height`
    public mutating func ceil() {
        self = self.ceiled
    }
}

public extension CGSize {
    
    /// returns a CGSize double is size
    public var doubled: CGSize {
        return CGSize(width: self.width.doubled,
                      height: self.height.doubled)
    }
    
    /// returns half a CGSize
    public var halfed: CGSize {
        return CGSize(width: self.width.half,
                      height: self.height.half)
    }
}

public extension CGSize {
    
    /// creates a CGSize which is scaled by the given factor.
    /// - parameter scale: the factor to scale with.
    public func scaled(_ scale: CGFloat) -> CGSize {
        var size = self
        size.scale(scale)
        return size
    }

    /// creates a CGSize which is scaled by the given factors.
    /// - parameter dx: the factor to scale `width`.
    /// - parameter dy: the factor to scale `height`.
    public func scaled(_ dx: CGFloat, dy: CGFloat) -> CGSize {
        var size = self
        size.scale(dx, dy: dy)
        return size
    }

    /// creates a CGSize which is scaled by the given factors.
    /// - parameter wS: the factor to scale `width`.
    /// - parameter hS: the factor to scale `height`
    public func scaled(widthScale wS: CGFloat, heightScale hS: CGFloat) -> CGSize {
        var size = self
        size.scale(widthScale: wS, heightScale: hS)
        return size
    }

    /// scales the receiver with the given factor.
    /// - parameter scale: the factor to scale with.
    public mutating func scale(_ scale: CGFloat) {
        self.scale(widthScale: scale, heightScale: scale)
    }

    /// scales the receiver with the given factors.
    /// - parameter wS: the factor to scale `width`.
    /// - parameter hS: the factor to scale `height`
    public mutating func scale(widthScale wS: CGFloat, heightScale hS: CGFloat) {
        self.width *= wS
        self.height *= hS
    }

    /// scales the receiver with the given factors.
    /// - parameter dx: the factor to scale `width`.
    /// - parameter dy: the factor to scale `height`.
    public mutating func scale(_ dx: CGFloat, dy: CGFloat) {
        self.width += dx
        self.height += dy
    }
}

public extension CGSize {
    
    /// converts this `CGSize` instance to a `NSValue` instance.
    public var asValue: NSValue {
        return NSValue(cgSize: self)
    }
}

public extension CGSize {
    
    /// creates a CGSize with the given `width` and the same `height` as the receiver
    /// - parameter width: the new `width`
    public func with(width: CGFloat) -> CGSize {
        var size = self
        size.width = width
        return size
    }

    /// creates a CGSize with the given `height` and the same `width` as the receiver
    /// - parameter height: the new `height`
    public func with(height: CGFloat) -> CGSize {
        var size = self
        size.height = height
        return size
    }
}

public extension CGSize {
    
    /// creates a CGSize whose `width` is the sum of the current `width` and the 
    /// given value.
    /// - parameter width: the value to add to the current `width`.
    public func adding(width: CGFloat) -> CGSize {
        var size = self
        size.width += width
        return size
    }

    /// creates a CGSize whose `height` is the sum of the current `height` and 
    /// the given value.
    /// - parameter height: the value to add to the current `height`.
    public func adding(height: CGFloat) -> CGSize {
        var size = self
        size.height += height
        return size
    }

    /// creates a CGSize whose `width` is the difference of the current `width`
    /// and the given value.
    /// - parameter width: the value to subtract from the current `width`.
    public func subtracting(width: CGFloat) -> CGSize {
        var size = self
        size.width -= width
        return size
    }

    /// creates a CGSize whose `height` is the difference of the current 
    /// `height` and the given value.
    /// - parameter width: the value to subtract from the current `height`.
    public func subtracting(height: CGFloat) -> CGSize {
        var size = self
        size.height -= height
        return size
    }
}

public extension CGSize {
    
    /// sums two CGSize instances
    /// - parameter size: another size
    public func adding(size: CGSize) -> CGSize {
        return self
            .adding(width: size.width)
            .adding(height: size.height)
    }
    
    /// subtracts two CGSize instances
    /// - parameter size: another size
    public func subtracting(size: CGSize) -> CGSize {
        return self
            .subtracting(width: size.width)
            .subtracting(height: size.height)
    }
}

public extension CGSize {
    
    /// apply a transformation to a CGSize
    /// - parameter t: the transformation
    public mutating func apply(_ t: CGAffineTransform) {
        self = self.applying(t)
    }
}

public extension CGSize {
    
    /// creates a CGSize with has the greatest properties between the receiver 
    /// and the given value
    /// - parameter other: another size
    public func union(with other: CGSize) -> CGSize {
        return self
            .with(width: self.width.maximum(other.width))
            .with(height: self.height.maximum(other.height))
    }
    
    /// creates a CGSize with has the greatest properties between the receiver
    /// and the given value.
    /// - parameter other: another size
    /// - seeAlso: union(with:)
    public mutating func merge(with other: CGSize) {
        self = self.union(with: other)
    }
}

public extension CGSize {
    
    /// calculates the area of this instance
    public var area: CGFloat {
        return self.width.multiplied(by: self.height).absolute()
    }
}

public extension CGSize {
    
    /// the rule to use for maximum/minimum/area comparisons.
    public enum ComparisonRule {
        case width  /// do comparison based on `width`.
        case height /// do comparison based on `height`.
        case area   /// do comparison based on `area`.
    }
    
    /// returns the maximum size between the receiver and `other` using the 
    /// given rule for comparison
    /// - parameter other: another size
    /// - parameter rule: the comparison rule to use.
    public func maximum(_ other: CGSize, rule: CGSize.ComparisonRule = CGSize.ComparisonRule.area) -> CGSize {
        switch rule {
        case CGSize.ComparisonRule.width:
            return (self.width > other.width) ? self : other
        case CGSize.ComparisonRule.height:
            return (self.height > other.height) ? self : other
        case CGSize.ComparisonRule.area:
            return (self.area > other.area) ? self : other
        }
    }
    
    /// returns the minimum size between the receiver and `other` using the
    /// given rule for comparison
    /// - parameter other: another size
    /// - parameter rule: the comparison rule to use.
    public func minimum(_ other: CGSize, rule: CGSize.ComparisonRule = CGSize.ComparisonRule.area) -> CGSize {
        switch rule {
        case CGSize.ComparisonRule.width:
            return (self.width < other.width) ? self : other
        case CGSize.ComparisonRule.height:
            return (self.height < other.height) ? self : other
        case CGSize.ComparisonRule.area:
            return (self.area < other.area) ? self : other
        }
    }
}

public extension CGSize {
    
    /// returns a Boolean indicating wether the receiver is greater than the 
    /// given value based on the given comparison rule.
    /// - parameter other: another size
    /// - parameter rule: the comparison rule to use.
    public func isGreater(than other: CGSize, rule: CGSize.ComparisonRule = CGSize.ComparisonRule.area) -> Bool {
        switch rule {
        case CGSize.ComparisonRule.width:
            return (self.width > other.width)
        case CGSize.ComparisonRule.height:
            return (self.height > other.height)
        case CGSize.ComparisonRule.area:
            return (self.area > other.area)
        }
    }
    
    /// returns a Boolean indicating wether the receiver is greater than or 
    /// equal to the given value based on the given comparison rule.
    /// - parameter other: another size
    /// - parameter rule: the comparison rule to use.
    public func isGreater(thanOrEqualTo other: CGSize, rule: CGSize.ComparisonRule = CGSize.ComparisonRule.area) -> Bool {
        switch rule {
        case CGSize.ComparisonRule.width:
            return (self.width >= other.width)
        case CGSize.ComparisonRule.height:
            return (self.height >= other.height)
        case CGSize.ComparisonRule.area:
            return (self.area >= other.area)
        }
    }
    
    /// returns a Boolean indicating wether the receiver is less than the
    /// given value based on the given comparison rule.
    /// - parameter other: another size
    /// - parameter rule: the comparison rule to use.
    public func isLess(than other: CGSize, rule: CGSize.ComparisonRule = CGSize.ComparisonRule.area) -> Bool {
        switch rule {
        case CGSize.ComparisonRule.width:
            return (self.width < other.width)
        case CGSize.ComparisonRule.height:
            return (self.height < other.height)
        case CGSize.ComparisonRule.area:
            return (self.area < other.area)
        }
    }
    
    /// returns a Boolean indicating wether the receiver is less than or equal
    /// to the given value based on the given comparison rule.
    /// - parameter other: another size
    /// - parameter rule: the comparison rule to use.
    public func isLess(thanOrEqualTo other: CGSize, rule: CGSize.ComparisonRule = CGSize.ComparisonRule.area) -> Bool {
        switch rule {
        case CGSize.ComparisonRule.width:
            return (self.width <= other.width)
        case CGSize.ComparisonRule.height:
            return (self.height <= other.height)
        case CGSize.ComparisonRule.area:
            return (self.area <= other.area)
        }
    }
}

