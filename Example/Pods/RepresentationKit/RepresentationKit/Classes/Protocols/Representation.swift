//
//  JSONTransformation.swift
//  RepresentationKit
//
//  Created by Georges Boumis on 10/06/2016.
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

/// This protocol describes possible representation of objects.
/// The sole requirement of a `Representation` is to return a new `Representation`,
/// probably enriched, with a given (key,value) pair.
///
/// How each `Representation` represents the given data is an implementation 
/// detail.
public protocol Representation {
    
    /// Returns a `Representation` probably enriched, with the given (key,value) pair.
    /// - Parameters:
    ///   - key: a key to identify the value
    ///   - value: a value
    func with<Key,Value>(key: Key, value: Value) -> Representation where Key: LosslessStringConvertible & Hashable
}

public extension Representation {
    
    /// Returns a `Representation` probably enriched, with the given (key,value) 
    /// pair. This is a strongly typed alternative
    ///
    /// - Parameters:
    ///   - key: a key to identify the value
    ///   - value: a value
    public func with<Key,Value,Rep>(key: Key, value: Value) -> Rep
        where Key: LosslessStringConvertible & Hashable, Rep: Representation {
        return self.with(key: key, value: value) as! Rep
    }
    
    /// Returns a `Representation` probably enriched, with the given (key,value) 
    /// pair, only if the `validate` closure evaluates to a non-optional value.
    /// - Parameters:
    ///   - key: a key to identify the value
    ///   - value: a value
    ///   - validate: a closure that takes the value and returns the value if 
    ///     to validate or `nil` to invalidate. - parameter: a
    public func potentiallyWith<Key, Value, Validated>(key: Key, value: Value, _ validate: (Value) -> Validated?) -> Representation where Key: LosslessStringConvertible & Hashable {
        guard let v = validate(value) else { return self }
        return self.with(key: key, value: v)
    }
}


