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

#if canImport(UIKit) && canImport(ContentKit)
import UIKit
import ContentKit

/// An image that can be tinted with a color using specific blend mode.
public final class TintedImage: ContentKit.Image {

    /// Compositing operations for images.
    ///
    /// These blend mode constants represent the Porter-Duff blend modes. The
    /// symbols in the equations for these blend modes are:
    /// * R is the premultiplied result
    /// * S is the source color, and includes alpha
    /// * D is the destination color, and includes alpha
    /// * Ra, Sa, and Da are the alpha components of R, S, and D
    ///
    /// You can find more information on blend modes, including examples of
    /// images produced using them, and many mathematical descriptions of the
    /// modes, in PDF Reference, Fourth Edition, Version 1.5, Adobe Systems,
    /// Inc. If you are a former QuickDraw developer, it may be helpful for you
    /// to think of blend modes as an alternative to transfer modes.
    public enum BlendMode {
        /// Paints the source image samples over the background image samples.
        case normal
        /// Multiplies the source image samples with the background image
        /// samples. This results in colors that are at least as dark as either
        /// of the two contributing sample colors.
        case multiply
        /// Multiplies the inverse of the source image samples with the inverse
        /// of the background image samples, resulting in colors that are at
        /// least as light as either of the two contributing sample colors.
        case screen
        /// Either multiplies or screens the source image samples with the
        /// background image samples, depending on the background color. The
        /// result is to overlay the existing image samples while preserving the
        /// highlights and shadows of the background. The background color mixes
        /// with the source image to reflect the lightness or darkness of the
        /// background.
        case overlay
        /// Creates the composite image samples by choosing the darker samples
        /// (either from the source image or the background). The result is that
        /// the background image samples are replaced by any source image
        /// samples that are darker. Otherwise, the background image samples are
        /// left unchanged.
        case darken
        /// Creates the composite image samples by choosing the lighter samples
        /// (either from the source image or the background). The result is that
        /// the background image samples are replaced by any source image
        /// samples that are lighter. Otherwise, the background image samples
        /// are left unchanged.
        case lighten
        /// Brightens the background image samples to reflect the source image
        /// samples. Source image sample values that specify black do not
        /// produce a change.
        case colorDodge
        /// Darkens the background image samples to reflect the source image
        /// samples. Source image sample values that specify white do not
        /// produce a change.
        case colorBurn
        /// Either darkens or lightens colors, depending on the source image
        /// sample color. If the source image sample color is lighter than 50%
        /// gray, the background is lightened, similar to dodging. If the source
        /// image sample color is darker than 50% gray, the background is
        /// darkened, similar to burning. If the source image sample color is
        /// equal to 50% gray, the background is not changed. Image samples that
        /// are equal to pure black or pure white produce darker or lighter
        /// areas, but do not result in pure black or white. The overall effect
        /// is similar to what you’d achieve by shining a diffuse spotlight on
        /// the source image. Use this to add highlights to a scene.
        case softLight
        /// Either multiplies or screens colors, depending on the source image
        /// sample color. If the source image sample color is lighter than 50%
        /// gray, the background is lightened, similar to screening. If the
        /// source image sample color is darker than 50% gray, the background is
        /// darkened, similar to multiplying. If the source image sample color
        /// is equal to 50% gray, the source image is not changed. Image samples
        /// that are equal to pure black or pure white result in pure black or
        /// white. The overall effect is similar to what you’d achieve by
        /// shining a harsh spotlight on the source image. Use this to add
        /// highlights to a scene.
        case hardLight
        /// Subtracts either the source image sample color from the background
        /// image sample color, or the reverse, depending on which sample has
        /// the greater brightness value. Source image sample values that are
        /// black produce no change; white inverts the background color values.
        case difference
        /// Produces an effect similar to that produced by
        /// TintedImage.BlendMode.difference, but with lower contrast. Source
        /// image sample values that are black don’t produce a change; white
        /// inverts the background color values.
        case exclusion
        /// Uses the luminance and saturation values of the background with the
        /// hue of the source image.
        case hue
        /// Uses the luminance and hue values of the background with the
        /// saturation of the source image. Areas of the background that have no
        /// saturation (that is, pure gray areas) don’t produce a change.
        case saturation
        /// Uses the luminance values of the background with the hue and
        /// saturation values of the source image. This mode preserves the gray
        /// levels in the image. You can use this mode to color monochrome
        /// images or to tint color images.
        case color
        /// Uses the hue and saturation of the background with the luminance of
        /// the source image. This mode creates an effect that is inverse to the
        /// effect created by TintedImage.BlendMode.color.
        case luminosity
        /// R = 0
        case clear
        /// R = S
        case copy
        /// R = S*Da
        case sourceIn
        /// R = S*(1 - Da)
        case sourceOut
        /// R = S*Da + D*(1 - Sa)
        case sourceAtop
        /// R = S*(1 - Da) + D
        case destinationOver
        /// R = D*Sa
        case destinationIn
        /// R = D*(1 - Sa)
        case destinationOut
        /// R = S*(1 - Da) + D*Sa
        case destinationAtop
        /// R = S*(1 - Da) + D*(1 - Sa). This XOR mode is only nominally related
        /// to the classical bitmap XOR operation, which is not supported by
        /// Core Graphics.
        case xor
        /// R = MAX(0, 1 - ((1 - D) + (1 - S)))
        case plusDarker
        /// R = MIN(1, S + D)
        case plusLighter
    }

    /// The default tint color for `TintedImage` is black with 1/3 opacity.
    public struct DefaultTintColor: Color {
        public let color: UIColor
        
        public init() {
            self.color = UIColor(white: 0.0, alpha: 0.3)
        }
    }
    
    final private let decorated: ContentKit.Image
    final private let color: Color
    final private let blendMode: TintedImage.BlendMode

    /// Creates a `TintedImage` based on the provided image that will be blended
    /// with the given mode using the provided color.
    /// - parameter decorated: The image to tint.
    /// - parameter color: The color to use for tinting.
    /// - parameter blendMode: The blend mode to use for the tint process.
    public init(_ decorated: ContentKit.Image,
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

    /// Returns a tinted image of the receiver with the provided color using
    /// the given blend mode.
    /// - parameter color: The color to use for tinting.
    /// - parameter blendMode: The blend mode to use for the tint process.
    public func tintedImage(withColor color: Color = TintedImage.DefaultTintColor(),
                            blendMode: TintedImage.BlendMode = TintedImage.BlendMode.sourceAtop) -> ContentKit.Image {
        return TintedImage(self,
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

#endif
