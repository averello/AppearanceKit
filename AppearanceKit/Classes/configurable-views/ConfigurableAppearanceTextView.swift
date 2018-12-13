//
//  ConfigurableAppearanceTextView.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 19/03/2018.
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

#if canImport(UIKit)
import UIKit

/// A text view that its appearance can be configured by a `UILabelAppearance`.
///
/// The default size of a `ConfigurableAppearanceTextView` is the same as its
/// `backgroundView` if a provided. Otherwise, is the minimum size that can
/// wrap the displayed text.
open class ConfigurableAppearanceTextView: UITextView, ConfigurableUIContent {

    /// An optional background view for the text view.
    ///
    /// The background view is always the first subviews of the receiver. Is
    /// always centered and has the same size as the receiver.
    public final var backgroundView: UIView? {
        didSet {
            if let backgroundView = self.backgroundView {
                if let oldBackgroundView = oldValue, oldBackgroundView !== backgroundView {
                    oldBackgroundView.removeFromSuperview()
                }
                self.insertSubview(backgroundView, at: 0)
            }
            else {
                if let oldBackgroundView = oldValue {
                    oldBackgroundView.removeFromSuperview()
                }
            }
            DispatchQueue.main.async {
                self.setNeedsLayout()
                self.sizeToFit()
            }
        }
    }
    private final var _requiredSubviews: [UIView] = []
    
    public init(frame: CGRect = CGRect.zero,
                textContainer: NSTextContainer? = nil,
                appearance: UILabelAppearance = DefaultUILabelAppearance()) {
        super.init(frame: frame, textContainer: textContainer)
        self.configureContentAppearence(appearance)
        self._loadSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    final private func _loadSubviews() {
        self._requiredSubviews = self.requiredSubviews()
        self._requiredSubviews.forEach { (subview: UIView) in
            self.addSubview(subview)
            subview.sizeToFit()
        }
        self.didLoadSubviews()
    }
    
    /// This load indicates that all `requiredSubviews` are loaded, inserted to
    /// the receiver's hierarchy and have a default size.
    open func didLoadSubviews() {

    }

    /// The required subviews of this class.
    ///
    /// The returned views are added to the receiver and `sizeToFit()` is
    /// called upon them to attribute their default size.
    open func requiredSubviews() -> [UIView] {
        return []
    }

    /// Reloads all required subviews by calling `requiredSubviews()` and
    /// `didLoadSubviews()` subsequently.
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
            let transform = bgView.transform
            bgView.transform = .identity
            var size = bgView.sizeThatFits(size)
            size = CGSize(width: size.width.rounded(.up), height: size.height.rounded(.up))
            bgView.transform = transform
            return size
        }
        return super.sizeThatFits(size)
    }
}
#endif
