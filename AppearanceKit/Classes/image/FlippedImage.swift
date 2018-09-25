//
//  FlippedImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 30/05/2018.
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
import ContentKit

final public class FlippedImage: ContentKit.Image {
    final private let decorated: ContentKit.Image

    public var image: UIImage {
        let image = self.decorated.image
        guard let cgImage = image.cgImage else { return image }
        let scale = image.scale
        let orientation = self.flip.imageOrientation(fromCurrentOrientation: image.imageOrientation)
        let flipped =  UIImage(cgImage: cgImage,
                               scale: scale,
                               orientation: orientation)
        return flipped
    }

    public enum Flip {
        case horizontal
        case vertical
    }

    final public let flip: Flip

    public init(_ decorated: ContentKit.Image, flip: Flip) {
        self.flip = flip
        self.decorated = decorated
    }
}

fileprivate extension FlippedImage.Flip {

    fileprivate func imageOrientation(fromCurrentOrientation currentOrientation: UIImage.Orientation) -> UIImage.Orientation {
        switch (self, currentOrientation) {

        // horizontal - up
        case (FlippedImage.Flip.horizontal, UIImage.Orientation.up):
            return UIImage.Orientation.upMirrored

        case (FlippedImage.Flip.horizontal, UIImage.Orientation.upMirrored):
            return UIImage.Orientation.up

        // horizontal - left
        case (FlippedImage.Flip.horizontal, UIImage.Orientation.left):
            return UIImage.Orientation.leftMirrored

        case (FlippedImage.Flip.horizontal, UIImage.Orientation.leftMirrored):
            return UIImage.Orientation.left

        // horizontal - right
        case (FlippedImage.Flip.horizontal, UIImage.Orientation.right):
            return UIImage.Orientation.rightMirrored

        case (FlippedImage.Flip.horizontal, UIImage.Orientation.rightMirrored):
            return UIImage.Orientation.right

        // horizontal - down
        case (FlippedImage.Flip.horizontal, UIImage.Orientation.down):
            return UIImage.Orientation.downMirrored

        case (FlippedImage.Flip.horizontal, UIImage.Orientation.downMirrored):
            return UIImage.Orientation.down

        // vertical - up
        case (FlippedImage.Flip.vertical, UIImage.Orientation.up):
            return UIImage.Orientation.downMirrored

        case (FlippedImage.Flip.vertical, UIImage.Orientation.upMirrored):
            return UIImage.Orientation.up

        // vertical - left
        case (FlippedImage.Flip.vertical, UIImage.Orientation.left):
            return UIImage.Orientation.rightMirrored

        case (FlippedImage.Flip.vertical, UIImage.Orientation.leftMirrored):
            return UIImage.Orientation.right

        // vertical - right
        case (FlippedImage.Flip.vertical, UIImage.Orientation.right):
            return UIImage.Orientation.leftMirrored
        case (FlippedImage.Flip.vertical, UIImage.Orientation.rightMirrored):
            return UIImage.Orientation.left

        // vertical - down
        case (FlippedImage.Flip.vertical, UIImage.Orientation.down):
            return UIImage.Orientation.upMirrored
        case (FlippedImage.Flip.vertical, UIImage.Orientation.downMirrored):
            return UIImage.Orientation.up

        }
    }
}
