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
import ContentKit
import QuartzCore

public class RotatedImage: ContentKit.Image {

    public enum Rotation {
        case right
        case left
        case arbitrary(AppearanceKit.Degrees)
    }
    
    final private let decorated: ContentKit.Image
    final public let rotation: RotatedImage.Rotation

    public init(_ decorated: ContentKit.Image,
                rotation: RotatedImage.Rotation) {
        self.decorated = decorated
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

    fileprivate func imageOrientation(fromCurrentImageOrientation currentOrientation: UIImageOrientation) -> UIImageOrientation {
        switch (self, currentOrientation) {
            // left
        case (RotatedImage.Rotation.left, UIImageOrientation.up):
            return UIImageOrientation.left

        case (RotatedImage.Rotation.left, UIImageOrientation.down):
            return UIImageOrientation.right

        case (RotatedImage.Rotation.left, UIImageOrientation.left):
            return UIImageOrientation.down

        case (RotatedImage.Rotation.left, UIImageOrientation.right):
            return UIImageOrientation.up

            // right
        case (RotatedImage.Rotation.right, UIImageOrientation.up):
            return UIImageOrientation.right

        case (RotatedImage.Rotation.right, UIImageOrientation.down):
            return UIImageOrientation.left

        case (RotatedImage.Rotation.right, UIImageOrientation.left):
            return UIImageOrientation.up

        case (RotatedImage.Rotation.right, UIImageOrientation.right):
            return UIImageOrientation.down


            // left mirrored
        case (RotatedImage.Rotation.left, UIImageOrientation.upMirrored):
            return UIImageOrientation.leftMirrored

        case (RotatedImage.Rotation.left, UIImageOrientation.downMirrored):
            return UIImageOrientation.rightMirrored

        case (RotatedImage.Rotation.left, UIImageOrientation.leftMirrored):
            return UIImageOrientation.downMirrored

        case (RotatedImage.Rotation.left, UIImageOrientation.rightMirrored):
            return UIImageOrientation.upMirrored

            // right mirrored
        case (RotatedImage.Rotation.right, UIImageOrientation.upMirrored):
            return UIImageOrientation.rightMirrored

        case (RotatedImage.Rotation.right, UIImageOrientation.downMirrored):
            return UIImageOrientation.leftMirrored

        case (RotatedImage.Rotation.right, UIImageOrientation.leftMirrored):
            return UIImageOrientation.upMirrored

        case (RotatedImage.Rotation.right, UIImageOrientation.rightMirrored):
            return UIImageOrientation.downMirrored

            


        default:
            return UIImageOrientation.up
        }
    }
}

extension RotatedImage.Direction {

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

final public class MultipleStateRotatedImage: RotatedImage, MultipleStateImage {

    final private let decorated: AppearanceKit.MultipleStateImage

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
