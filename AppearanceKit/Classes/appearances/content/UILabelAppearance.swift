//
//  UILabelAppearance.swift
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

#if canImport(UIKit) && canImport(QuartzCore)
import UIKit
import QuartzCore

/// An appearance for `UILabel`s.
public protocol UILabelAppearance: UIContentAppearance {
    /// The font.
    var font: Font? { get }
    /// The text color.
    var textColor: TextColor? { get }
    /// The shadow color.
    var shadowColor: Color? { get }
    /// The shadow offset.
    var shadowOffset: AppearanceKit.Size? { get }
    /// The maximum number of lines to use for rendering text.
    var numberOfLines: Int? { get }
    /// A Boolean value indicating whether the font size should be reduced in
    /// order to fit the title string into the label’s bounding rectangle.
    var adjustsFontSizeToFitWidth: Bool { get }
    /// The minimum scale factor supported for the appearance.
    var minimumScaleFactor: Float? { get }
    /// The technique to use for aligning the text.
    var alignement: NSTextAlignment? { get }
}

public extension UILabelAppearance {

    /// Configures a `ConfigurableUIContent` with the receiver.
    /// - parameter content: The `ConfigurableUIContent` to configure.
    public func configure(_ content: ConfigurableUIContent) {
        content.view.backgroundColor = self.backgroundColor?.color
        content.view.tintColor = self.tintColor?.color

        if let caContent = content as? ConfigurableCAContent,
            let layerAppearance = self.layerAppearance {
            caContent.configureContentAppearence(layerAppearance)
        }

        if let aLabel = content as? UILabel {
            self.configure(aLabel)
            return
        }
        if let aTextField = content as? UITextField {
            self.configure(aTextField)
            return
        }
        if let aTextView = content as? UITextView {
            self.configure(aTextView)
            return
        }
    }

    /// Configures any `UILabel` with the receiver.
    /// - parameter content: The `UILabel` to configure.
    public func configure<L>(_ content: L) where L: UILabel {
        let aContent = content
        
        aContent.backgroundColor = self.backgroundColor?.color
        aContent.tintColor = self.tintColor?.color
        
        aContent.font = self.font?.font
        aContent.textColor = self.textColor?.color
        aContent.highlightedTextColor = self.textColor?.highlighted?.color
        aContent.shadowColor = self.shadowColor?.color
        
        if let alignement = self.alignement {
            aContent.textAlignment = alignement
        }
        if let offset = self.shadowOffset {
            aContent.shadowOffset = CGSize(size: offset)
        }
        aContent.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth
        if let scaleFactor = self.minimumScaleFactor {
            aContent.minimumScaleFactor = CGFloat(scaleFactor)
        }
        if let numberOfLines = self.numberOfLines {
            aContent.numberOfLines = numberOfLines
        }
        
    }

    /// Configures any `UITextField` with the receiver.
    ///
    /// As `UITextField` does not support `highlightedTextcolor`, `shadowColor`,
    /// `minimumScaleFactor`, `numberOfLines` & `shadowOffset` those properties
    /// are ignored.
    /// - parameter content: The `UITextField` to configure.
    public func configure<TF>(_ content: TF) where TF: UITextField {
        let aContent = content
        
        aContent.backgroundColor = self.backgroundColor?.color
        aContent.tintColor = self.tintColor?.color
        
        aContent.font = self.font?.font
        aContent.textColor = self.textColor?.color
        
        if let alignement = self.alignement {
            aContent.textAlignment = alignement
        }
        aContent.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth
    }

    /// Configures any `UITextView` with the receiver.
    ///
    /// As `UITextView` does not support `highlightedTextcolor`, `shadowColor`,
    /// `minimumScaleFactor`, `numberOfLines`, `shadowOffset`
    /// & `adjustsFontSizeToFitWidth` those properties are ignored.
    /// - parameter content: The `UITextView` to configure.
    public func configure<TV>(_ content: TV) where TV: UITextView {
        let aContent = content
        
        aContent.backgroundColor = self.backgroundColor?.color
        aContent.tintColor = self.tintColor?.color
        
        aContent.font = self.font?.font
        aContent.textColor = self.textColor?.color
        
        if let alignement = self.alignement {
            aContent.textAlignment = alignement
        }
    }
}

/// The properties of `UILabelAppearance`.
public enum UILabelAppearanceField {
    /// The font property.
    case font(Font?)
    /// The text color property.
    case textColor(TextColor?)
    /// The shadow color property.
    case shadowColor(Color?)
    /// The shadow offset property.
    case shadowOffset(AppearanceKit.Size?)
    /// The number of lines property.
    case numberOfLines(Int?)
    /// The adjust font size to fit width property.
    case adjustsFontSizeToFitWidth(Bool)
    /// The minimum scale factor property.
    case minimumScaleFactor(Float?)
    /// The alignment property.
    case alignement(NSTextAlignment?)
}

public extension UILabelAppearance {

    /// Creates a `ConfigurableUILabelAppearance` from any `UILabelAppearance`.
    public var configurableAppearance: ConfigurableUILabelAppearance {
        return ConfigurableUILabelAppearance(appearance: self)
    }

    /// Creates a derived `UILabelAppearance` that has the provided field.
    ///
    /// Immutability wins.
    /// - parameter field: The field to be updated.
    public func updating(field: UILabelAppearanceField) -> UILabelAppearance {
        var appearance = ConfigurableUILabelAppearance(appearance: self)
        switch field {
        case UILabelAppearanceField.font(let font):
            appearance.font = font
        case UILabelAppearanceField.textColor(let textColor):
            appearance.textColor = textColor
        case UILabelAppearanceField.shadowColor(let shadowColor):
            appearance.shadowColor = shadowColor
        case UILabelAppearanceField.shadowOffset(let offset):
            appearance.shadowOffset = offset
        case UILabelAppearanceField.numberOfLines(let numberOfLines):
            appearance.numberOfLines = numberOfLines
        case UILabelAppearanceField.adjustsFontSizeToFitWidth(let adjustsFontSizeToFitWidth):
            appearance.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        case UILabelAppearanceField.minimumScaleFactor(let minimumScaleFactor):
            appearance.minimumScaleFactor = minimumScaleFactor
        case UILabelAppearanceField.alignement(let alignement):
            appearance.alignement = alignement
        }
        return appearance
    }

    /// Derives an appearance with the specified list of fields.
    /// - parameter fields: The fields to be updated.
    public func updating(fields: UILabelAppearanceField...) -> UILabelAppearance {
        return fields.reduce(self, { (partial: UILabelAppearance, field: UILabelAppearanceField) -> UILabelAppearance in
            return partial.updating(field: field)
        })
    }
}
#endif
