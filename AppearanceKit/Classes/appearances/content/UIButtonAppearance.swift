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

public protocol UIButtonAppearance : UIContentAppearance {
    var font: Font? { get }
    var titleColor: TextColor? { get }
    
    var shadowColor: TextColor? { get }
    var shadowOffset: AppearanceKit.Size? { get }
    
    var titleLabelAppearance: UILabelAppearance? { get }
}

public extension UIButtonAppearance {
    
    public func configure(_ content: ConfigurableUIContent) {
        if let aContent = content as? UIButton {
            self.configure(aContent)
            return
        }
        assert(false)
    }
    
    public func configure<B>(_ content: B) where B: UIButton {
        let aContent = content
        
        aContent.backgroundColor = self.backgroundColor?.color
        aContent.tintColor = self.tintColor?.color
        
        if let titleLabelAppearance = self.titleLabelAppearance {
            let textColor = titleLabelAppearance.textColor
            aContent.setTitleColor(textColor?.color, for: UIControlState.normal)
            aContent.setTitleColor(textColor?.highlighted?.color, for: UIControlState.highlighted)
            aContent.setTitleColor(textColor?.disabled?.color, for: UIControlState.disabled)
            aContent.setTitleColor(textColor?.selected?.color, for: UIControlState.selected)
            
            aContent.setTitleShadowColor(titleLabelAppearance.shadowColor?.color,
                                         for: UIControlState.normal)
            
            if let shadowOffset = titleLabelAppearance.shadowOffset?.asCGSize {
                aContent.titleLabel?.shadowOffset = shadowOffset
            }
            
            aContent.titleLabel?.font = titleLabelAppearance.font?.font
        }
        else {
            aContent.setTitleColor(self.titleColor?.color, for: UIControlState.normal)
            aContent.setTitleColor(self.titleColor?.highlighted?.color, for: UIControlState.highlighted)
            aContent.setTitleColor(self.titleColor?.disabled?.color, for: UIControlState.disabled)
            aContent.setTitleColor(self.titleColor?.selected?.color, for: UIControlState.selected)
            
            aContent.setTitleShadowColor(self.shadowColor?.color, for: UIControlState.normal)
            aContent.setTitleShadowColor(self.shadowColor?.highlighted?.color, for: UIControlState.normal)
            aContent.setTitleColor(self.shadowColor?.disabled?.color, for: UIControlState.disabled)
            aContent.setTitleColor(self.shadowColor?.selected?.color, for: UIControlState.selected)
            
            if let shadowOffset = self.shadowOffset?.asCGSize {
                aContent.titleLabel?.shadowOffset = shadowOffset
            }
            
            aContent.titleLabel?.font = self.font?.font
        }
        
    }
}

public struct DefaultUIButtonAppearance: UIButtonAppearance {
    public var font: Font? = SystemFont()
    public var titleColor: TextColor? = TextColor(normal: WhiteColor(), disabled: LightTextColor())
    public var backgroundColor: Color?
    public var tintColor: Color?
    
    public var layerAppearance: CAContentAppearance?
    
    public var shadowColor: TextColor?
    public var shadowOffset: AppearanceKit.Size?
    
    public var titleLabelAppearance: UILabelAppearance?
    
    
    public init(font: Font? = SystemFont(),
                titleColor: TextColor? = TextColor(normal: WhiteColor(), disabled: LightTextColor()),
                backgroundColor: Color? = nil,
                tintColor: Color? = nil,
                shadowColor: TextColor? = nil,
                shadowOffset: AppearanceKit.Size? = nil,
                titleLabelAppearance: UILabelAppearance? = nil) {
        self.font = font
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.titleLabelAppearance = titleLabelAppearance
    }
}

