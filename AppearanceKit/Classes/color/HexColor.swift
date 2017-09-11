//
//  HexColor.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 15/05/2017.
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

public struct HexColor: Color, CustomStringConvertible {
    private let _color: UIColor
    private let _hex: String
    
    public var color: UIColor { return self._color }
    
    /// Takes hex in RGBA format (0xRRGGBBAA)
    public init?(hex: UInt32) {
        var string = String(hex, radix: 16)
        
        var count = string.characters.count
        guard count >= 3 && count <= 8 else { return nil }
        while count < 8 {
            string = "0" + string
            count = string.characters.count
        }
        self.init(hex: string)
    }
    
    /// Accepts strings in "0xRRGGBBAA" and "RRGGBBAA" format
    public init?(hex: String) {
        var _hex = hex
        if _hex.hasPrefix("0x") {
            _hex = hex.replacingOccurrences(of: "0x", with: "")
        }
        if _hex.hasPrefix("#") {
            _hex = hex.replacingOccurrences(of: "#", with: "")
        }
        let count = _hex.characters.count
        guard count >= 3 && count <= 8 else { return nil }
        guard let color = UIColor._color(fromHexString: _hex) else { return nil }
        
        self._color = color
        self._hex = _hex
    }
    
    public var description: String {
        return String(describing: type(of: self)) + "(0x\(self._hex))"
    }
}


fileprivate extension UIColor {
    
    fileprivate static func _color(fromHexString hex: String) -> UIColor? {
        guard hex.characters.count > 1 else { return nil }
        
        
        //Strip prefixed # hash
        var hexValue = hex
        if hex.hasPrefix("#") {
            hexValue = String(hex[hex.index(after: hex.startIndex)...])
        }
        
        //Determine if 3 or 6 digits
        var componentLength = 0
        var components = 3
        switch hexValue.characters.count {
        case 3:
            componentLength = 1
        case 6:
            componentLength = 2
            components = 3
        case 8:
            componentLength = 2
            components = 4
        default:
            return nil
        }
        
        var isValid = true
        var colorComponents: [Float] = []
        
        //Seperate the R,G,B values
        let start = hexValue.startIndex
        for i in 0..<components {
            
            let lower = hexValue.index(start, offsetBy: i * componentLength)
            let upper = hexValue.index(lower, offsetBy: componentLength)
            let range = Range(uncheckedBounds: (lower: lower, upper: upper))
            var component = String(hexValue[range])
            if componentLength == 1 {
                component.append(component)
            }
            guard let value = Int(component, radix: 16) else {
                isValid = false
                break
            }
            colorComponents.append(Float(value))
        }
        
        for component in colorComponents {
            assert(component >= 0 && component <= 0xFF)
        }
        
        colorComponents = colorComponents.map { $0 / 255.0 }
        
        if colorComponents.count != 4 {
            colorComponents.append(0xff)
        }
        
        guard isValid else { return nil }
        
        let cgFloatComponents = colorComponents.map { CGFloat($0) }
        return UIColor(red: cgFloatComponents[0],
                       green: cgFloatComponents[1],
                       blue: cgFloatComponents[2],
                       alpha: cgFloatComponents[3])
    }
}
