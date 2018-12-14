//
//  TextRepresentation.swift
//  ContentKit
//
//  Created by Georges Boumis on 28/06/2016.
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

/// A Text representation is a Text & a Representation.
public protocol TextRepresentation: Representation, Text {}

public extension DictionaryRepresentation {

    /// Returns a Textual Representation.
    public var textualRepresentation: TextRepresentation {
        return self.represent(using: TextRepresentationBuilder()) as! TextRepresentation
    }
}
#endif
