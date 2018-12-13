//
//  DataFromJSONRepresentation.swift
//  RepresentationKit
//
//  Created by Georges Boumis on 19/11/2018.
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

public struct DataFromJSONRepresentation: DataRepresentation  {
    public var data: Data {
        return self.json.jsonData!
    }
    private let json: JSONRepresentationBuilder

    public func with<Key, Value>(key: Key, value: Value) -> Representation where Key : Hashable, Key : LosslessStringConvertible {
        return DataFromJSONRepresentation(builder: self.json.with(key: key, value: value))
    }

    public init() {
        self.init(builder: JSONRepresentationBuilder())
    }

    private init(builder: JSONRepresentationBuilder) {
        self.json = builder
    }
}
