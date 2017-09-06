//
//  CALayerExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 29/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import QuartzCore

public extension CALayer {
    
    /// Computes a new point of a given postion using a given ancorPoint.
    final public func point(ofPosition position: CGPoint,
                      withAnchorPoint anchorPoint: CGPoint) -> CGPoint {
        var newPoint = CGPoint(x: self.bounds.size.width * anchorPoint.x,
                               y: self.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: self.bounds.size.width * self.anchorPoint.x,
                               y: self.bounds.size.height * self.anchorPoint.y)
        
        newPoint = newPoint.applying(self.affineTransform())
        oldPoint = oldPoint.applying(self.affineTransform())
        
        var position = position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        return position
    }
    
    
    /// Computes a new point that describes the `position` of the layer if the given
    /// anchorPoing was to be used.
    final public func position(ofAnchorPoint anchorPoint: CGPoint) -> CGPoint {
        return self.point(ofPosition: self.position, withAnchorPoint: anchorPoint)
    }
    
    /// changes the anchorPoing of this instance of `CALayer` without repositioning
    /// the layer.
    final public func setAnchorPointWithoutMoving(_ anchorPoint: CGPoint, implicit: Bool = false) {
        let position = self.position(ofAnchorPoint: anchorPoint)

        if implicit {
            self.position = position
            self.anchorPoint = anchorPoint
        }
        else {
            NoImplicitAnimation {
                self.position = position
                self.anchorPoint = anchorPoint
            }
        }
    }
}

#if DEBUG
    public extension CALayer {
        public func debugQuickLookObject() -> AnyObject? {
            let size = self.bounds.size
            UIGraphicsBeginImageContext(size)
            let context = UIGraphicsGetCurrentContext()
            self.render(in: context!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }
#endif
