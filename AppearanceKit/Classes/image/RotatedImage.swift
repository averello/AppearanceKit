//
//  RotatedImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 15/05/2018.
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
//

import Foundation

#if canImport(ContentKit) && canImport(QuartzCore) && canImport(UIKit)
import ContentKit
import QuartzCore
import UIKit

/// An image that is rotated either left/right (90°) or at arbitratry degrees.
public class RotatedImage: ContentKit.Image {
    
    /// The possible rotations for the image.
    public enum Rotation {
        /// Right rotation of 90°.
        case right
        /// Left rotation of 90°.
        case left
        /// Arbitratry rotation of the given degrees.
        case arbitrary(AppearanceKit.Degrees)
    }
    
    final private let decorated: ContentKit.Image
    final public let rotation: RotatedImage.Rotation
    
    /// Creates a `RotatedImage` based on the provided image rotated by the
    /// given rotation.
    /// - parameter image: The image to rotate.
    /// - parameter rotation: The rotation to apply.
    public init(_ image: ContentKit.Image,
                rotation: RotatedImage.Rotation) {
        self.decorated = image
        self.rotation = rotation
    }
    
    final private func simpleRotation(ofImage img: ContentKit.Image, rotation: RotatedImage.Rotation) -> ContentKit.Image {
        let image = img.image
        guard let cgImage = image.cgImage else { return image }
        let scale = image.scale
        let orientation = rotation.imageOrientation(fromCurrentImageOrientation: image.imageOrientation)
        let rotated =  UIImage(cgImage: cgImage,
                               scale: scale,
                               orientation: orientation)
        return rotated
    }
    
    final private func compositeRotation(ofImage image: ContentKit.Image, times: UInt, direction: Direction) -> ContentKit.Image {
        guard times == 0 else {
            return self.compositeRotation(ofImage: RotatedImage(image, rotation: direction.rotation),
                                          times: times-1,
                                          direction: direction)
        }
        return image
    }
    
    final private func arbitraryRotation(ofImage image: ContentKit.Image, by degrees: AppearanceKit.Degrees) -> ContentKit.Image {
        
        let originalCGSize = image.size.asCGSize
        let size = { () -> ContentKit.Size in
            let transform = CGAffineTransform(rotationAngle: CGFloat(degrees.asRadians))
            let rect = CGRect(origin: CGPoint.zero, size: originalCGSize).applying(transform)
            return ContentKit.Size(width: Float(rect.size.width),
                                   height: Float(rect.size.height))
        }()
        
        let configuration = CGContext.Configuration(interpolationQuality: CGInterpolationQuality.high)
        let radians = degrees.asRadians
        
        
        let options = DrawnImage.Options(size: size, configuration: configuration) { (image: ContentKit.Image, bounds: CGRect, context: CGContext) in
            guard let cgImage = image.image.cgImage else { return }
            
            
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let imageRect = CGRect(origin: center,
                                   size: originalCGSize)
            
            context.translateBy(x: imageRect.origin.x,
                                y: imageRect.origin.y)
            context.rotate(by: CGFloat(radians))
            context.translateBy(x: imageRect.width * -0.5,
                                y: imageRect.height * -0.5)
            
            let drawRect = CGRect(origin: CGPoint.zero,
                                  size: imageRect.size)
            context.draw(cgImage, in: drawRect)
        }
        return DrawnImage(self.decorated, options: options)
    }
    
    fileprivate enum Direction {
        case clockwise
        case counterClockwise
    }
    
    final private lazy var drawnImage: ContentKit.Image = {
        return autoreleasepool {
            
            guard case let RotatedImage.Rotation.arbitrary(degrees) = self.rotation else {
                return self.simpleRotation(ofImage: self.decorated,
                                           rotation: self.rotation)
            }
            
            let rightAngle = AppearanceKit.Degrees(90)
            guard degrees.remainder(dividingBy: rightAngle) != 0 else {
                let times = UInt(abs(degrees / rightAngle))
                return self.compositeRotation(ofImage: self.decorated,
                                              times: times,
                                              direction: RotatedImage.Direction(degrees: degrees))
            }
            
            return self.arbitraryRotation(ofImage: self.decorated,
                                          by: degrees)
        }
    }()
    
    public var image: UIImage {
        return self.drawnImage.image
    }
}

fileprivate extension RotatedImage.Rotation {
    
    func imageOrientation(fromCurrentImageOrientation currentOrientation: UIImage.Orientation) -> UIImage.Orientation {
        switch (self, currentOrientation) {
        // left
        case (RotatedImage.Rotation.left, UIImage.Orientation.up):
            return UIImage.Orientation.left
            
        case (RotatedImage.Rotation.left, UIImage.Orientation.down):
            return UIImage.Orientation.right
            
        case (RotatedImage.Rotation.left, UIImage.Orientation.left):
            return UIImage.Orientation.down
            
        case (RotatedImage.Rotation.left, UIImage.Orientation.right):
            return UIImage.Orientation.up
            
        // right
        case (RotatedImage.Rotation.right, UIImage.Orientation.up):
            return UIImage.Orientation.right
            
        case (RotatedImage.Rotation.right, UIImage.Orientation.down):
            return UIImage.Orientation.left
            
        case (RotatedImage.Rotation.right, UIImage.Orientation.left):
            return UIImage.Orientation.up
            
        case (RotatedImage.Rotation.right, UIImage.Orientation.right):
            return UIImage.Orientation.down
            
            
        // left mirrored
        case (RotatedImage.Rotation.left, UIImage.Orientation.upMirrored):
            return UIImage.Orientation.leftMirrored
            
        case (RotatedImage.Rotation.left, UIImage.Orientation.downMirrored):
            return UIImage.Orientation.rightMirrored
            
        case (RotatedImage.Rotation.left, UIImage.Orientation.leftMirrored):
            return UIImage.Orientation.downMirrored
            
        case (RotatedImage.Rotation.left, UIImage.Orientation.rightMirrored):
            return UIImage.Orientation.upMirrored
            
        // right mirrored
        case (RotatedImage.Rotation.right, UIImage.Orientation.upMirrored):
            return UIImage.Orientation.rightMirrored
            
        case (RotatedImage.Rotation.right, UIImage.Orientation.downMirrored):
            return UIImage.Orientation.leftMirrored
            
        case (RotatedImage.Rotation.right, UIImage.Orientation.leftMirrored):
            return UIImage.Orientation.upMirrored
            
        case (RotatedImage.Rotation.right, UIImage.Orientation.rightMirrored):
            return UIImage.Orientation.downMirrored
            
        default:
            return UIImage.Orientation.up
        }
    }
}

fileprivate extension RotatedImage.Direction {
    
    init(degrees: AppearanceKit.Degrees) {
        self = (degrees < 0)
            ? RotatedImage.Direction.counterClockwise
            : RotatedImage.Direction.clockwise
    }
    
    var rotation: RotatedImage.Rotation {
        switch self {
        case RotatedImage.Direction.clockwise:
            return RotatedImage.Rotation.right
            
        case RotatedImage.Direction.counterClockwise:
            return RotatedImage.Rotation.left
        }
    }
}

/// A multiple state image that is rotated either left/right (90°) or at
/// arbitratry degrees.
final public class MultipleStateRotatedImage: RotatedImage, MultipleStateImage {
    
    final private let decorated: AppearanceKit.MultipleStateImage
    
    /// Creates a `MultipleStateRotatedImage` based on the provided image
    /// rotated by the given rotation.
    /// - parameter image: The image to rotate.
    /// - parameter rotation: The rotation to apply.
    public init(_ decorated: AppearanceKit.MultipleStateImage,
                rotation: RotatedImage.Rotation) {
        self.decorated = decorated
        super.init(decorated, rotation: rotation)
    }
    
    final private func rotatedImage(_ image: Image?) -> RotatedImage? {
        guard let img = image else { return nil }
        return RotatedImage(img, rotation: self.rotation)
    }
    
    public var normal: ContentKit.Image? { return self.rotatedImage(self.decorated.normal) }
    
    public var highlighted: ContentKit.Image? { return self.rotatedImage(self.decorated.highlighted) }
    
    public var selected: ContentKit.Image? { return self.rotatedImage(self.decorated.selected) }
    
    public var disabled: ContentKit.Image? { return self.rotatedImage(self.decorated.disabled) }
    
    public var original: UIImage? {
        return self.decorated.original
    }
}
#endif
