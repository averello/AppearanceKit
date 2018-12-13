//
//  DefaultUILabelAppearance.swift
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

#if canImport(UIKit) && canImport(QuartzCore)
import UIKit
import QuartzCore

/// A default `UILabelAppearance`.
public struct DefaultUILabelAppearance: UILabelAppearance {
    public var font: Font? = SystemFont()
    public var textColor: TextColor? = TextColor(normal: WhiteColor())
    public var shadowColor: Color?
    public var shadowOffset: AppearanceKit.Size?
    public var numberOfLines: Int?
    public var adjustsFontSizeToFitWidth: Bool = true
    public var minimumScaleFactor: Float? = 0.5
    public var alignement: NSTextAlignment?
    
    
    public var backgroundColor: Color? = ClearColor()
    public var tintColor: Color?
    
    public var layerAppearance: CAContentAppearance?
    
    public init() {}
}
#endif
