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
import ContentKit

public protocol AttributedTextAppearance: ContentAppearance {
    var font: Font? { get }
    var color: Color? { get }
    var backgroundColor: Color? { get }
    var strokeColor: Color? { get }
    var strokeWidth: Float? { get }
    var shadow: AttributedText.Shadow? { get }
    var style: AttributedText.ParagraphStyle? { get }
    
    func configure(_ text: inout AttributedText)
}

public extension AttributedTextAppearance {
    
    public func configure(_ text: inout AttributedText) {
        text.font            = self.font
        text.color           = self.color
        text.backgroundColor = self.backgroundColor
        text.strokeColor     = self.strokeColor
        text.strokeWidth     = self.strokeWidth
        text.shadow          = self.shadow
        self.style.map { text.style = $0 }
    }
}

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
        self.font            = font
        self.color           = color
        self.backgroundColor = backgroundColor
        self.strokeColor     = strokeColor
        self.strokeWidth     = strokeWidth
        self.shadow          = shadow
        self.style           = style
    }
    
    public init(labelAppearance: UILabelAppearance) {
        var shadow: AttributedText.Shadow? = nil
        if let shadowColor = labelAppearance.shadowColor,
            let shadowOffset = labelAppearance.shadowOffset {
            shadow = AttributedText.Shadow(offset: (x: shadowOffset.width, y: shadowOffset.height),
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

