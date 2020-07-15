//
//  AnyFont.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 25/05/2017.
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

/// Adapts any `UIFont` to act as `Font`.
public struct AnyFont: Font {
    public private(set) var font: UIFont
    
    public var normal: Font { return self }
    public var bold: Font? { return nil }
    
    public init(font: UIFont) {
        self.font = font
    }
    
    public func with(size: Float) -> Font {
        return AnyFont(font: self.font.withSize(CGFloat(size)))
    }
}

#endif /* UIKit */
