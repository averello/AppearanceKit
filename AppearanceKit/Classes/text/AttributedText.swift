//
//  AttributedText.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 29/05/2017.
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
import Ents

//TODO
//public protocol _AttributedText: Text {
//    init(_ text: Text)
//    var attributedString: NSAttributedString { get }
//}

// CVarArg
// TextOutpuStream
// TextOutputStreamable

public struct AttributedText: Text {
    public fileprivate(set) var content: String
    fileprivate var _attributes: [String: Attribute]
    
    public var attributes: [Attribute] {
        get { return Array(self._attributes.values) }
    }
}

extension AttributedText {
    
    ///MARK: Initializers
    public init(_ content: String) {
        self.init(content, attributes: [])
    }
    
    public init(_ text: Text, attributes: [Attribute] = []) {
        self.content = text.content
        let attrs = Dictionary<String, Attribute>(attributes.map { ($0.key.rawValue, $0) })
        self._attributes = attrs
    }
    
    
    public init(_ string: NSAttributedString) {
        self.content = string.string
        let attrs = Dictionary<String, Attribute>(string.attributes(at: 0, effectiveRange: nil).flatMap { key,value -> (String,Attribute)? in
            guard let attribute = AttributedText.Attribute(string: string, attribute: key.rawValue, value: value) else { return nil }
            return (key.rawValue, attribute)
        })
        self._attributes = attrs
    }
}

extension AttributedText {

    ///MARK: manipulators
    
    public mutating func set(attribute: Attribute) {
        self._attributes[attribute.key.rawValue] = attribute
    }
    
    public var attributedString: NSAttributedString {
        return { () -> NSAttributedString in
            let string = NSMutableAttributedString(string: self.content)
            let range = NSMakeRange(0, (string.string as NSString).length)
            for attribute in self._attributes {
                let atts = [NSAttributedStringKey(rawValue: attribute.key): attribute.value.value(withText: string)]
                string.addAttributes(atts, range: range)
            }
            return string.copy() as! NSAttributedString
        }()
    }
}

///MARK: Types
extension AttributedText {
    
    public enum Alignment {
        case left
        case center
        case right
        case justified
        case natural
        
        public init(textAlignment: NSTextAlignment) {
            self = { () -> Alignment in
                switch textAlignment {
                case NSTextAlignment.left:
                    return AttributedText.Alignment.left
                case NSTextAlignment.center:
                    return AttributedText.Alignment.center
                case NSTextAlignment.right:
                    return AttributedText.Alignment.right
                case NSTextAlignment.justified:
                    return AttributedText.Alignment.justified
                case NSTextAlignment.natural:
                    return AttributedText.Alignment.natural
                }
            }()
        }
    }
    
    public enum Attribute {
        case font(Font)
        case color(Color)
        case backgroundColor(Color)
        case strokeColor(Color)
        case strokeWidth(Float)
        case shadow(AttributedText.Shadow)
        case style(AttributedText.ParagraphStyle)
    }
    
    public struct Shadow {
        public let offset: AttributedText.Shadow.Offset
        public let radius: Float
        public let color: Color
        
        
        public init(offset: AttributedText.Shadow.Offset,
                    radius: Float = 0,
                    color: Color = BlackColor().with(alpha: 0.333)) {
            self.offset = offset
            self.radius = radius
            self.color = color
        }
        
        public init(offset: (x: Float, y: Float),
                    radius: Float = 0,
                    color: Color = BlackColor().with(alpha: 0.333)) {
            self.init(offset: AttributedText.Shadow.Offset(x: offset.x, y: offset.y),
                      radius: radius,
                      color: color)
        }
        
        public init(shadow: NSShadow) {
            self.offset = AttributedText.Shadow.Offset(size: shadow.shadowOffset)
            self.radius = Float(shadow.shadowBlurRadius)
            if let color = shadow.shadowColor as? UIColor {
                self.color = AnyColor(color: color)
            }
            else {
                self.color = BlackColor().with(alpha: 0.333)
            }
            
        }
    }
    
    public struct ParagraphStyle {
        public enum LineBreakMode {
            case byWordWrapping // Wrap at word boundaries, default
            case byCharWrapping // Wrap at character boundaries
            case byClipping // Simply clip
            case byTruncatingHead // Truncate at head of line: "...wxyz"
            case byTruncatingTail // Truncate at tail of line: "abcd..."
            case byTruncatingMiddle // Truncate middle of line:  "ab...yz"
            
            public init(_ mode: NSLineBreakMode) {
                self = { () -> ParagraphStyle.LineBreakMode in
                    switch mode {
                    case NSLineBreakMode.byWordWrapping:
                        return ParagraphStyle.LineBreakMode.byWordWrapping
                    case NSLineBreakMode.byCharWrapping:
                        return ParagraphStyle.LineBreakMode.byCharWrapping
                    case NSLineBreakMode.byClipping:
                        return ParagraphStyle.LineBreakMode.byClipping
                    case NSLineBreakMode.byTruncatingHead:
                        return ParagraphStyle.LineBreakMode.byTruncatingHead
                    case NSLineBreakMode.byTruncatingTail:
                        return ParagraphStyle.LineBreakMode.byTruncatingTail
                    case NSLineBreakMode.byTruncatingMiddle:
                        return ParagraphStyle.LineBreakMode.byTruncatingMiddle
                    }
                }()
            }
            fileprivate var lineBreakMode: NSLineBreakMode {
                switch self {
                case ParagraphStyle.LineBreakMode.byWordWrapping:
                    return NSLineBreakMode.byWordWrapping
                    
                case ParagraphStyle.LineBreakMode.byCharWrapping:
                    return NSLineBreakMode.byCharWrapping
                    
                case ParagraphStyle.LineBreakMode.byClipping:
                    return NSLineBreakMode.byClipping
                    
                case ParagraphStyle.LineBreakMode.byTruncatingHead:
                    return NSLineBreakMode.byTruncatingHead
                    
                case ParagraphStyle.LineBreakMode.byTruncatingTail:
                    return NSLineBreakMode.byTruncatingTail
                    
                case ParagraphStyle.LineBreakMode.byTruncatingMiddle:
                    return NSLineBreakMode.byTruncatingMiddle
                }
            }
        }
        public enum WritingDirection{
            case natural // Determines direction using the Unicode Bidi Algorithm rules P2 and P3
            case leftToRight // Left to right writing direction
            case rightToLeft // Right to left writing direction
            
            public init(_ direction: NSWritingDirection) {
                self = { () -> WritingDirection in
                    switch direction {
                    case NSWritingDirection.natural:
                        return WritingDirection.natural
                    case NSWritingDirection.leftToRight:
                        return WritingDirection.leftToRight
                    case NSWritingDirection.rightToLeft:
                        return WritingDirection.rightToLeft
                    }
                }()
            }
            
            fileprivate var writingDirection: NSWritingDirection {
                switch self {
                case WritingDirection.natural:
                    return NSWritingDirection.natural
                case WritingDirection.leftToRight:
                    return NSWritingDirection.leftToRight
                case WritingDirection.rightToLeft:
                    return NSWritingDirection.rightToLeft
                }
            }
        }
        
        public var lineSpacing: Float
        public var paragraphSpacing: Float
        public var alignment: Alignment
        public var firstLineHeadIndent: Float
        public var headIndent: Float
        public var tailIndent: Float
        public var lineBreakMode: LineBreakMode
        public var minimumLineHeight: Float
        public var maximumLineHeight: Float
        public var baseWritingDirection: WritingDirection
        public var lineHeightMultiple: Float
        public var paragraphSpacingBefore: Float
        public var hyphenationFactor: Float
        
        public init() {
            self.init(style: NSParagraphStyle.default)
        }
        
        public init(lineSpacing: Float,
                    paragraphSpacing: Float,
                    alignment: Alignment,
                    firstLineHeadIndent: Float,
                    headIndent: Float,
                    tailIndent: Float,
                    lineBreakMode: LineBreakMode,
                    minimumLineHeight: Float,
                    maximumLineHeight: Float,
                    baseWritingDirection: WritingDirection,
                    lineHeightMultiple: Float,
                    paragraphSpacingBefore: Float,
                    hyphenationFactor: Float) {
            self.lineSpacing            = lineSpacing
            self.paragraphSpacing       = paragraphSpacing
            self.alignment              = alignment
            self.firstLineHeadIndent    = firstLineHeadIndent
            self.headIndent             = headIndent
            self.tailIndent             = tailIndent
            self.lineBreakMode          = lineBreakMode
            self.minimumLineHeight      = minimumLineHeight
            self.maximumLineHeight      = maximumLineHeight
            self.baseWritingDirection   = baseWritingDirection
            self.lineHeightMultiple     = lineHeightMultiple
            self.paragraphSpacingBefore = paragraphSpacingBefore
            self.hyphenationFactor      = hyphenationFactor
        }
        
        public init(style: NSParagraphStyle) {
            self.lineSpacing            = Float(style.lineSpacing)
            self.paragraphSpacing       = Float(style.paragraphSpacing)
            self.alignment              = AttributedText.Alignment(textAlignment: style.alignment)
            self.firstLineHeadIndent    = Float(style.firstLineHeadIndent)
            self.headIndent             = Float(style.headIndent)
            self.tailIndent             = Float(style.tailIndent)
            self.lineBreakMode          = LineBreakMode(style.lineBreakMode)
            self.minimumLineHeight      = Float(style.minimumLineHeight)
            self.maximumLineHeight      = Float(style.maximumLineHeight)
            self.baseWritingDirection   = WritingDirection(style.baseWritingDirection)
            self.lineHeightMultiple     = Float(style.lineHeightMultiple)
            self.paragraphSpacingBefore = Float(style.paragraphSpacingBefore)
            self.hyphenationFactor      = style.hyphenationFactor
        }
        
        fileprivate var style: NSParagraphStyle {
            let style = NSMutableParagraphStyle()
            style.lineSpacing            = CGFloat(self.lineSpacing)
            style.paragraphSpacing       = CGFloat(self.paragraphSpacing)
            style.alignment              = self.alignment.textAlignment
            style.firstLineHeadIndent    = CGFloat(self.firstLineHeadIndent)
            style.headIndent             = CGFloat(self.headIndent)
            style.tailIndent             = CGFloat(self.tailIndent)
            style.lineBreakMode          = self.lineBreakMode.lineBreakMode
            style.minimumLineHeight      = CGFloat(self.minimumLineHeight)
            style.maximumLineHeight      = CGFloat(self.maximumLineHeight)
            style.baseWritingDirection   = self.baseWritingDirection.writingDirection
            style.lineHeightMultiple     = CGFloat(self.lineHeightMultiple)
            style.paragraphSpacingBefore = CGFloat(self.paragraphSpacingBefore)
            style.hyphenationFactor      = self.hyphenationFactor
            return style.copy() as! NSParagraphStyle
        }
    }
}

extension AttributedText.Shadow {
    
    public struct Offset {
        public let x: Float
        public let y: Float
        
        public init(x: Float, y: Float) {
            self.x = x
            self.y = y
        }
    }
    
    fileprivate var shadow: NSShadow {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(offset: self.offset)
        shadow.shadowColor = self.color.color
        shadow.shadowBlurRadius = CGFloat(self.radius)
        return shadow
    }
}

fileprivate extension AttributedText.Alignment {
    
    var textAlignment: NSTextAlignment {
        switch self {
        case AttributedText.Alignment.left:
            return NSTextAlignment.left
        case AttributedText.Alignment.center:
            return NSTextAlignment.center
        case AttributedText.Alignment.right:
            return NSTextAlignment.right
        case AttributedText.Alignment.justified:
            return NSTextAlignment.justified
        case AttributedText.Alignment.natural:
            return NSTextAlignment.natural
        }
    }
}

extension AttributedText.Attribute {
    
    public init?(string: NSAttributedString,
                 attribute: String,
                 value: Any) {
        guard let att = { () -> AttributedText.Attribute? in
            switch NSAttributedStringKey(rawValue: attribute) {
            case NSAttributedStringKey.font:
                let font = AnyFont(font: value as! UIFont)
                return AttributedText.Attribute.font(font)
                
            case NSAttributedStringKey.foregroundColor:
                let color = AnyColor(color: value as! UIColor)
                return AttributedText.Attribute.color(color)
                
            case NSAttributedStringKey.backgroundColor:
                let color = AnyColor(color: value as! UIColor)
                return AttributedText.Attribute.backgroundColor(color)
                
            case NSAttributedStringKey.strokeColor:
                let color = AnyColor(color: value as! UIColor)
                return AttributedText.Attribute.strokeColor(color)
                
            case NSAttributedStringKey.strokeWidth:
                let width = (value as! NSNumber).floatValue
                return AttributedText.Attribute.strokeWidth(width)
                
            case NSAttributedStringKey.shadow:
                let shadow = AttributedText.Shadow(shadow: (value as! NSShadow))
                return AttributedText.Attribute.shadow(shadow)
                
            case NSAttributedStringKey.paragraphStyle:
                let style = AttributedText.ParagraphStyle(style: (value as! NSParagraphStyle))
                return AttributedText.Attribute.style(style)
                
            default: return nil
            }
            }() else { return nil }
        self = att
    }
}

fileprivate extension AttributedText.Attribute {
    
    fileprivate var key: NSAttributedStringKey {
        switch self {
        case AttributedText.Attribute.font:
            return NSAttributedStringKey.font
            
        case AttributedText.Attribute.color:
            return NSAttributedStringKey.foregroundColor
            
        case AttributedText.Attribute.backgroundColor:
            return NSAttributedStringKey.backgroundColor
            
        case AttributedText.Attribute.strokeColor:
            return NSAttributedStringKey.strokeColor
            
        case AttributedText.Attribute.strokeWidth:
            return NSAttributedStringKey.strokeWidth
            
        case AttributedText.Attribute.shadow:
            return NSAttributedStringKey.shadow
            
        case AttributedText.Attribute.style:
            return NSAttributedStringKey.paragraphStyle
        }
    }
    
    fileprivate func value(withText text: NSAttributedString) -> Any {
        switch self {
        case let AttributedText.Attribute.font(font):
            return font.font
        case let AttributedText.Attribute.color(color):
            return color.color
        case let AttributedText.Attribute.backgroundColor(color):
            return color.color
        case let AttributedText.Attribute.strokeColor(color):
            return color.color
        case let AttributedText.Attribute.strokeWidth(width):
            return NSNumber(value: width)
        case let AttributedText.Attribute.shadow(shadow):
            return shadow.shadow
        case let AttributedText.Attribute.style(style):
            return style.style
        }
    }
}


extension AttributedText {

    public func configure(label: UILabel) {
        label.customAttributedText = self
    }

    public func configure(button: UIButton) {
        self.configure(button: button, forStates: [UIControlState.normal])
    }

    public func configure(button: UIButton, forStates states: [UIControlState]) {
        let attributedString = self.attributedString
        for state in states {
            button.setAttributedTitle(attributedString, for: state)
        }
    }
}

extension UILabel {

    public var customAttributedText: AttributedText? {
        get {
            guard let att = self.attributedText else { return nil }
            return AttributedText(att)
        }
        set {
            guard let text = newValue else { return }
            self.text = nil
            self.attributedText = text.attributedString
        }
    }
}


public extension CGSize {
    
    public init(offset: AttributedText.Shadow.Offset) {
        self.init(width: Double(offset.x),
                  height: Double(offset.y))
    }
}

public extension AttributedText.Shadow.Offset {
    
    public init(size: CGSize) {
        self.init(x: Float(size.width),
                  y: Float(size.height))
    }
}

public extension AttributedText {
    
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.view(self.debugQuickLookObject() as! UILabel)
    }
    
    public func debugQuickLookObject() -> AnyObject? {
        return with(UILabel(frame: CGRect.zero)) {
            $0.customAttributedText = self
            $0.sizeToFit()
        }
    }
}

extension AttributedText.Attribute: Hashable {
    
    public var hashValue: Int {
        switch self {
        case let AttributedText.Attribute.font(font):
            return font.font.hashValue
        case let AttributedText.Attribute.color(color):
            return color.color.hashValue
        case let AttributedText.Attribute.backgroundColor(color):
            return color.color.hashValue
        case let AttributedText.Attribute.strokeColor(color):
            return color.color.hashValue
        case let AttributedText.Attribute.strokeWidth(width):
            return NSNumber(value: width).hashValue
        case let AttributedText.Attribute.shadow(shadow):
            return shadow.shadow.hashValue
        case let AttributedText.Attribute.style(style):
            return style.style.hashValue
        }
    }
    
    public static func ==(lhs: AttributedText.Attribute, rhs: AttributedText.Attribute) -> Bool {
        return (lhs.hashValue == rhs.hashValue)
    }
}


extension AttributedText: Equatable {
    
    public static func ==(lhs: AttributedText, rhs: AttributedText) -> Bool {
        return (lhs._attributes.count == rhs._attributes.count)
            && (lhs._attributes == rhs._attributes)
            && (lhs.content == rhs.content)
    }
}

extension AttributedText: Hashable {
    
    public var hashValue: Int {
        return self.attributedString.hashValue
    }
}

extension AttributedText: Comparable {}
extension AttributedText: CustomStringConvertible {}
extension AttributedText: LosslessStringConvertible {}

extension AttributedText: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "<"
            + String(describing: type(of: self))
            + ": content = \(self.content);"
            + " attributes = \(self.attributes);"
            + ">"
    }
}

extension AttributedText: ExpressibleByUnicodeScalarLiteral {
    
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
}

extension AttributedText: ExpressibleByExtendedGraphemeClusterLiteral {
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

extension AttributedText: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension AttributedText: CustomReflectable {
    
    public var customMirror: Mirror {
        let children =
            DictionaryLiteral<String, Any>(dictionaryLiteral: ("content", self.content),
                                           ("attributes", self.attributes),
                                           ("attributedString", self.attributedString)
        )
        return Mirror(AttributedText.self,
                      children: children,
                      displayStyle: Mirror.DisplayStyle.struct,
                      ancestorRepresentation: Mirror.AncestorRepresentation.suppressed)
    }
}


public extension AttributedText {
    
    private func attribute(name: String) -> AttributedText.Attribute? {
        return self._attributes.filter { $0.key == name }.first?.value
    }
    
    var font: Font? {
        get {
            guard let attr = self.attribute(name: NSAttributedStringKey.font.rawValue) else { return nil }
            return AnyFont(font: attr.value(withText: self.attributedString) as! UIFont)
        }
        set {
            guard let font = newValue else { return }
            self.set(attribute: AttributedText.Attribute.font(font))
        }
    }
    
    var color: Color? {
        get {
            guard let attribute = self.attribute(name: NSAttributedStringKey.foregroundColor.rawValue) else { return nil }
            return AnyColor(color: attribute.value(withText: self.attributedString) as! UIColor)
        }
        set {
            guard let color = newValue else { return }
            self.set(attribute: AttributedText.Attribute.color(color))
        }
    }
    
    var backgroundColor: Color? {
        get {
            guard let attribute = self.attribute(name: NSAttributedStringKey.backgroundColor.rawValue) else { return nil }
            return AnyColor(color: attribute.value(withText: self.attributedString) as! UIColor)
        }
        set {
            guard let color = newValue else { return }
            self.set(attribute: AttributedText.Attribute.backgroundColor(color))
        }
    }
    
    var strokeColor: Color? {
        get {
            guard let attribute = self.attribute(name: NSAttributedStringKey.strokeColor.rawValue) else { return nil }
            return AnyColor(color: attribute.value(withText: self.attributedString) as! UIColor)
        }
        set {
            guard let color = newValue else { return }
            self.set(attribute: AttributedText.Attribute.strokeColor(color))
        }
    }

    var strokeWidth: Float? {
        get {
            guard let attribute = self.attribute(name: NSAttributedStringKey.strokeWidth.rawValue) else { return nil }
            return (attribute.value(withText: self.attributedString) as! NSNumber).floatValue
        }
        set {
            guard let width = newValue else { return }
            self.set(attribute: AttributedText.Attribute.strokeWidth(width))
        }
    }
    
    var shadow: AttributedText.Shadow? {
        get {
            guard let attribute = self.attribute(name: NSAttributedStringKey.shadow.rawValue) else { return nil }
            return AttributedText.Shadow(shadow: (attribute.value(withText: self.attributedString) as! NSShadow))
        }
        set {
            guard let shadow = newValue else { return }
            self.set(attribute: AttributedText.Attribute.shadow(shadow))
        }
    }
    
    var style: AttributedText.ParagraphStyle {
        get {
            guard let attribute = self.attribute(name: NSAttributedStringKey.paragraphStyle.rawValue) else { return AttributedText.ParagraphStyle() }
            return AttributedText.ParagraphStyle(style: (attribute.value(withText: self.attributedString) as! NSParagraphStyle))
        }
        set {
            self.set(attribute: AttributedText.Attribute.style(newValue))
        }
    }
}
