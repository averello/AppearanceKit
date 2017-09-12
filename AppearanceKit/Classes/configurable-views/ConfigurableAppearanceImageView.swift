//
//  ConfigurableAppearanceImageView.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 11/05/2017.
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

open class ConfigurableAppearanceImageView: UIImageView, ConfigurableUIContent {
    private final var _requiredSubviews: [UIView] = []
    
    public var img: Image {
        get { return AnyImage(image: self.image!) }
        set { self.image = newValue.image }
    }
    
    public init(image: Image,
                appearance: UIContentAppearance = DefaultUIContentAppearance()) {
        super.init(image: image.image)
        self.configureContentAppearence(appearance)
        self._loadSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    final private func _loadSubviews() {
        self._requiredSubviews = self.requiredSubviews()
        self._requiredSubviews.forEach {
            self.addSubview($0)
            $0.sizeToFit()
        }
        self.didLoadSubviews()
    }
    
    open func requiredSubviews() -> [UIView] {
        return []
    }
    
    open func didLoadSubviews() {
        
    }
    
    final public func setNeedsUpdateSubviews() {
        self._requiredSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
        self._loadSubviews()
    }
}
