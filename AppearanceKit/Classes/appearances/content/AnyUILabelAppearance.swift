//
//  AnyUILabelAppearance.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 29/06/2017.
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

public struct AnyUILabelAppearance: UILabelAppearance {
    private let appearance: UILabelAppearance
    
    public init(appearance: UILabelAppearance) {
        self.appearance = appearance
    }
    
    public var font: Font? { return self.appearance.font }
    public var textColor: TextColor? { return self.appearance.textColor }
    public var shadowColor: Color? { return self.appearance.shadowColor }
    public var shadowOffset: AppearanceKit.Size? { return self.appearance.shadowOffset }
    public var numberOfLines: Int? { return self.appearance.numberOfLines }
    public var adjustsFontSizeToFitWidth: Bool? { return self.appearance.adjustsFontSizeToFitWidth }
    public var minimumScaleFactor: Float? { return self.appearance.minimumScaleFactor }
    public var alignement: NSTextAlignment? { return self.appearance.alignement }
    
    public var backgroundColor: Color? { return self.appearance.backgroundColor }
    public var tintColor: Color? { return self.appearance.tintColor }
}
