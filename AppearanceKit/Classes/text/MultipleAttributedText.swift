//
//  MultipleAttributedText.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 01/06/2017.
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
import ContentKit

public struct MultipleAttributedText: Text {
    fileprivate var texts: [AttributedText]
    
    public init(texts: [Text]) {
        self.texts = texts.flatMap { t -> [AttributedText] in
            if let att = t as? AttributedText {
                return [att]
            }
            else if let multAtt = t as? MultipleAttributedText {
                return multAtt.texts
            }
            else {
                return [AttributedText(t)]
            }
        }
    }
    
    public init?(_ description: String) {
        self.init(texts: [description])
    }

    public var content: String {
        return self.texts.reduce("") { result,current in
            return result + current.content
        }
    }
}

public extension MultipleAttributedText {
    
    public var attributedTexts: [AttributedText] {
        return self.texts
    }
    
    public var attributedString: NSAttributedString {
        return { () -> NSAttributedString in
            let string = NSMutableAttributedString()
            for text in self.texts {
                string.append(text.attributedString)
            }
            return string.copy() as! NSAttributedString
            }()
    }
}

public extension MultipleAttributedText {
    
    public mutating func append(_ attributedText: AttributedText) {
        self.texts.append(attributedText)
    }
    
    public mutating func append(_ attributedText: MultipleAttributedText) {
        self.texts.append(contentsOf: attributedText.texts)
    }
    
    public mutating func append(_ attributedText: Text) {
        if let attr = attributedText as? AttributedText {
            self.append(attr)
        }
        else if let multAttr = attributedText as? MultipleAttributedText {
            self.append(multAttr)
        }
        else {
            self.texts.append(AttributedText(attributedText))
        }
    }
}

extension MultipleAttributedText: Hashable {
    
    public var hashValue: Int {
        return self.attributedString.hashValue
    }
}

extension MultipleAttributedText: Equatable {
    
    public static func ==(lhs: MultipleAttributedText, rhs: MultipleAttributedText)  -> Bool {
        return (lhs.texts == rhs.texts)
    }
}

extension MultipleAttributedText: CustomStringConvertible {}
extension MultipleAttributedText: LosslessStringConvertible {}

extension MultipleAttributedText: Comparable {}


public extension AttributedText {
    
    public static func +(lhs: AttributedText, rhs: AttributedText) -> MultipleAttributedText {
        return MultipleAttributedText(texts: [lhs, rhs])
    }

//    public static func +(lhs: AttributedText, rhs: String) -> MultipleAttributedText {
//        return MultipleAttributedText(texts: [lhs, rhs])
//    }
//    
//    public static func +(lhs: String, rhs: AttributedText) -> MultipleAttributedText {
//        return MultipleAttributedText(texts: [lhs, rhs])
//    }
}

public extension MultipleAttributedText {
    
    public static func +(lhs: MultipleAttributedText, rhs: MultipleAttributedText) -> MultipleAttributedText {
        return MultipleAttributedText(texts: [lhs, rhs])
    }
//
//    public static func +(lhs: MultipleAttributedText, rhs: String) -> MultipleAttributedText {
//        return MultipleAttributedText(texts: [lhs, rhs])
//    }
//    
//    public static func +(lhs: String, rhs: MultipleAttributedText) -> MultipleAttributedText {
//        return MultipleAttributedText(texts: [lhs, rhs])
//    }
//    
//    public static func +(lhs: AttributedText, rhs: MultipleAttributedText) -> MultipleAttributedText {
//        return MultipleAttributedText(texts: [lhs, rhs])
//    }
//    
//    public static func +(lhs: MultipleAttributedText, rhs: AttributedText) -> MultipleAttributedText {
//        return MultipleAttributedText(texts: [lhs, rhs])
//    }
}

public extension MultipleAttributedText {
    
    public func configure(label: UILabel) {
        label.attributedText = self.attributedString
    }
    
    public func configure(button: UIButton) {
        self.configure(button: button, forStates: [UIControl.State.normal])
    }
    
    public func configure(button: UIButton, forStates states: [UIControl.State]) {
        let attributedString = self.attributedString
        for state in states {
            button.setAttributedTitle(attributedString, for: state)
        }
    }
}
