//
//  Types.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 15/05/2018.
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

public typealias Degrees = Float
public typealias Radians = Float

internal extension Degrees {

    internal var asRadians: Radians {
        return Radians((self / 180) * Degrees.pi)
    }
}

internal extension Radians {

    internal var asDegrees: Degrees {
        return Degrees((self * 180) / Radians.pi)
    }
}
