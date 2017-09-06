//
//  ConfigurableAppearanceLabel.swift
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
import Ents

open class ConfigurableAppearanceLabel: UILabel, ConfigurableUIContent {
    public final var backgroundView: UIView?
    private final var _requiredSubviews: [UIView] = []
    
    public init(frame: CGRect = CGRect.zero, appearance: UILabelAppearance = DefaultUILabelAppearance()) {
        super.init(frame: frame)
        self.configureContentAppearence(appearance)
        self._loadSubviews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    final private func _loadSubviews() {
        self._requiredSubviews = self.requiredSubviews()
        self._requiredSubviews.forEach {
            self.addSubview($0.1)
            $0.1.sizeToFit()
        }
        self.didLoadSubviews()
    }
    
    open func didLoadSubviews() {
        
    }
    
    open func requiredSubviews() -> [UIView] {
        return []
    }
    
    final public func setNeedsUpdateSubviews() {
        self._requiredSubviews.forEach { _,subview in
            subview.removeFromSuperview()
        }
        self._loadSubviews()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        if let bgView = self.backgroundView {
            if bgView.superview == nil {
                self.insertSubview(bgView, at: 0)
            }
            bgView.frameSize = self.boundsSize
            bgView.center    = self.ownCenter
        }
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        if let bgView = self.backgroundView {
            let transform = bgView.transform
            bgView.transform = .identity
            let size = bgView.sizeThatFits(size).ceiled
            bgView.transform = transform
            return size
        }
        return super.sizeThatFits(size)
    }
}
