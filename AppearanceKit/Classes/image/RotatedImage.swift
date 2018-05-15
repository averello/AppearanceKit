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

    final private lazy var drawnImage: ContentKit.Image = {
        return autoreleasepool {

            let rotation = self.rotation
            let degrees = rotation.degrees
            let originalCGSize = self.decorated.size.asCGSize
            let size = { () -> ContentKit.Size in
                let transform = CGAffineTransform(rotationAngle: CGFloat(degrees.asRadians))
                var rect = CGRect(origin: CGPoint.zero, size: originalCGSize).applying(transform)
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
            return DrawnImage(decorated: self.decorated, options: options)
        }
    }()

    public var image: UIImage {
        return self.drawnImage.image
    }
}

fileprivate extension RotatedImage.Rotation {

    fileprivate var degrees: AppearanceKit.Degrees {
        switch self {
        case RotatedImage.Rotation.left:
            return Degrees(-90)

        case RotatedImage.Rotation.right:
            return Degrees(90)

        case let RotatedImage.Rotation.arbitrary(degrees):
            return degrees
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
