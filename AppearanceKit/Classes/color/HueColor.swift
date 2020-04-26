//
//  HueColor.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 03/05/2018.
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

#if canImport(UIKit) && canImport(CoreGraphics)
import UIKit
import CoreGraphics

/// A color based on HSBA properties.
public struct HueColor: Color {

    /// The hue value. On extended color space can be any value at all,
    /// otherwise it should be a value from 0.0 to 1.0.
    public var hue: CGFloat
    /// The saturation value. On extended color space can be any value at all,
    /// otherwise it should be a value from 0.0 to 1.0.
    public var saturation: CGFloat
    /// The brightness value. On extended color space can be any value at all,
    /// otherwise it should be a value from 0.0 to 1.0.
    public var brightness: CGFloat
    /// The opacity value, specified as a value from 0.0 to 1.0.
    public var alpha: CGFloat

    /// Creates a hue color from a `UIColor`.
    public init(_ color: UIColor) {
        var (hue, saturation, brightness, alpha) = (CGFloat(0),
                                                    CGFloat(0),
                                                    CGFloat(0),
                                                    CGFloat(0))
        color.getHue(&hue,
                     saturation: &saturation,
                     brightness: &brightness,
                     alpha: &alpha)
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.alpha = alpha
    }

    /// Creates a hue color from any `Color`.
    public init(_ color: AppearanceKit.Color) {
        self.init(color.color)
    }

    public var color: UIColor {
        return UIColor(hue: self.hue,
                       saturation: self.saturation,
                       brightness: self.brightness,
                       alpha: self.alpha)
    }
}

extension Color {

    /// returns the "same" color with the specified hue.
    /// - parameter hue: The hue of the color.
    public func with(hue: CGFloat) -> AppearanceKit.Color {
        var copy = HueColor(self)
        copy.hue = hue
        return copy
    }

    /// returns the "same" color with the specified saturation.
    /// - parameter saturation: The saturation of the color.
    public func with(saturation: CGFloat) -> AppearanceKit.Color {
        var copy = HueColor(self)
        copy.saturation = saturation
        return copy
    }

    /// returns the "same" color with the specified brightness.
    /// - parameter brightness: The brightness of the color.
    public func with(brightness: CGFloat) -> AppearanceKit.Color {
        var copy = HueColor(self)
        copy.brightness = brightness
        return copy
    }
}

#endif /* UIKit */
