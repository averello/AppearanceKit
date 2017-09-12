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
import ContentKit

public protocol MultipleStateImage: Image {
    var normal: Image? { get }
    var highlighted: Image? { get }
    var selected: Image? { get }
    var disabled: Image? { get }
    var original: UIImage? { get }

    func configure(button: UIButton,
                   forStates states: [UIControlState])

    func configureBackground(button: UIButton,
                             forStates states: [UIControlState])
    
    func image(fromState state: UIControlState) -> UIImage?
}

public extension MultipleStateImage {
    
    public func configure(button: UIButton, forStates states: [UIControlState]) {
        states.forEach { state in
            button.setImage(self.image(fromState: state), for: state)
        }
    }
    
    public func configureBackground(button: UIButton, forStates states: [UIControlState]) {
        states.forEach { state in
            button.setBackgroundImage(self.image(fromState: state), for: state)
        }
    }
    
    public func image(fromState state: UIControlState) -> UIImage? {
        switch state {
        case UIControlState.disabled:
            return self.disabled?.image
        case UIControlState.normal:
            return self.image
        case UIControlState.highlighted:
            return self.highlighted?.image
        case UIControlState.selected:
            return self.selected?.image
        default:
            return self.normal?.image
        }
    }
}
