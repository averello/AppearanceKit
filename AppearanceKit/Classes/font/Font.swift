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

public protocol Font {
    var font: UIFont { get }

    var normal: Font { get }
    var hightlighted: Font? { get }
    var disabled: Font? { get }
    var selected: Font? { get }

    var fontSize : Float { get }
    var family: String { get }
    var name: String { get }
    var pointSize: Float { get }
    var ascender: Float { get }
    var descender: Float { get }
    var capHeight: Float { get }
    var xHeight: Float { get }
    var lineHeight: Float { get }
    var leading: Float { get }

    var bold: Font? { get }
    
    func with(size: Float) -> Font
}

public extension Font {
    public var font: UIFont { return self.normal.font }

    public var fontSize : Float { return self.pointSize }
    public var family: String { return self.font.familyName }
    public var name: String { return self.font.fontName }
    public var pointSize: Float { return Float(self.font.pointSize) }
    public var ascender: Float { return Float(self.font.ascender) }
    public var descender: Float { return Float(self.font.descender) }
    public var capHeight: Float { return Float(self.font.capHeight) }
    public var xHeight: Float { return Float(self.font.xHeight) }
    public var lineHeight: Float { return Float(self.font.lineHeight) }
    public var leading: Float { return Float(self.font.leading) }
    
    public var hightlighted: Font? { return nil }
    public var disabled: Font? { return nil }
    public var selected: Font? { return nil }
}
