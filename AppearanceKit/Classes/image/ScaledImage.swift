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
import ContentKit

final public class ScaledImage: ContentKit.Image {
    final private let decorated: ContentKit.Image
    final public let horizontal: Float
    final public let vertical: Float
    
    private lazy var drawnImage: ContentKit.Image = {
        return autoreleasepool {
            
            let size = self.decorated.size
            let configuration = CGContext.Configuration(interpolationQuality: CGInterpolationQuality.high)
            
            let options = DrawnImage.Options(size: size, configuration: configuration) { (image: ContentKit.Image, bounds: CGRect, context: CGContext) in
                guard let cgImage = image.image.cgImage else { return }
                
                
                context.scaleBy(x: CGFloat(self.horizontal),
                                y: CGFloat(self.vertical))
                context.draw(cgImage, in: bounds)
            }
            return DrawnImage(self.decorated, options: options)
        }
    }()
    
    public var image: UIImage {
        return self.drawnImage.image
    }
    
    public convenience init(_ decorated: ContentKit.Image, scale: Float) {
        self.init(decorated,
                  horizontal: scale,
                  vertical: scale)
    }
    
    public init(_ decorated: ContentKit.Image, horizontal: Float, vertical: Float) {
        self.decorated = decorated
        self.horizontal = horizontal
        self.vertical = vertical
    }
}
