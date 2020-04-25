//
//  ConfigurableUIContent.swift
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

#if canImport(UIKit)

#if canImport(ContentKit)
import ContentKit

/// A Configurable `UIContent` by an `UIContentAppearance`.
public protocol ConfigurableUIContent: UIContent {
    /// Results in the receiver to be configured by the appearance.
    func configureContentAppearence(_ appearance: UIContentAppearance)
}

#else

/// A `UIContent` is `UIKit`'s visual content.
///
/// A `UIContent` is related to/provides access to a `UIView`.
public protocol UIContent {
    /// The related `UIView`.
    var view: UIView { get }
}

/// A Configurable `UIContent` by an `UIContentAppearance`.
public protocol ConfigurableUIContent: UIContent {
    /// The related `UIView`.
    var view: UIView { get }

    /// Results in the receiver to be configured by the appearance.
    func configureContentAppearence(_ appearance: UIContentAppearance)
}

#endif /* ContentKit */


public extension ConfigurableUIContent {
    
    /// Configures a `UIContentAppearance` with the given appearance.
    ///
    /// The default implementation asks the appearance to configure the receiver.
    /// - parameter appearance: The appearance to configure the receiver.
    func configureContentAppearence(_ appearance: UIContentAppearance) {
        appearance.configure(self)
    }
}

#endif /* UIKit */


#if !canImport(ContentKit)

extension UIView: UIContent {

    /// Conformance to `ConfigurableUIContent`.
    public var view: UIView {
        return self
    }
}

#endif /* ContentKit */
