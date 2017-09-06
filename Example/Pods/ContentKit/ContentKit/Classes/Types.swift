//
//  Types.swift
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

public struct Size {
    public let width: Float
    public let height: Float
    
    public init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }
    
    public init(size: CGSize) {
        self.init(width: Float(size.width), height: Float(size.height))
    }
}

public extension Size {
    
    public var asCGSize: CGSize {
        return CGSize(size: self)
    }
}

public extension CGSize {
    public init(size: Size) {
        self.init(width: CGFloat(size.width), height: CGFloat(size.height))
    }
}
