//
//  TintedImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 29/11/2017.
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
import UIKit
import ContentKit

public final class TintedImage: ContentKit.Image {
    
    public enum BlendMode {
        case normal
        case multiply
        case screen
        case overlay
        case darken
        case lighten
        case colorDodge
        case colorBurn
        case softLight
        case hardLight
        case difference
        case exclusion
        case hue
        case saturation
        case color
        case luminosity
        case clear
        case copy
        case sourceIn
        case sourceOut
        case sourceAtop
        case destinationOver
        case destinationIn
        case destinationOut
        case destinationAtop
        case xor
        case plusDarker
        case plusLighter
    }
    
    public struct DefaultTintColor: Color {
        public let color: UIColor
        
        public init() {
            self.color = UIColor(white: 0.0, alpha: 0.3)
        }
    }
    
    final private let decorated: ContentKit.Image
    final private let color: Color
    final private let blendMode: TintedImage.BlendMode
    
    public init(decorated: ContentKit.Image,
                color: Color = TintedImage.DefaultTintColor(),
                blendMode: TintedImage.BlendMode = TintedImage.BlendMode.sourceAtop) {
        self.decorated = decorated
        self.color = color
        self.blendMode = blendMode
    }
    
    final private lazy var tintedImage: ContentKit.Image = {
        let color = self.color.color
        let blendMode = self.blendMode.cgBlendMode
        let options = DrawnImage.Options(size: self.decorated.size) { (image: ContentKit.Image, bounds: CGRect, context: CGContext) in
            image.image.draw(in: bounds)
            color.set()
            UIRectFillUsingBlendMode(bounds, blendMode)
        }
        return DrawnImage(self.decorated, options: options)
    }()
    
    final public var image: UIImage {
        return self.tintedImage.image
    }
}

public extension ContentKit.Image {
    
    public func tintedImage(withColor color: Color = TintedImage.DefaultTintColor(),
                            blendMode: TintedImage.BlendMode = TintedImage.BlendMode.sourceAtop) -> ContentKit.Image {
        return TintedImage(decorated: self,
                           color: color,
                           blendMode: blendMode)
    }
}

fileprivate extension TintedImage.BlendMode {
    var cgBlendMode: CGBlendMode {
        switch self {
        case TintedImage.BlendMode.normal:
            return CGBlendMode.normal
        case TintedImage.BlendMode.multiply:
            return CGBlendMode.multiply
        case TintedImage.BlendMode.screen:
            return CGBlendMode.screen
        case TintedImage.BlendMode.overlay:
            return CGBlendMode.overlay
        case TintedImage.BlendMode.darken:
            return CGBlendMode.darken
        case TintedImage.BlendMode.lighten:
            return CGBlendMode.lighten
        case TintedImage.BlendMode.colorDodge:
            return CGBlendMode.colorDodge
        case TintedImage.BlendMode.colorBurn:
            return CGBlendMode.colorBurn
        case TintedImage.BlendMode.softLight:
            return CGBlendMode.softLight
        case TintedImage.BlendMode.hardLight:
            return CGBlendMode.hardLight
        case TintedImage.BlendMode.difference:
            return CGBlendMode.difference
        case TintedImage.BlendMode.exclusion:
            return CGBlendMode.exclusion
        case TintedImage.BlendMode.hue:
            return CGBlendMode.hue
        case TintedImage.BlendMode.saturation:
            return CGBlendMode.saturation
        case TintedImage.BlendMode.color:
            return CGBlendMode.color
        case TintedImage.BlendMode.luminosity:
            return CGBlendMode.luminosity
        case TintedImage.BlendMode.clear:
            return CGBlendMode.clear
        case TintedImage.BlendMode.copy:
            return CGBlendMode.copy
        case TintedImage.BlendMode.sourceIn:
            return CGBlendMode.sourceIn
        case TintedImage.BlendMode.sourceOut:
            return CGBlendMode.sourceOut
        case TintedImage.BlendMode.sourceAtop:
            return CGBlendMode.sourceAtop
        case TintedImage.BlendMode.destinationOver:
            return CGBlendMode.destinationOver
        case TintedImage.BlendMode.destinationIn:
            return CGBlendMode.destinationIn
        case TintedImage.BlendMode.destinationOut:
            return CGBlendMode.destinationOut
        case TintedImage.BlendMode.destinationAtop:
            return CGBlendMode.destinationAtop
        case TintedImage.BlendMode.xor:
            return CGBlendMode.xor
        case TintedImage.BlendMode.plusDarker:
            return CGBlendMode.plusDarker
        case TintedImage.BlendMode.plusLighter:
            return CGBlendMode.plusLighter
        }
    }
}

//fileprivate extension UIImage {
//    
//    fileprivate func tintedImage_blendedImage(usingColor color: UIColor, blendMode: CGBlendMode) -> UIImage? {
//        return autoreleasepool {
//            let size = self.size
//            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//            let draw = {
//                self.draw(in: rect)
//                color.set()
//            }
//            if #available(iOS 10.0,  *) {
//                let renderer = UIGraphicsImageRenderer(size: size)
//                return renderer.image(actions: { (context: UIGraphicsImageRendererContext) in
//                    draw()
//                    context.fill(rect, blendMode: blendMode)
//                })
//            }
//            else {
//                UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
//                defer { UIGraphicsEndImageContext() }
//                guard let _ = UIGraphicsGetCurrentContext() else { return nil }
//                draw()
//                UIRectFillUsingBlendMode(rect, blendMode)
//                guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
//                return result
//            }
//        }
//    }
//}

