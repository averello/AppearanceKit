//
//  ResizableImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 07/03/2017.
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

#if canImport(UIKit) && canImport(ContentKit) && (QuartzCore)
import UIKit
import ContentKit
import QuartzCore

/// An image that can be resized using either a tile or stretch technique.
public class ResizableImage: ContentKit.Image {

    /// The possible resizing modes for the image.
    public enum Mode {
        /// The image is tiled when it is resized. In other words, the interior
        /// region of the original image will be repeated to fill in the
        /// interior region of the newly resized image.
        case tile
        /// The image is stretched when it is resized. In other words, the
        /// interior region of the original image will be scaled to fill in the
        /// interior region of the newly resized imaged.
        case stretch
    }

    /// The cap insets to cap the image.
    ///
    /// Cap inset values are applied to a rectangle to shrink or expand the
    /// area represented by that rectangle.
    public struct CapInsets {
        /// The top edge inset value.
        public let top: Float
        /// The left edge inset value.
        public let left: Float
        /// The bottom edge inset value.
        public let bottom: Float
        /// The right edge inset value.
        public let right: Float

        /// Creates a cap inset.
        /// - parameter top: The top edge inset value.
        /// - parameter left: The left edge inset value.
        /// - parameter bottom: The bottom edge inset value.
        /// - parameter right: The right edge inset value.
        public init(top: Float,
                    left: Float,
                    bottom: Float,
                    right: Float) {
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }

        /// Returns the `UIKit` equivalent.
        public var asUIEdgeInsets: UIEdgeInsets {
            return UIEdgeInsets(top: CGFloat(self.top),
                                left: CGFloat(self.left),
                                bottom: CGFloat(self.bottom),
                                right: CGFloat(self.right))
        }
    }

    /// The decorated image to make resizable.
    final private let decorated: ContentKit.Image
    /// The cap insets to use.
    final fileprivate let insets: ResizableImage.CapInsets
    /// The resizing mode to use.
    final fileprivate let mode: ResizableImage.Mode

    /// Creates a `ResizableImage` based on the given image, with the given
    /// cap insets using the provided resizing mode.
    /// - parameter image: The image to make resizable.
    /// - parameter insets: The cap insets to use for resizing.
    /// - parameter resizingMode: The resizing mode to use.
    public init(_ image: ContentKit.Image,
                withCapInsets insets: ResizableImage.CapInsets,
                resizingMode: ResizableImage.Mode) {
        self.decorated = image
        self.insets = insets
        self.mode = resizingMode
    }
    
    public var image: UIImage {
        return self.decorated.image
            .resizableImage(withCapInsets: self.insets.asUIEdgeInsets,
                            resizingMode: self.mode.resizingMode)
    }
}

/// A multiple state image that can be resized using either a tile or stretch
/// technique.
final public class MultipleStateResizableImage: ResizableImage, MultipleStateImage {
    final private let decorated: MultipleStateImage

    /// Creates a `MultipleStateResizableImage` based on the given image, with
    /// the given cap insets using the provided resizing mode.
    /// - parameter image: The image to make resizable.
    /// - parameter insets: The cap insets to use for resizing.
    /// - parameter resizingMode: The resizing mode to use.
    public init(_ image: MultipleStateImage,
                withCapInsets insets: ResizableImage.CapInsets,
                resizingMode: ResizableImage.Mode) {
        self.decorated = image
        super.init(image,
                   withCapInsets: insets,
                   resizingMode: resizingMode)
    }
    
    final private func resizable(_ image: ContentKit.Image?) -> ResizableImage? {
        guard let img = image else { return nil }
        return ResizableImage(img,
                              withCapInsets: self.insets,
                              resizingMode: self.mode)
    }
    
    public var normal: ContentKit.Image? { return self.resizable(self.decorated.normal) }
    
    public var highlighted: ContentKit.Image? { return self.resizable(self.decorated.highlighted) }
    
    public var selected: ContentKit.Image? { return self.resizable(self.decorated.selected) }
    
    public var disabled: ContentKit.Image? { return self.resizable(self.decorated.disabled) }
    
    public var original: UIImage? {
        return self.decorated.original?
            .resizableImage(withCapInsets: self.insets.asUIEdgeInsets,
                            resizingMode: self.mode.resizingMode) }
}

fileprivate extension ResizableImage.Mode {
    
    fileprivate var resizingMode: UIImage.ResizingMode {
        switch self {
        case ResizableImage.Mode.tile:
            return UIImage.ResizingMode.tile
        case ResizableImage.Mode.stretch:
            return UIImage.ResizingMode.stretch
        }
    }
}
#endif
