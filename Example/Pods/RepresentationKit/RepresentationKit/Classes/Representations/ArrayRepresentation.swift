//
//  ArrayRepresentation.swift
//  RepresentationKit
//
//  Created by Georges Boumis on 07/10/2016.
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

/// Describes an array representation. Also the conforming class can be
/// represented itself.
///
///     struct Book: Representable {
///       let name: String
///       let edition: String
///
///       func represent(using representation: Representation) -> Representation {
///           return representation
///               .with(key: "name", value: self.name)
///               .with(key: "edition", value: self.edition)
///       }
///     }
///
///     let book = Book(name: "Super title", edition: "Pepper's")
///
///     var representation: ArrayRepresentation = /* */
///     representation = book.represent(using: representation)
///
///     print(representation.array)
///     // Prints ["Super title", "Pepper's"]
///
/// - SeeAlso: `TypedArrayRepresentation`
public protocol ArrayRepresentation: Representation, Representable {
    
    /// the array of the represented values.
    var array: [Any] { get }
}

public extension ArrayRepresentation {
    
    public func represent<Rep>(using representation: Rep) -> Rep where Rep: Representation {
        var r = representation
        
        for (index,element) in self.array.enumerated() {
            r = r.with(key: "\(index)", value: element) as! Rep
        }
        return r
    }
}
