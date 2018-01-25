//
//  ConfigurableAppearanceControl.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 24/10/2016.
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

open class ConfigurableAppearanceControl: UIControl, ConfigurableUIContent {
    public final var backgroundView: UIView? {
        didSet {
            if let backgroundView = self.backgroundView {
                self.insertSubview(backgroundView, at: 0)
            }
            if let oldBackgroundView = oldValue {
                oldBackgroundView.removeFromSuperview()
            }
            DispatchQueue.main.async {
                self.setNeedsLayout()
                self.sizeToFit()
            }
        }
    }
    private final var _requiredSubviews: [UIView] = []

    public init(frame: CGRect = CGRect.zero, appearance: UIContentAppearance = DefaultUIContentAppearance()) {
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


    open override func layoutSubviews() {
        super.layoutSubviews()

        if let bgView = self.backgroundView {
            if bgView.superview == nil {
                self.insertSubview(bgView, at: 0)
            }
            var frame = bgView.frame
            frame.size = self.bounds.size
            bgView.frame  = frame
            bgView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        }
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        if let bgView = self.backgroundView {
            let size = bgView.sizeThatFits(size)
            return CGSize(width: size.width.rounded(.up), height: size.height.rounded(.up))
        }
        return super.sizeThatFits(size)
    }
    
    final public override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if self.isHidden { return }
        if self.isUserInteractionEnabled == false { return }
        if self.alpha <= 0 { return }
        super.sendAction(action, to: target, for: event)
    }
}
