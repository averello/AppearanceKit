//
//  Text.swift
//  ContentKit
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

import Foundation

#if canImport(RepresentationKit)
import RepresentationKit

/// Text is some Content.
public protocol Text: Content, Representable, LosslessStringConvertible, CustomPlaygroundDisplayConvertible {
    /// The content of the text.
    var content: String { get }
    /// A Boolean indicating wether the receiver is empty.
    var empty: Bool { get }
}
#else
/// Text is some Content.
public protocol Text: Content, LosslessStringConvertible, CustomPlaygroundDisplayConvertible {
    /// The content of the text.
    var content: String { get }
    /// A Boolean indicating wether the receiver is empty.
    var empty: Bool { get }
}
#endif

public extension Text {
    
    var description: String {
        return self.content
    }
    
    var empty: Bool { return self.content.isEmpty }
}

public extension Text {
    
    func debugQuickLookObject() -> AnyObject? {
        return self.content as NSString
    }
    
    var playgroundDescription: Any {
        return self.content
    }
}

public extension Text {
    
    var hashValue: Int {
        return self.content.hashValue
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.content.hashValue == rhs.content.hashValue) ||
            (lhs.content == rhs.content)
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return (lhs.content < rhs.content)
    }
}

extension String: Text {
    
    public init(content: Text) {
        self = content.content
    }
    
    public var content: String {
        return self
    }

    #if canImport(RepresentationKit)
    public func represent(using representation: Representation) -> Representation {
        return representation.with(key: TextKey(), value: self)
    }
    #endif
}
