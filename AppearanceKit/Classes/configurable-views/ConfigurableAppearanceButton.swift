//
//  ConfigurableAppearanceButton.swift
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

import UIKit

open class ConfigurableAppearanceButton: UIButton, ConfigurableUIContent {
    private final var _requiredSubviews: [UIView] = []
    
    public init(frame: CGRect = CGRect.zero, appearance: UIButtonAppearance = DefaultUIButtonAppearance()) {
        super.init(frame: frame)
        self.configureContentAppearence(appearance)
        self._loadSubviews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._loadSubviews()
    }
    
    final private func _loadSubviews() {
        self._requiredSubviews = self.requiredSubviews()
        self._requiredSubviews.forEach {
            self.addSubview($0)
            $0.sizeToFit()
        }
        self.didLoadSubviews()
    }
    
    open func didLoadSubviews() {
        
    }
    
    open func requiredSubviews() -> [UIView] {
        return []
    }
    
    final public func setNeedsUpdateSubviews() {
        self._requiredSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
        self._loadSubviews()
    }
    
    final override public func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if self.isHidden { return }
        if self.isUserInteractionEnabled == false { return }
        if self.alpha <= 0 { return }
        super.sendAction(action, to: target, for: event)
    }

}
