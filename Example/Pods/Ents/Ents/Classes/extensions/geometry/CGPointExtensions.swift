//
//  CGPointRounding.swift
//  UIViewPosition
//
//  Created by Georges Boumis on 12/04/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import CoreGraphics

/// Compose two `CGFloat` to form a point operator
infix operator ^: AdditionPrecedence

public func ^ (lhs: CGFloat, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs, y: rhs)
}

public func ^ (lhs: Int, rhs: Int) -> CGPoint {
    return CGPoint(x: lhs, y: rhs)
}

public func ^ (lhs: Double, rhs: Double) -> CGPoint {
    return CGPoint(x: CGFloat(lhs), y: CGFloat(rhs))
}

public func ^ (lhs: Float, rhs: Float) -> CGPoint {
    return CGPoint(x: CGFloat(lhs), y: CGFloat(rhs))
}

///// Compose two `Integers` to form a point operator
//public func ^ <I>(lhs: I, rhs: I) -> CGPoint where I:Integer {
//    return CGPoint(x: CGFloat(lhs.toIntMax()), y: CGFloat(rhs.toIntMax()))
//}
//
///// Compose two `BinaryFloatingPoint` to form a point operator
//public func ^ <F>(lhs: F, rhs: F) -> CGPoint
//    where F: BinaryFloatingPoint,
//    F.RawExponent == CGFloat.RawExponent,
//    F.RawSignificand == CGFloat.RawSignificand {
//    let l = CGFloat(sign: lhs.sign, exponentBitPattern: lhs.exponentBitPattern, significandBitPattern: lhs.significandBitPattern)
//    let r = CGFloat(sign: rhs.sign, exponentBitPattern: rhs.exponentBitPattern, significandBitPattern: rhs.significandBitPattern)
//    return CGPoint(x: l, y: r)
//}

public extension CGPoint {

    /// returns a new point with floored `x` and `y` of the receiver
    public var floored: CGPoint {
		var point = self
		point.x = CoreGraphics.floor(self.x)
		point.y = CoreGraphics.floor(self.y)
        return point
    }


    /// floors `x` and `y`
    public mutating func floor() {
		self = self.floored
    }

    /// returns a new point with ceiled `x` and `y` of the receiver
    public var ceiled : CGPoint {
		var point = self
		point.x = CoreGraphics.ceil(self.x)
		point.y = CoreGraphics.ceil(self.y)
		return point
    }

    /// ceils `x` and `y`
    public mutating func ceil() {
		self = self.ceiled
    }
}

public extension CGPoint {
    
    /// converts this `CGPoint` instance to a `NSValue` instance.
	public var asValue: NSValue {
		return NSValue(cgPoint: self)
	}
}

public extension CGPoint {
    
    /// moves the receiver by the specified amounts on the x an y axis
    public mutating func translate(dx : CGFloat, dy : CGFloat) {
        self.translate(horizontally: dx)
        self.translate(vertically: dy)
    }

    /// creates a point translated by the specified amounts on the x an y axis
    public func translatedBy(dx : CGFloat, dy : CGFloat) -> CGPoint {
        var point = self;
        point.translate(dx: dx, dy: dy)
        return point
    }

    /// moves the receiver by the specified amounts on y axis
    public mutating func translate(vertically dy: CGFloat) {
        self.y += dy
    }

    /// moves the receiver by the specified amounts on x axis
    public mutating func translate(horizontally dx: CGFloat) {
        self.x += dx
    }

    /// creates a point translated by the specified amounts on the y axis
    public func translated(vertically dy: CGFloat)  -> CGPoint {
        var point = self
        point.translate(vertically: dy)
        return point
    }

    /// creates a point translated by the specified amounts on the x axis
    public func translated(horizontally dx: CGFloat) -> CGPoint {
        var point = self
        point.translate(horizontally: dx)
        return point
    }
}

public extension CGPoint {
    
    /// returns a Boolean indicating wether the receiver is on the left of the 
    /// passed in argument
    /// - parameter other: another point
    public func left(of other: CGPoint) -> Bool {
        return self.x.isLessThan(other.x)
    }

    /// returns a Boolean indicating wether the receiver is on the rigth of the
    /// passed in argument
    /// - parameter other: another point
    public func right(of other: CGPoint) -> Bool {
        return self.x.isGreaterThan(other.x)
    }

    /// returns a Boolean indicating wether the receiver is above the
    /// passed in argument
    /// - parameter other: another point
    public func above(of other: CGPoint) -> Bool {
        return self.y.isLessThan(other.y)
    }

    /// returns a Boolean indicating wether the receiver is below the
    /// passed in argument
    /// - parameter other: another point
    public func below(of other: CGPoint) -> Bool {
        return self.y.isGreaterThan(other.y)
    }

    /// returns a Boolean indicating wether the receiver is on the same 
    /// Longitude as the passed in argument
    /// - parameter other: another point
    public func sameVerticalAxe(with other: CGPoint) -> Bool {
        return self.x.isEqual(to: other.x)
    }

    /// returns a Boolean indicating wether the receiver is on the same
    /// latitude as the passed in argument
    /// - parameter other: another point
    public func sameHorizontalAxe(with other: CGPoint) -> Bool {
        return self.y.isEqual(to: other.y)
    }

    /// a 8-point direction used for comparing positions of CGPoint instances.
    /// - note: it's is assumed that the origin of the coordinate system is at 
    /// the upper left.
    public enum Direction {
        case north /// the point is above
        case west  /// the point is left
        case east  /// the point is right
        case south /// the point is below

        case northWest /// the point is above and to the left
        case northEast /// the point is above and to the right
        case southWest /// the point is below and to the left
        case southEast /// the point is below and to the right

        case none /// the points are on the same spot
    }

    /// returns an approximate direcation of the receiver according to the 
    /// argument passed in
    /// - parameter other: another point
    public func direction(comparedTo other: CGPoint) -> CGPoint.Direction {
        if self == other { return CGPoint.Direction.none }

        if self.left(of: other).and(self.above(of: other)) {
            return CGPoint.Direction.northWest
        }

        if self.right(of: other).and(self.above(of: other)) {
            return CGPoint.Direction.northEast
        }

        if self.left(of: other).and(self.below(of: other)) {
            return CGPoint.Direction.southWest
        }

        if self.right(of: other).and(self.below(of: other)) {
            return CGPoint.Direction.southEast
        }



        if self.sameVerticalAxe(with: other).and(self.above(of: other)) {
            return CGPoint.Direction.north
        }

        if self.sameVerticalAxe(with: other).and(self.below(of: other)) {
            return CGPoint.Direction.south
        }

        if self.sameHorizontalAxe(with: other).and(self.left(of: other)) {
            return CGPoint.Direction.west
        }

        if self.sameHorizontalAxe(with: other).and(self.right(of: other)) {
            return CGPoint.Direction.east
        }
        
        return CGPoint.Direction.none
    }
}

public extension CGPoint {
    
    /// creates a CGPoint with the given `x` and the same `y` as the receiver
    /// - parameter x: the new `x`.
    public func with(x: CGFloat) -> CGPoint {
        var point = self
        point.x = x
        return point
    }

    /// creates a CGPoint with the given `y` and the same `x` as the receiver
    /// - parameter y: the new `y`.
    public func with(y: CGFloat) -> CGPoint {
        var point = self
        point.y = y
        return point
    }
}

public extension CGPoint {
    
    /// apply a transformation to a CGPoint
    /// - parameter t: a transformation
    public mutating func apply(_ t: CGAffineTransform) {
        self = self.applying(t)
    }
}
