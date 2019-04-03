//
//  Color.swift
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


#if canImport(UIKit) && canImport(QuartzCore)
import UIKit
import QuartzCore

/// A Color.
public protocol Color: CustomPlaygroundDisplayConvertible {
    /// The backing `UIKit` color.
    var color: UIColor { get }
    
    /// returns the "same" color with the specified alpha.
    /// - parameter alpha: A Normalized value describing the alpha component of
    /// the color.
    func with(alpha: Float) -> Color
}

extension UIColor: Color {
    
    /// Conformance to `Color`.
    public var color: UIColor {
        return self
    }
}

extension Color {
    
    public var playgroundDescription: Any {
        return self.color
    }
    
    public func debugQuickLookObject() -> AnyObject? {
        return self.color
    }
    
    public func with(alpha: Float) -> Color {
        return AnyColor(color: self.color.withAlphaComponent(CGFloat(alpha)))
    }
}
#endif
