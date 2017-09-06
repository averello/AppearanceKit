//
//  CATTransform3D.swift
//  Ents
//
//  Created by Georges Boumis on 26/08/16.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension CATransform3D {
    
    /// create a NSValue from this instance of `CATransform3D`.
    public var value: NSValue {
        return NSValue(caTransform3D: self)
    }
    
    /// create a CGAffineTransform from this instance of `CATransform3D`.
    public var affine: CGAffineTransform {
        return CATransform3DGetAffineTransform(self)
    }
    
    /// concatenate this instance of `CATransform3D` with another instance of `CATransform3D`.
    public mutating func concatenate(_ t: CATransform3D) {
        self = self.concatenating(t)
    }
    
    /// concatenates this instance of `CATransform3D` with another instance of `CATransform3D`
    /// and returns a new `CATransform3D` instance.
    public func concatenating(_ t: CATransform3D) -> CATransform3D {
        return CATransform3DConcat(self, t)
    }
}
