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

public protocol UIContentAppearance: ContentAppearance {
    var backgroundColor: Color? { get }
    var tintColor: Color? { get }
    func configure(_ content: ConfigurableUIContent)
}

public extension UIContentAppearance {
    public func configure(_ content: ConfigurableUIContent) {
        content.view.backgroundColor = self.backgroundColor?.color
        content.view.tintColor = self.tintColor?.color
    }
}

public struct DefaultUIContentAppearance: UIContentAppearance {
    public var backgroundColor: Color?
    public var tintColor: Color?

    public init(backgroundColor: Color? = nil, tintColor: Color? = nil) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }
}
