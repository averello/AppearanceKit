//
//  UIButtonAppearance.swift
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

public enum UIButtonAppearanceField {
    case font(Font?)
    case titleColor(TextColor?)
    case shadowColor(TextColor?)
    case shadowOffset(AppearanceKit.Size?)
    case titleLabelAppearance(UILabelAppearance?)
}

public protocol UIButtonAppearance: UIContentAppearance {
    var font: Font? { get }
    var titleColor: TextColor? { get }
    
    var shadowColor: TextColor? { get }
    var shadowOffset: AppearanceKit.Size? { get }
    
    var titleLabelAppearance: UILabelAppearance? { get }
}

public extension UIButtonAppearance {
    
    public func configure(_ content: ConfigurableUIContent) {

        content.view.backgroundColor = self.backgroundColor?.color
        content.view.tintColor = self.tintColor?.color

        if let caContent = content as? ConfigurableCAContent,
            let layerAppearance = self.layerAppearance {
            caContent.configureContentAppearence(layerAppearance)
        }

        if let aContent = content as? UIButton {
            self.configure(aContent)
            return
        }
        assert(false)
    }
    
    public func configure<B>(_ content: B) where B: UIButton {
        let aContent = content
        
        if let titleLabelAppearance = self.titleLabelAppearance {
            let textColor = titleLabelAppearance.textColor
            aContent.setTitleColor(textColor?.color, for: UIControl.State.normal)
            aContent.setTitleColor(textColor?.highlighted?.color, for: UIControl.State.highlighted)
            aContent.setTitleColor(textColor?.highlighted?.color, for: [UIControl.State.highlighted, UIControl.State.selected])
            aContent.setTitleColor(textColor?.disabled?.color, for: UIControl.State.disabled)
            aContent.setTitleColor(textColor?.selected?.color, for: UIControl.State.selected)
            
            aContent.setTitleShadowColor(titleLabelAppearance.shadowColor?.color,
                                         for: UIControl.State.normal)
            
            if let shadowOffset = titleLabelAppearance.shadowOffset?.asCGSize {
                aContent.titleLabel?.shadowOffset = shadowOffset
            }
            
            aContent.titleLabel?.font = titleLabelAppearance.font?.font
        }
        else {
            aContent.setTitleColor(self.titleColor?.color, for: UIControl.State.normal)
            aContent.setTitleColor(self.titleColor?.highlighted?.color, for: UIControl.State.highlighted)
            aContent.setTitleColor(self.titleColor?.highlighted?.color, for: [UIControl.State.highlighted, UIControl.State.selected])
            aContent.setTitleColor(self.titleColor?.disabled?.color, for: UIControl.State.disabled)
            aContent.setTitleColor(self.titleColor?.selected?.color, for: UIControl.State.selected)
            
            aContent.setTitleShadowColor(self.shadowColor?.color, for: UIControl.State.normal)
            aContent.setTitleShadowColor(self.shadowColor?.highlighted?.color, for: UIControl.State.highlighted)
            aContent.setTitleShadowColor(self.shadowColor?.highlighted?.color, for: [UIControl.State.highlighted, UIControl.State.selected])
            
            aContent.setTitleColor(self.shadowColor?.disabled?.color, for: UIControl.State.disabled)
            aContent.setTitleColor(self.shadowColor?.selected?.color, for: UIControl.State.selected)
            
            if let shadowOffset = self.shadowOffset?.asCGSize {
                aContent.titleLabel?.shadowOffset = shadowOffset
            }
            
            aContent.titleLabel?.font = self.font?.font
        }
    }
}

public extension UIButtonAppearance {

    public var configurableAppearance: ConfigurableUIButtonAppearance {
        return ConfigurableUIButtonAppearance(appearance: self)
    }

    public func updating(field: UIButtonAppearanceField) -> UIButtonAppearance {
        var appearance = self.configurableAppearance
        switch field {
        case UIButtonAppearanceField.font(let font):
            appearance.font = font
        case UIButtonAppearanceField.titleColor(let titleColor):
            appearance.titleColor = titleColor
        case UIButtonAppearanceField.shadowColor(let shadowColor):
            appearance.shadowColor = shadowColor
        case UIButtonAppearanceField.shadowOffset(let offset):
            appearance.shadowOffset = offset
        case UIButtonAppearanceField.titleLabelAppearance(let titleAppearance):
            appearance.titleLabelAppearance = titleAppearance
        }
        return appearance
    }

    public func updating(fields: UIButtonAppearanceField...) -> UIButtonAppearance {
        return fields.reduce(self, { (partial: UIButtonAppearance, field: UIButtonAppearanceField) -> UIButtonAppearance in
            return partial.updating(field: field)
        })
    }
}
