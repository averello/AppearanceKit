//
//  TypedArrayRepresentationBuilder.swift
//  RepresentationKit
//
//  Created by Georges Boumis on 20/08/2017.
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

final public class TypedArrayRepresentationBuilder<E>: TypedArrayRepresentation  {
    public typealias Element = E
    final private let _array: [Element]
    final public var array: [Element] {
        return self._array
    }
    
    public init() {
        self._array = []
    }
    
    private init(_ array: [Element]) {
        self._array = array
    }
    
    final public func with<Key,Value>(key: Key, value: Value) -> Representation where Key: LosslessStringConvertible & Hashable {
        var array: [Element] = self._array
        array.append(value as! Element)
        return TypedArrayRepresentationBuilder(array)
    }
}
