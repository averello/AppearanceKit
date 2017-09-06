//
//  CGRectRounding.swift
//  UIViewPosition
//
//  Created by Georges Boumis on 12/04/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import CoreGraphics

infix operator ◊ : AdditionPrecedence

/// creates a CGRect given a point and a size
public func ◊ (lhs: CGPoint, rhs: CGSize) -> CGRect {
    return CGRect(origin: lhs, size: rhs)
}

public extension CGRect {
    
    /// creates a CGRect with the specified center and size components
    public init(center: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(center: center, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified center and size
    public init(center: CGPoint, size : CGSize) {
        let x = center.x - (size.width * 0.5)
        let y = center.y - (size.height * 0.5)
        let origin = CGPoint(x: x, y: y)
        self.init(origin: origin, size: size)
    }

    //
    // Creating CGRect with unusual points
    //

    /// creates a CGRect with the specified rightCenter point and size components
    public init(rightCenter: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(rightCenter: rightCenter, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified rightCenter point and size
    public init(rightCenter: CGPoint, size: CGSize) {
        let x = rightCenter.x - size.width
        let y = rightCenter.y - (size.height * 0.5)
        let origin = CGPoint(x: x, y: y)
        self.init(origin: origin, size: size)
    }

    /// creates a CGRect with the specified leftCenter point and size components
    public init(leftCenter: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(leftCenter: leftCenter, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified leftCenter point and size
    public init(leftCenter : CGPoint, size : CGSize) {
        let x = leftCenter.x
        let y = leftCenter.y - (size.height * 0.5)
        let origin = CGPoint(x: x, y: y);
        self.init(origin: origin, size: size)
    }

    /// creates a CGRect with the specified topCenter point and size components
    public init(topCenter: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(topCenter: topCenter, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified topCenter point and size
    public init(topCenter: CGPoint, size: CGSize) {
        let x = topCenter.x - (size.width * 0.5)
        let y = topCenter.y
        let origin = CGPoint(x: x, y: y)
        self.init(origin: origin, size: size)
    }

    /// creates a CGRect with the specified bottomCenter point and size components
    public init(bottomCenter: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(bottomCenter: bottomCenter, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified bottomCenter point and size
    public init(bottomCenter : CGPoint, size : CGSize) {
        let x = bottomCenter.x - (size.width * 0.5)
        let y = bottomCenter.y - size.height
        let origin = CGPoint(x: x, y: y)
        self.init(origin: origin, size: size)
    }

    //
    // using corners
    
    /// creates a CGRect with the specified topRight point and size components
    public init(topRight: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(topRight: topRight, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified topRight point and size
    public init(topRight: CGPoint, size: CGSize) {
        let x = topRight.x - size.width
        let y = topRight.y
        let origin = CGPoint(x: x, y: y)
        self.init(origin: origin, size: size)
    }
    
    /// creates a CGRect with the specified topLeft point and size components
    public init(topLeft: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(topLeft: topLeft, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified topLeft point and size
    public init(topLeft: CGPoint, size: CGSize) {
        self.init(origin: topLeft, size: size)
    }

    /// creates a CGRect with the specified bottomLeft point and size components
    public init(bottomLeft: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(bottomLeft: bottomLeft, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified bottomLeft point and size
    public init(bottomLeft: CGPoint, size: CGSize) {
        let x = bottomLeft.x
        let y = bottomLeft.y - size.height
        let origin = CGPoint(x: x, y: y)
        self.init(origin: origin, size: size)
    }

    /// creates a CGRect with the specified bottomRight point and size components
    public init(bottomRight: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(bottomRight: bottomRight, size: CGSize(width: width, height: height))
    }

    /// creates a CGRect with the specified bottomRight point and size
    public init(bottomRight: CGPoint, size: CGSize) {
        let x = bottomRight.x - size.width
        let y = bottomRight.y - size.height
        let origin = CGPoint(x: x, y: y)
        self.init(origin: origin, size: size)
    }

    //
    // "cutting corners"
//    public init(origin: CGPoint = CGPoint.zero, squareRectWithEdge edge: CGFloat) {
//        self.init(origin: origin, size: CGSize(width: edge, height: edge))
//    }

    /// creates a CGRect with the specified size
    public init(size: CGSize) {
        self.init(origin: CGPoint.zero, size: size)
    }

    /// creates a CGRect with the specified size components
    public init(width: CGFloat, height: CGFloat) {
        self.init(size: CGSize(width: width, height: height))
    }
}

extension CGRect {
    /// returns a new CGRect with floored `origin` and `size`
    public var floored : CGRect {
		var rect = self
		rect.origin = self.origin.floored
		rect.size   = self.size.floored
        return rect
    }


    /// floors `origin` and `size`
    public mutating func floor() {
        self = self.floored
    }

    /// returns a new CGRect with ceiled `origin` and `size`
    public var ceiled : CGRect {
		var rect = self
		rect.origin = self.origin.ceiled
		rect.size   = self.size.ceiled
		return rect
    }

    /// ceils `origin` and `size`
    public mutating func ceil() {
		self = self.ceiled
    }
}

extension CGRect {
    
    /// the center x
    public var centerX : CGFloat {
        get {
            return self.midX
        }
        set {
            self.center = CGPoint(x: newValue, y: self.centerY);
        }
    }

    /// the center y
    public var centerY : CGFloat {
        get {
            return self.midY
        }
        set {
            self.center = CGPoint(x: self.centerX, y: newValue);
        }
    }

    /// the center
    public var center : CGPoint {
        get {
            return CGPoint(x: self.centerX, y: self.centerY)
        }
        set {
            let xDiff = self.centerX - newValue.x
            let yDiff = self.centerY - newValue.y
            self.origin.x += xDiff
            self.origin.y += yDiff
        }
    }

    /// the top
    public var top : CGFloat {
        get {
            return self.minY
        }
        set {
            self.origin.y = newValue
        }
    }

    /// the bottom
    public var bottom : CGFloat {
        get {
            return self.maxY
        }
        set {
            self.origin.y = newValue - self.size.height
        }
    }

    /// the left
    public var left : CGFloat {
        get {
            return self.minX
        }
        set {
            self.origin.x = newValue
        }
    }

    /// the rigth
    public var right : CGFloat {
        get {
            return self.maxX
        }
        set {
            self.origin.x = newValue - self.size.width
        }
    }


    /* Getting CGPoint from CGRect */
    /// the top left point
    public var topLeft : CGPoint {
        get {
            return self.origin
        }
        set {
            self.origin = newValue
        }
    }

    /// the top right point
    public var topRight : CGPoint {
        get {
            return CGPoint(x: self.right, y: self.top)
        }
        set {
            self.right = newValue.x
            self.top   = newValue.y
        }
    }
    
    /// the bottom left point
    public var bottomLeft : CGPoint {
        get {
            return CGPoint(x: self.left, y: self.bottom)
        }
        set {
            self.left   = newValue.x
            self.bottom = newValue.y
        }
    }

    /// the bottom right point
    public var bottomRight : CGPoint {
        get {
            return CGPoint(x: self.right, y: self.bottom)
        }
        set {
            self.right  = newValue.x
            self.bottom = newValue.y
        }
    }

    /// the top center point
    public var topCenter : CGPoint {
        get {
            return CGPoint(x: self.centerX, y: self.top)
        }
        set {
            self.centerX = newValue.x
            self.top     = newValue.y
        }
    }

    /// the bottom center point
    public var bottomCenter : CGPoint {
        get {
            return CGPoint(x: self.centerX, y: self.bottom)
        }
        set {
            self.centerX = newValue.x
            self.bottom  = newValue.y
        }
    }

    /// the top left center point
    public var leftCenter : CGPoint {
        get {
            return CGPoint(x: self.left, y: self.centerY)
        }
        set {
            self.left    = newValue.x
            self.centerY = newValue.y
        }
    }

    /// the top right center point
    public var rightCenter : CGPoint {
        get {
            return CGPoint(x: self.right, y: self.centerY)
        }
        set {
            self.right   = newValue.x
            self.centerY = newValue.y
        }
    }
}

extension CGRect {
    /// moves the receiver by the specified amounts on the x an y axis
    public mutating func translate(dx: CGFloat, dy: CGFloat){
        self.origin.translate(dx : dx, dy: dy)
    }

    /// creates a point translated by the specified amounts on the x an y axis
    public func translatedBy(dx : CGFloat, dy : CGFloat) -> CGRect {
        var rect = self;
        rect.translate(dx: dx, dy: dy)
		return rect
    }
    
    /// moves the receiver by the specified amounts on y axis
    public mutating func translate(vertically dy: CGFloat) {
        self.translate(dx: 0.0, dy: dy)
    }
    
    /// moves the receiver by the specified amounts on x axis
    public mutating func translate(horizontally dx: CGFloat) {
        self.translate(dx: dx, dy: 0.0)
    }

    /// creates a point translated by the specified amounts on the y axis
    public func translated(vertically dy: CGFloat) -> CGRect {
        return self.translatedBy(dx: 0.0, dy: dy)
    }

    /// creates a point translated by the specified amounts on the x axis
    public func translated(horizontally dx: CGFloat) -> CGRect {
        return self.translatedBy(dx: dx, dy: 0.0)
    }
}

extension CGRect {
    
    /// returns a Boolean indicating wether the receiver is on the left of the
    /// passed in argument
    public func left(of other: CGRect) -> Bool {
        return self.origin.left(of: other.origin)
    }

    /// returns a Boolean indicating wether the receiver is on the right of the
    /// passed in argument
    public func right(of other: CGRect) -> Bool {
        return self.origin.right(of: other.origin)
    }

    /// returns a Boolean indicating wether the receiver is on the above of the
    /// passed in argument
    public func above(of other: CGRect) -> Bool {
        return self.origin.above(of: other.origin)
    }

    /// returns a Boolean indicating wether the receiver is on the below of the
    /// passed in argument
    public func below(of other: CGRect) -> Bool {
        return self.origin.below(of: other.origin)
    }

    /// returns a Boolean indicating wether the receiver is on the same
    /// Longitude as the passed in argument
    public func sameVerticalAxe(with other: CGRect) -> Bool {
        return self.origin.sameVerticalAxe(with: other.origin)
    }

    /// returns a Boolean indicating wether the receiver is on the same
    /// latitude as the passed in argument
    public func sameHorizontalAxe(with other: CGRect) -> Bool {
        return self.origin.sameHorizontalAxe(with: other.origin)
    }
}

public extension CGRect {
    
    /// converts this `CGRect` instance to a `NSValue` instance.
    public var asValue: NSValue {
        return NSValue(cgRect: self)
    }
}

public extension CGRect {
    
    /// creates a CGRect which is scaled by the given factor.
    public func scaled(_ scale: CGFloat) -> CGRect {
        var rect = self
        rect.scale(scale)
        return rect
    }

    /// scales the receiver with the given factor.
    public mutating func scale(_ scale: CGFloat) {
        self.size.scale(scale)
    }

    /// Makes the receiver smaller by the
    /// given factor.
    public mutating func inset(_ scale: CGFloat) {
        assert(scale > 0, "use .outset() instead")
        let dx = self.size.width * scale
        let dy = self.size.height * scale
        self = self.insetBy(dx: dx, dy: dy)
    }

    /// Makes the receiver larger by the
    /// given factor.
    public mutating func outset(_ scale: CGFloat) {
        assert(scale < 0, "use .inset() instead")
        let dx = self.size.width * scale
        let dy = self.size.height * scale

        self = self.insetBy(dx: -dx, dy: -dy)
    }

    /// Returns a rectangle that is smaller than the source rectangle by the
    /// given factor, with the same center point.
    public func inseted(_ scale: CGFloat) -> CGRect {
        var rect = self
        rect.inset(scale)
        return rect
    }

    /// Returns a rectangle that is larger than the source rectangle by the
    /// given factor, with the same center point.
    public func outseted(_ scale : CGFloat) -> CGRect {
        var rect = self
        rect.outset(scale)
        return rect
    }
}

public extension CGRect {
    
    /// creates a CGRect with the given `size`. the rest of properties are the same as the receiver
    public func with(size: CGSize) -> CGRect {
        var frame = self
        frame.size = size
        return frame
    }

    /// creates a CGRect with the given `origin`. the rest of properties are the same as the receiver
    public func with(origin: CGPoint) -> CGRect {
        var frame = self
        frame.origin = origin
        return frame
    }

    /// creates a CGRect with the given `width`. the rest of properties are the same as the receiver
    public func with(width: CGFloat) -> CGRect {
        var frame = self
        frame.size.width = width
        return frame
    }

    /// creates a CGRect with the given `height`. the rest of properties are the same as the receiver
    public func with(height: CGFloat) -> CGRect {
        var frame = self
        frame.size.height = height
        return frame
    }

    /// creates a CGRect with the given `x`. the rest of properties are the same as the receiver
    public func with(x: CGFloat) -> CGRect {
        var frame = self
        frame.origin.x = x
        return frame
    }

    /// creates a CGRect with the given `y`. the rest of properties are the same as the receiver
    public func with(y: CGFloat) -> CGRect {
        var frame = self
        frame.origin.y = y
        return frame
    }
}

public extension CGRect {

    /// apply a transformation to a CGPoint
    public mutating func apply(_ t: CGAffineTransform) {
        self = self.applying(t)
    }
}
