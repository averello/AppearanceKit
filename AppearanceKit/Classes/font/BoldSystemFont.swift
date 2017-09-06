//
//  BoldSystemFont.swift
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

public struct BoldSystemFont: Font {
    private let size: Float
    
    public var font: UIFont {
        return UIFont.boldSystemFont(ofSize: CGFloat(self.size))
    }
    
    public init() {
        self.init(size: Float(UIFont.systemFontSize))
    }
    
    private init(size: Float) {
        self.size = size
    }
    
    public var normal: Font { return self }
    public var hightlighted: Font? { return self }
    public var disabled: Font? { return self }
    public var selected: Font? { return self }
    
    public var bold: Font? { return self }
    
    public func with(size: Float) -> Font {
        return BoldSystemFont(size: size)
    }
}
