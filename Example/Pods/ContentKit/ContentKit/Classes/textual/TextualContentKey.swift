//
//  TextKey.swift
//  ContentKit
//
//  Created by Georges Boumis on 16/05/2017.
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

import Foundation

// default textual content key

/// The key that is used by Text when is asked to be represented.
public struct TextKey: LosslessStringConvertible, Hashable {
    private let value: String = "content"
    
    public init() {}
        
    public func hash(into hasher: inout Hasher) {
        self.value.hash(into: &hasher)
    }
    
    // Equatable
    public static func == (_ lhs: TextKey, rhs: TextKey) -> Bool {
        return (lhs.value == rhs.value)
    }
    
    public static func != (_ lhs: TextKey, rhs: TextKey) -> Bool {
        return !(lhs == rhs)
    }
    
    public static func == (_ lhs: String, rhs: TextKey) -> Bool {
        return (lhs == rhs.value)
    }
    
    public static func == (_ lhs: TextKey, rhs: String) -> Bool {
        return (lhs.value == rhs)
    }
    
    // LosslessStringConvertible
    public init?(_ description: String) {}
    // CustomStringConvertible
    public var description: String { return self.value }
}
