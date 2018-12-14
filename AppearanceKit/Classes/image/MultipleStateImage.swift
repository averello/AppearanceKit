//
//  MultipleStateImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 24/01/2017.
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

#if canImport(ContentKit) && canImport(UIKit)
import ContentKit
import UIKit

/// A `MultipleStateImage` represents an image that can have multiple states.
/// The feasible states are: normal, highlighted, selected, disabled.
///
/// As an image may not have all of its states available the accessors return
/// optional values.
public protocol MultipleStateImage: ContentKit.Image {
    /// The normal state image.
    var normal: ContentKit.Image? { get }
    /// The highlighted state image.
    var highlighted: ContentKit.Image? { get }
    /// The selected state image.
    var selected: ContentKit.Image? { get }
    /// The disabled state image.
    var disabled: ContentKit.Image? { get }
    /// Always returns the backing `UIKit` original image.
    var original: UIImage? { get }

    /// Configures a button with the receiver for the given states.
    /// - parameter button: The button to set its image.
    /// - parameter states: The states to configure the button with.
    func configure(button: UIButton,
                   forStates states: [UIControl.State])

    /// Configures the background of a button with the receiver for the given
    /// states.
    /// - parameter button: The button to set its background image.
    /// - parameter states: The states to configure the button with.
    func configureBackground(button: UIButton,
                             forStates states: [UIControl.State])

    /// Returns the image corresponding the requested state, if any.
    /// - parameter state: The state.
    func image(fromState state: UIControl.State) -> ContentKit.Image?
}

public extension MultipleStateImage {
    
    public func configure(button: UIButton, forStates states: [UIControl.State]) {
        states.forEach { state in
            button.setImage(self.image(fromState: state)?.image,
                            for: state)
        }
    }
    
    public func configureBackground(button: UIButton, forStates states: [UIControl.State]) {
        states.forEach { state in
            button.setBackgroundImage(self.image(fromState: state)?.image,
                                      for: state)
        }
    }
    
    public func image(fromState state: UIControl.State) -> ContentKit.Image? {
        switch state {
        case UIControl.State.disabled:
            return self.disabled
        case UIControl.State.normal:
            return self
        case UIControl.State.highlighted:
            return self.highlighted
        case UIControl.State.selected:
            return self.selected
        default:
            return self.normal
        }
    }
}
#endif
