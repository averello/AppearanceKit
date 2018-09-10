//
//  UIContentAppearance.swift
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

public enum UIContentAppearanceField {
    case backgroundColor(Color?)
    case tintColor(Color?)
    case layerAppearance(CAContentAppearance?)
}

public protocol UIContentAppearance: ContentAppearance {
    var backgroundColor: Color? { get }
    var tintColor: Color? { get }
    
    var layerAppearance: CAContentAppearance? { get }
    
    func configure(_ content: ConfigurableUIContent)
}

public extension UIContentAppearance {
    
    public func configure(_ content: ConfigurableUIContent) {
        content.view.backgroundColor = self.backgroundColor?.color
        content.view.tintColor = self.tintColor?.color
        
        if let caContent = content as? ConfigurableCAContent,
            let layerAppearance = self.layerAppearance {
            caContent.configureContentAppearence(layerAppearance)
        }
    }
}

public extension UIContentAppearance {

    public func updating(field: UIContentAppearanceField) -> UIContentAppearance {
        var appearance = DefaultUIContentAppearance(self)
        switch field {
        case UIContentAppearanceField.backgroundColor(let backgroundColor):
            appearance.backgroundColor = backgroundColor
        case UIContentAppearanceField.tintColor(let tintColor):
            appearance.tintColor = tintColor
        case UIContentAppearanceField.layerAppearance(let layerAppearance):
            appearance.layerAppearance = layerAppearance
        }
        return appearance
    }
}

public struct DefaultUIContentAppearance: UIContentAppearance {
    public var backgroundColor: Color?
    public var tintColor: Color?
    
    public var layerAppearance: CAContentAppearance?
    
    public init(backgroundColor: Color? = nil,
                tintColor: Color? = nil,
                layerAppearance: CAContentAppearance? = nil) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.layerAppearance = layerAppearance
    }

    public init(_ appearance: UIContentAppearance) {
        self.init(backgroundColor: appearance.backgroundColor,
                  tintColor: appearance.tintColor,
                  layerAppearance: appearance.layerAppearance)
    }
}
