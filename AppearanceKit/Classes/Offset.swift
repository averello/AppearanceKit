//
//  Offset.swift
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

/// An offset on the two dimensional plane.
public struct Offset {
    /// The horizontal offset
    public let horizontal: Float
    /// The vertical offset
    public let vertical: Float
    
    public init(horizontal: Float, vertical: Float) {
        self.horizontal = horizontal
        self.vertical = vertical
    }

    /// The zero offset.
    public static let zero: Offset = Offset(horizontal: 0, vertical: 0)
}

#if canImport(UIKit)
import UIKit

// MARK: - Convert from and to UIOffset

public extension Offset {
    
    init(offset: UIOffset) {
        self.init(horizontal: Float(offset.horizontal), vertical: Float(offset.vertical))
    }
}


#if canImport(CoreGraphics)
import CoreGraphics

public extension Offset {
    var asUIOffset: UIOffset {
        return UIOffset(offset: self)
    }
}

public extension UIOffset {
    
    init(offset: Offset) {
        self.init(horizontal: CGFloat(offset.horizontal),
                  vertical: CGFloat(offset.vertical))
    }
}
#endif /* CoreGraphics */

#endif /* UIKit */
