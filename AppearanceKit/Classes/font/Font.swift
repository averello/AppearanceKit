//
//  Font.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 25/07/2016.
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

#if canImport(UIKit)
import UIKit

/// A font.
public protocol Font {
    /// The backing `UIKit` font.
    var font: UIFont { get }
    
    /// The normal font.
    var normal: Font { get }
    /// The highlighted font.
    var hightlighted: Font? { get }
    /// The disabled font.
    var disabled: Font? { get }
    /// The selected font.
    var selected: Font? { get }
    
    /// The font's size.
    var fontSize: Float { get }
    /// The font's family.
    var family: String { get }
    /// The font's name.
    var name: String { get }
    /// The font's point size.
    var pointSize: Float { get }
    /// The font's ascender.
    var ascender: Float { get }
    /// The font's descender.
    var descender: Float { get }
    /// The font's capHeight.
    var capHeight: Float { get }
    /// The font's xHeight.
    var xHeight: Float { get }
    /// The font's lineHeight.
    var lineHeight: Float { get }
    /// The font's leading.
    var leading: Float { get }
    
    /// The bold variance fo the font, if any.
    var bold: Font? { get }
    
    /// Derive a font similar to the receiver with the provided `size`.
    /// - parameter size: The new size.
    /// - returns: A different size font.
    func with(size: Float) -> Font
}

public extension Font {
    var font: UIFont { return self.normal.font }
    
    var fontSize: Float { return self.pointSize }
    var family: String { return self.font.familyName }
    var name: String { return self.font.fontName }
    var pointSize: Float { return Float(self.font.pointSize) }
    var ascender: Float { return Float(self.font.ascender) }
    var descender: Float { return Float(self.font.descender) }
    var capHeight: Float { return Float(self.font.capHeight) }
    var xHeight: Float { return Float(self.font.xHeight) }
    var lineHeight: Float { return Float(self.font.lineHeight) }
    var leading: Float { return Float(self.font.leading) }
    
    var hightlighted: Font? { return nil }
    var disabled: Font? { return nil }
    var selected: Font? { return nil }
}

public extension Font {
    
    /// Configures a `UIButton`.
    func configure(button: UIButton) {
        button.titleLabel?.font = self.font
    }
}
#endif
