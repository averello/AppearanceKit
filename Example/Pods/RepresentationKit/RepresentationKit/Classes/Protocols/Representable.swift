//
//  Representable.swift
//  RepresentationKit
//
//  Created by Georges Boumis on 20/6/2016.
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

/// This protocol describes the requirements for an object to be `Representable`.
/// The sole requirement of a `Representable` is to fill the `Representation`
/// given with key-value pairs that describe the object.
///
public protocol Representable {
    
    /// Returns a `Representation` enriched with the key-value pairs describing
    /// this instance.
    /// - Parameter representation: the representation to fill
	func represent(using representation: Representation) -> Representation
}

public extension Representable {
    
    /// Returns a `Representation` enriched with the key-value pairs describing
    /// this instance.
    /// This is a strongly typed alternative
    /// - Parameter representation: the representation to fill
    public func represent<Rep>(using representation: Rep) -> Rep where Rep: Representation {
        return self.represent(using: representation) as! Rep
    }

    /// Default empty representation. This default implementation does nothing.
    /// - Parameter representation: the representation to fill
	public func represent(using representation: Representation) -> Representation {
		return representation
	}
}

public extension CustomStringConvertible where Self : Representable {
    
    public func represent(using representation: Representation) -> Representation {
        return representation.with(key: "description", value: self.description)
    }
}
