//
//  CAContentAppearance.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 09/03/2018.
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

#if canImport(QuartzCore)
import QuartzCore

/// Appearance specific to Core Animation Content.
public protocol CAContentAppearance: ContentAppearance {
    /// Specifies the `backgroundColor` of a `ConfigurableCAContent`
    var backgroundColor: Color? { get }
    
    /// Configures a `ConfigurableCAContent` with the current appearance.
    func configure(_ content: ConfigurableCAContent)
}

public extension CAContentAppearance {
    
    /// Configures a `ConfigurableCAContent` with the given appearance.
    ///
    /// The default implementation just sets the `backgroundColor` property
    /// of the content's layer to the appearance's `backgroundColor`.
    /// - parameter content: The content co configure.
    func configure(_ content: ConfigurableCAContent) {
        content.layer.backgroundColor = self.backgroundColor?.color.cgColor
    }
}

#endif
