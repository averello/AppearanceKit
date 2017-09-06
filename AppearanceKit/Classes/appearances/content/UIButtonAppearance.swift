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
}

public extension UIButtonAppearance {
    public func configure(_ content: ConfigurableUIContent) {
        guard let aContent = content as? ConfigurableAppearanceButton else { return }
        aContent.backgroundColor = self.backgroundColor?.color
        aContent.tintColor = self.tintColor?.color

        aContent.setTitleColor(self.titleColor?.normal.color, for: UIControlState.normal)
        aContent.setTitleColor(self.titleColor?.highlighted?.color, for: UIControlState.highlighted)
        aContent.setTitleColor(self.titleColor?.disabled?.color, for: UIControlState.disabled)
        aContent.setTitleColor(self.titleColor?.selected?.color, for: UIControlState.selected)

        aContent.titleLabel?.font = self.font?.font
    }
}

public struct DefaultUIButtonAppearance: UIButtonAppearance {
    public var font: Font? = SystemFont()
    public var titleColor: TextColor? = TextColor(normal: WhiteColor(), disabled: LightTextColor())
    public var backgroundColor: Color?
    public var tintColor: Color?
    
    public init(font: Font? = SystemFont(),
                titleColor: TextColor? = TextColor(normal: WhiteColor(), disabled: LightTextColor()),
                backgroundColor: Color? = nil,
                tintColor: Color? = nil) {
        self.font = font
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }
}
