//
//  ConfigurableCAContent.swift
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
import ContentKit

#if canImport(QuartzCore)
import QuartzCore

/// A Core Animation Content.
///
/// A Core Animation Content is related to/provides access to a `CALayer`.
public protocol CAContent: VisualContent {
    /// The related `CALayer`.
    var layer: CALayer { get }
}

public extension CALayer {

    /// Conformance to `CAContent`.
    public var layer: CALayer {
        return self
    }
}

/// A `CAContent` that can be configured by a `CAContentAppearance`.
public protocol ConfigurableCAContent: CAContent {
    /// Results in the receiver to be configured by the appearance.
    func configureContentAppearence(_ appearance: CAContentAppearance)
}

public extension ConfigurableCAContent {

    /// Configures a `ConfigurableCAContent` with the given appearance.
    ///
    /// The default implementation ask the appearance to configure the receiver.
    /// - parameter appearance: The appearance to configure the receiver.
    public func configureContentAppearence(_ appearance: CAContentAppearance) {
        appearance.configure(self)
    }
}

#endif
