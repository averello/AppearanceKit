//
//  ScaledImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 01/09/2016.
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

import Foundation

#if canImport(UIKit) && canImport(ContentKit)
import UIKit
import ContentKit

/// An image that can be scaled either using a scale factor or per axis
/// scale factors.
final public class ScaledImage: ContentKit.Image {
    final private let decorated: ContentKit.Image

    /// The horizontal axis scale factor.
    final public let horizontal: Float
    /// The vertical axis scale factor.
    final public let vertical: Float
    
    private lazy var drawnImage: ContentKit.Image = {
        return autoreleasepool {
            
            let originalSize = self.decorated.size
            let size = ContentKit.Size(width: originalSize.width * self.horizontal,
                            height: originalSize.height * self.vertical)
            let configuration = CGContext.Configuration(interpolationQuality: CGInterpolationQuality.high)
            
            let options = DrawnImage.Options(size: size, configuration: configuration) { (image: ContentKit.Image, bounds: CGRect, context: CGContext) in
                guard let cgImage = image.image.cgImage else { return }
                context.draw(cgImage, in: bounds)
            }
            return RotatedImage(DrawnImage(self.decorated,
                                           options: options),
                                rotation: RotatedImage.Rotation.arbitrary(180))
        }
    }()
    
    public var image: UIImage {
        return self.drawnImage.image
    }

    /// Creates a `ScaledImage` based on the provided image scaled by the given
    /// scale factor.
    /// - parameter decorated: The image to scale.
    /// - parameter scale: The scale factor to use on both axis.
    public convenience init(_ decorated: ContentKit.Image, scale: Float) {
        self.init(decorated,
                  horizontal: scale,
                  vertical: scale)
    }

    /// Creates a `ScaledImage` based on the provided image scaled by the given
    /// scale factors.
    /// - parameter decorated: The image to scale.
    /// - parameter horizontal: The scale factor to use on the horizontal axis.
    /// - parameter vertical: The scale factor to use on the vertical axis.
    public init(_ decorated: ContentKit.Image, horizontal: Float, vertical: Float) {
        self.decorated = decorated
        self.horizontal = horizontal
        self.vertical = vertical
    }

    /// Creates a `ScaledImage` based on the provided image scaled to the given
    /// size.
    /// - parameter decorated: The image to scale.
    /// - parameter size: The final size the scaled image should have.
    public convenience init(_ decorated: ContentKit.Image, toSize size: Size) {
        let originalSize = decorated.size
        let horizontal = size.width / originalSize.width
        let vertical = size.height / originalSize.height
        self.init(decorated,
                  horizontal: horizontal,
                  vertical: vertical)
    }
}
#endif
