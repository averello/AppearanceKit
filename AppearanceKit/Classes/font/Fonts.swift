//
//  Fonts.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 01/06/2017.
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

public struct PassionBoldFont: Font {
    private let size: Float
    
    public var font: UIFont {
        return UIFont(name: "PassionOne-Regular",
                      size: CGFloat(self.size))!
    }
    
    public init() {
        self.init(size: Float(UIFont.systemFontSize))
    }
    
    public init(size: Float) {
        self.size = size
    }
    
    public var normal: Font { return self }
    public var hightlighted: Font? { return self }
    public var disabled: Font? { return self }
    public var selected: Font? { return self }
    
    public var bold: Font? { return self }
    
    public func with(size: Float) -> Font {
        return PassionBoldFont(size: size)
    }
}

public struct PassionOneBoldFont: Font {
    private let size: Float
    
    public var font: UIFont {
        return UIFont(name: "PassionOne-Bold",
                      size: CGFloat(self.size))!
    }
    
    public init() {
        self.init(size: Float(UIFont.systemFontSize))
    }
    
    public init(size: Float) {
        self.size = size
    }
    
    public var normal: Font { return self }
    public var hightlighted: Font? { return self }
    public var disabled: Font? { return self }
    public var selected: Font? { return self }
    
    public var bold: Font? { return self }
    
    public func with(size: Float) -> Font {
        return PassionOneBoldFont(size: size)
    }
}

public struct ArvoFont: Font {
    private let size: Float
    
    public var font: UIFont {
        return UIFont(name: "Arvo",
                      size: CGFloat(self.size))!
    }
    
    public init() {
        self.init(size: Float(UIFont.systemFontSize))
    }
    
    public init(size: Float) {
        self.size = size
    }
    
    public var normal: Font { return self }
    public var hightlighted: Font? { return self }
    public var disabled: Font? { return self }
    public var selected: Font? { return self }
    
    public var bold: Font? {
        let bold = UIFont(name: "Arvo-Bold",
                          size: CGFloat(self.size))!
        return AnyFont(font: bold)
    }
    
    public func with(size: Float) -> Font {
        return ArvoFont(size: size)
    }
}

struct AleoFont: Font {
    private let size: Float
    
    public var font: UIFont {
        return UIFont(name: "Aleo-Regular",
                      size: CGFloat(self.size))!
    }
    
    public init() {
        self.init(size: Float(UIFont.systemFontSize))
    }
    
    public init(size: Float) {
        self.size = size
    }
    
    public var normal: Font { return self }
    public var hightlighted: Font? { return self }
    public var disabled: Font? { return self }
    public var selected: Font? { return self }
    
    public var bold: Font? {
        let bold = UIFont(name: "Aleo-Bold",
                          size: CGFloat(self.size))!
        return AnyFont(font: bold)
    }
    
    public func with(size: Float) -> Font {
        return AleoFont(size: size)
    }
}
#endif
