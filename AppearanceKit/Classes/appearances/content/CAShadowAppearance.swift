//
//  CAShadowAppearance.swift
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

/// A Core Animation shadow appearance.
public protocol CAShadowAppearance: CAContentAppearance {
    /// The color of the shadow.
    var color: Color? { get }
    /// The blur radius (in points) of the shadow.
    var radius: Float? { get }
    /// The opacity of the shadow.
    var opacity: Float? { get }
    /// The offset (in points) of the shadow.
    var offset: Offset? { get }
    
    /// The shape of the shadow.
    var path: CGPath? { get }
}

public extension CAShadowAppearance {
    
    /// Configures a `ConfigurableCAContent` with the receiver.
    /// - parameter content: The `ConfigurableCAContent` to configure.
    func configure(_ content: ConfigurableCAContent) {
        if let aLayer = content as? CALayer {
            self.configure(aLayer)
            return
        }
    }
    
    /// Configures any `CALayer` with the receiver.
    /// - parameter content: The `CALayer` to configure.
    func configure<L>(_ content: L) where L: CALayer {
        let aContent = content
        
        if let color = self.backgroundColor?.color.cgColor {
            aContent.backgroundColor = color
        }
        
        if let color = self.color?.color.cgColor {
            aContent.shadowColor = color
        }
        
        if let opacity = self.opacity {
            aContent.shadowOpacity = opacity
        }
        if let offset = self.offset?.asUIOffset {
            aContent.shadowOffset = CGSize(width: offset.horizontal, height: offset.vertical)
        }
        if let radius = self.radius {
            aContent.shadowRadius = CGFloat(radius)
        }
        
        if let path = self.path {
            aContent.shadowPath = path
        }
        
    }
}

#endif

