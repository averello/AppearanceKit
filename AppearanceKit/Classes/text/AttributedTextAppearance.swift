//
//  AttributedTextAppearance.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 29/03/2018.
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

#if canImport(ContentKit)
import ContentKit

/// An appearance for `AttributedText`s.
public protocol AttributedTextAppearance: ContentAppearance {
    /// The font of the text.
    ///
    /// The value of this attribute is a `AppearanceKit.Font` object. Use this
    /// attribute to change the font of the text. If you do not specify this
    /// attribute, the string uses a 12-point Helvetica(Neue) font by default.
    var font: Font? { get }
    /// The foreground color to display the text.
    ///
    /// The value of this attribute is a `AppearanceKit.Color` object. Use this
    /// attribute to specify the color of the text during rendering. If you do
    /// not specify this attribute, the text is rendered in black.
    var color: Color? { get }
    /// The background color of the text.
    ///
    /// The value of this attribute is a `ApperanceKit.Color` object. Use this
    /// attribute to specify the color of the background area behind the text.
    /// If you do not specify this attribute, no background color is drawn.
    var backgroundColor: Color? { get }
    /// The stroke color of the text.
    ///
    /// The value of this parameter is a `AppearanceKit.Color` object. If it is
    /// not defined (which is the case by default), it is assumed to be the same
    /// as the value of `foregroundColor`; otherwise, it describes the outline
    /// color.
    var strokeColor: Color? { get }
    /// The storke width.
    ///
    /// This value represents the amount to change the
    /// stroke width and is specified as a percentage of the font point
    /// size. Specify 0 (the default) for no additional changes. Specify
    /// positive values to change the stroke width alone. Specify negative
    /// values to stroke and fill the text. For example, a typical value
    /// for outlined text would be 3.0.
    var strokeWidth: Float? { get }
    /// The shadow of the text.
    ///
    /// The value of this attribute is an `AttributedText.Shadow` object. The
    /// default value of this property is `nil`.
    var shadow: AttributedText.Shadow? { get }
    /// The paragraph style.
    ///
    /// The value of this attribute is an `AttributedText.ParagraphStyle`
    /// object. Use this attribute to apply multiple attributes to the text. If
    /// you do not specify this attribute, the string uses the default paragraph
    /// attributes, as returned by the `default` method of
    /// `AttributedText.ParagraphStyle`.
    var style: AttributedText.ParagraphStyle? { get }

    /// Configures an `AttributedText` with the receiver.
    /// - parameter text: The `AttributedText` to configure.
    func configure(_ text: inout AttributedText)
}

public extension AttributedTextAppearance {
    
    public func configure(_ text: inout AttributedText) {
        text.font = self.font
        text.color = self.color
        text.backgroundColor = self.backgroundColor
        text.strokeColor = self.strokeColor
        text.strokeWidth = self.strokeWidth
        text.shadow = self.shadow
        self.style.map { text.style = $0 }
    }
}

/// A default `AttributedTextAppearance`.
public struct DefaultAttributedTextAppearance: AttributedTextAppearance {
    
    public var font: Font?
    public var color: Color?
    public var backgroundColor: Color?
    public var strokeColor: Color?
    public var strokeWidth: Float?
    public var shadow: AttributedText.Shadow?
    public var style: AttributedText.ParagraphStyle?
    
    public init(font: Font? = nil,
                color: Color? = nil,
                backgroundColor: Color? = nil,
                strokeColor: Color? = nil,
                strokeWidth: Float? = nil,
                shadow: AttributedText.Shadow? = nil,
                style: AttributedText.ParagraphStyle? = nil) {
        self.font = font
        self.color = color
        self.backgroundColor = backgroundColor
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.shadow = shadow
        self.style = style
    }
    
    public init(labelAppearance: UILabelAppearance) {
        var shadow: AttributedText.Shadow? = nil
        if let shadowColor = labelAppearance.shadowColor,
            let shadowOffset = labelAppearance.shadowOffset {
            shadow = AttributedText.Shadow(offset: (horizontal: shadowOffset.width,
                                                    vertical: shadowOffset.height),
                                           color: shadowColor)
        }
        var style: AttributedText.ParagraphStyle = AttributedText.ParagraphStyle()
        if let alignment = labelAppearance.alignement {
            style.alignment = AttributedText.Alignment(textAlignment: alignment)
        }
        self.init(font: labelAppearance.font,
                  color: labelAppearance.textColor,
                  backgroundColor: labelAppearance.backgroundColor,
                  strokeColor: nil,
                  strokeWidth: nil,
                  shadow: shadow,
                  style: style)
    }
}
#endif
