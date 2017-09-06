//
//  UIViewExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 29/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import UIKit

public extension UIView {
    
    /// the view layer's anchor point.
    final public var layerAnchorPoint: CGPoint {
        get {
            return self.layer.anchorPoint
        }
        set {
            self.layer.setAnchorPointWithoutMoving(newValue)
        }
    }
}

public extension UIView {
    
    /// scales the receiver's frame with the provided scale.
    /// - parameter scale: a factor.
    final public func scale(_ scale: CGFloat) {
        self.frameSize.scale(scale)
    }
}

public extension UIView {
    
    /// sets the center of the view using a specific anchor point.
    /// - parameter point: the anchor point to use.
    /// - parameter block: a closure that returns the new center of the receiver.
    final public func center(withAnchorPoint point: CGPoint, _ block: (UIView) -> CGPoint) {
        let anchorPoint = self.layer.anchorPoint
        self.layerAnchorPoint = point
        self.center = block(self)
        self.layerAnchorPoint = anchorPoint
    }
    
    /// Evaluates the given closure with no transform applied to the receiver,
    /// passing the receiver as its argument.
    /// - parameter block: a closure to evaluate without transformations.
    final public func withoutTransform(_ block: (UIView) -> Void) {
        let transform = self.transform
        self.transform = CGAffineTransform.identity
        block(self)
        self.transform = transform
    }
}
