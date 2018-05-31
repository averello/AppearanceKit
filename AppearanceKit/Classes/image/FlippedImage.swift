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

    fileprivate func imageOrientation(fromCurrentOrientation currentOrientation: UIImageOrientation) -> UIImageOrientation {
        switch (self, currentOrientation) {

        // horizontal - up
        case (FlippedImage.Flip.horizontal, UIImageOrientation.up):
            return UIImageOrientation.upMirrored

        case (FlippedImage.Flip.horizontal, UIImageOrientation.upMirrored):
            return UIImageOrientation.up

        // horizontal - left
        case (FlippedImage.Flip.horizontal, UIImageOrientation.left):
            return UIImageOrientation.leftMirrored

        case (FlippedImage.Flip.horizontal, UIImageOrientation.leftMirrored):
            return UIImageOrientation.left

        // horizontal - right
        case (FlippedImage.Flip.horizontal, UIImageOrientation.right):
            return UIImageOrientation.rightMirrored

        case (FlippedImage.Flip.horizontal, UIImageOrientation.rightMirrored):
            return UIImageOrientation.right

        // horizontal - down
        case (FlippedImage.Flip.horizontal, UIImageOrientation.down):
            return UIImageOrientation.downMirrored

        case (FlippedImage.Flip.horizontal, UIImageOrientation.downMirrored):
            return UIImageOrientation.down

        // vertical - up
        case (FlippedImage.Flip.vertical, UIImageOrientation.up):
            return UIImageOrientation.downMirrored

        case (FlippedImage.Flip.vertical, UIImageOrientation.upMirrored):
            return UIImageOrientation.up

        // vertical - left
        case (FlippedImage.Flip.vertical, UIImageOrientation.left):
            return UIImageOrientation.rightMirrored

        case (FlippedImage.Flip.vertical, UIImageOrientation.leftMirrored):
            return UIImageOrientation.right

        // vertical - right
        case (FlippedImage.Flip.vertical, UIImageOrientation.right):
            return UIImageOrientation.leftMirrored
        case (FlippedImage.Flip.vertical, UIImageOrientation.rightMirrored):
            return UIImageOrientation.left

        // vertical - down
        case (FlippedImage.Flip.vertical, UIImageOrientation.down):
            return UIImageOrientation.upMirrored
        case (FlippedImage.Flip.vertical, UIImageOrientation.downMirrored):
            return UIImageOrientation.up

        }
    }
}
