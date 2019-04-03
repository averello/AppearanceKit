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

#if canImport(ContentKit)
import ContentKit

/// A text that is composed of multiple `AttributedText`. Thus, creating a Text
/// that has mixed attributes.
public struct MultipleAttributedText: Text {
    fileprivate var texts: [AttributedText]
    
    /// Creates a `MultipleAttributedText` with the given texts.
    /// - parameter texts: The texts from which the receiver will be composed of.
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
    
    /// The `AttributedText` the receiver is composed of.
    var attributedTexts: [AttributedText] {
        return self.texts
    }
    
    /// Gets an `NSAttributedString` from the receiver.
    var attributedString: NSAttributedString {
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
    
    /// Append an attributed text to the receiver.
    /// - parameter attributedText: The text append.
    mutating func append(_ attributedText: AttributedText) {
        self.texts.append(attributedText)
    }
    
    /// Append another multiple attributed text to the receiver.
    /// - parameter attributedText: The multiple attributed text append.
    mutating func append(_ attributedText: MultipleAttributedText) {
        self.texts.append(contentsOf: attributedText.texts)
    }
    
    /// Append any Text to the receiver.
    /// - parameter attributedText: The text to append. If it is not a
    /// `AtributedText` or `MultipleAttributedText` then default attributes will
    /// be used.
    mutating func append(_ attributedText: Text) {
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
    
    public func hash(into hasher: inout Hasher) {
        self.attributedString.hash(into: &hasher)
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
    
    static func +(lhs: AttributedText, rhs: AttributedText) -> MultipleAttributedText {
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
    
    static func +(lhs: MultipleAttributedText, rhs: MultipleAttributedText) -> MultipleAttributedText {
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
    
    /// Makes a `UILabel` display the receiver.
    /// - parameter label: The `UILabel` to display the receiver.
    func configure(label: UILabel) {
        label.attributedText = self.attributedString
    }
    
    /// Makes a `UIButton` display the receiver.
    /// - parameter button: The `UIButton` to display the receiver.
    func configure(button: UIButton) {
        self.configure(button: button, forStates: [UIControl.State.normal])
    }
    
    /// Makes a `UIButton` display the receiver for the given states.
    /// - parameter button: The `Button` to display the receiver.
    /// - parameter states: The state to configure.
    func configure(button: UIButton,
                   forStates states: [UIControl.State]) {
        let attributedString = self.attributedString
        for state in states {
            button.setAttributedTitle(attributedString, for: state)
        }
    }
}
#endif
