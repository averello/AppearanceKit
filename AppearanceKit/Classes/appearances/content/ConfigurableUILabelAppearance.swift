//
//  ConfigurableUILabelAppearance.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 15/05/2017.
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

public struct ConfigurableUILabelAppearance: UILabelAppearance {
    public var font: Font?
    public var textColor: TextColor?
    public var shadowColor: Color?
    public var shadowOffset: AppearanceKit.Size?
    public var numberOfLines : Int?
    public var adjustsFontSizeToFitWidth : Bool?
    public var minimumScaleFactor: Float?
    public var alignement : NSTextAlignment?
    public var backgroundColor: Color?
    public var tintColor: Color?
    
    public init(appearance: UILabelAppearance = DefaultUILabelAppearance()) {
        self.init(font: appearance.font,
                  textColor: appearance.textColor,
                  shadowColor: appearance.shadowColor,
                  shadowOffset: appearance.shadowOffset,
                  numberOfLines: appearance.numberOfLines,
                  adjustsFontSizeToFitWidth: appearance.adjustsFontSizeToFitWidth,
                  minimumScaleFactor: appearance.minimumScaleFactor,
                  alignement: appearance.alignement,
                  backgroundColor: appearance.backgroundColor,
                  tintColor: appearance.tintColor)
    }
    
    public init(font: Font? = DefaultUILabelAppearance().font,
                textColor: TextColor? = DefaultUILabelAppearance().textColor,
                shadowColor: Color?  = DefaultUILabelAppearance().shadowColor,
                shadowOffset: Size? = DefaultUILabelAppearance().shadowOffset,
                numberOfLines : Int? = DefaultUILabelAppearance().numberOfLines,
                adjustsFontSizeToFitWidth : Bool? = DefaultUILabelAppearance().adjustsFontSizeToFitWidth,
                minimumScaleFactor: Float? = DefaultUILabelAppearance().minimumScaleFactor,
                alignement : NSTextAlignment? = DefaultUILabelAppearance().alignement,
                backgroundColor: Color? = DefaultUILabelAppearance().backgroundColor,
                tintColor: Color? = DefaultUILabelAppearance().tintColor) {
        self.font = font
        self.textColor = textColor
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.minimumScaleFactor = minimumScaleFactor
        self.alignement = alignement
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }
}
