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
        return UIImage(cgImage: cgImage,
                       scale: image.scale,
                       orientation: self.flip.imageOrientation)
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

    fileprivate var imageOrientation: UIImageOrientation {
        switch self {
        case FlippedImage.Flip.horizontal:
            return UIImageOrientation.downMirrored

        case FlippedImage.Flip.vertical:
            return UIImageOrientation.leftMirrored

        }
    }
}
