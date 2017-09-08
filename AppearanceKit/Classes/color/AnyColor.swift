//
//  AnyColor.swift
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

public struct AnyColor: Color {
    private let _color: UIColor
    public var color: UIColor { return self._color }
    
    public init(color: UIColor) {
        self._color = color
    }
    
    public init(red: Float, green: Float, blue: Float, alpha: Float = 1.0) {
        let valid: (Float) -> Bool = { v -> Bool in v >= 0.0 && v <= 1.0 }
        guard valid(red) && valid(green) && valid(blue) && valid(alpha) else { fatalError("invalid values") }
        
        self._color = UIColor(red: CGFloat(red),
                                green: CGFloat(green),
                                blue: CGFloat(blue),
                                alpha: CGFloat(alpha))
    }
    
    public init(hexRed red: Float, hexGreen green: Float, hexBlue blue: Float, hexAlpha alpha: Float = 0xff) {
        let valid: (Float) -> Bool = { v -> Bool in v >= 0.0 && v <= 0xff }
        guard valid(red) && valid(green) && valid(blue) && valid(alpha) else { fatalError("invalid values") }
        let twoFiveFive = Float(0xff)
        self.init(red: red / twoFiveFive,
                  green: green / twoFiveFive,
                  blue: blue / twoFiveFive,
                  alpha: alpha / twoFiveFive)
    }
    
    public init(white: Float, alpha: Float = 1.0) {
        self._color = UIColor(white: CGFloat(white), alpha: CGFloat(alpha))
    }
}

public extension AnyColor {
    
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.color(self.color)
    }
    
    public func debugQuickLookObject() -> AnyObject? {
        return self.color
    }
}
