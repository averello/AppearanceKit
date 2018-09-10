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

public enum UILabelAppearanceField {
    case font(Font?)
    case textColor(TextColor?)
    case shadowColor(Color?)
    case shadowOffset(AppearanceKit.Size?)
    case numberOfLines(Int?)
    case adjustsFontSizeToFitWidth(Bool)
    case minimumScaleFactor(Float?)
    case alignement(NSTextAlignment?)
}

public protocol UILabelAppearance: UIContentAppearance {
    var font: Font? { get }
    var textColor: TextColor? { get }
    var shadowColor: Color? { get }
    var shadowOffset: AppearanceKit.Size? { get }
    var numberOfLines: Int? { get }
    var adjustsFontSizeToFitWidth: Bool { get }
    var minimumScaleFactor: Float? { get }
    var alignement: NSTextAlignment? { get }
}

public extension UILabelAppearance {
    
    public func configure(_ content: ConfigurableUIContent) {
        // super
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
        //assert(false)
    }
    
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

public extension UILabelAppearance {

    public var configurableAppearance: ConfigurableUILabelAppearance {
        return ConfigurableUILabelAppearance(appearance: self)
    }

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

    public func updating(fields: UILabelAppearanceField...) -> UILabelAppearance {
        return fields.reduce(self, { (partial: UILabelAppearance, field: UILabelAppearanceField) -> UILabelAppearance in
            return partial.updating(field: field)
        })
    }
}
