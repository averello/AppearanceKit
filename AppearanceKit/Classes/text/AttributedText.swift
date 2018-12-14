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

#if canImport(ContentKit)
import ContentKit

/// A textual content that has display attributes for its entirety.
public struct AttributedText: Text {
    /// The backing `Foundation` string.
    public fileprivate(set) var content: String
    fileprivate var _attributes: [String: Attribute]

    /// The current attributes associated with the receiver.
    public var attributes: [Attribute] {
        get { return Array(self._attributes.values) }
    }
}

// MARK: - Initializers

extension AttributedText {

    /// Creates an `AttributedText` from a `String` with no attributes.
    /// - parameter content: The string of the text.
    public init(_ content: String) {
        self.init(content, attributes: [])
    }

    /// Creates an `AttributedText` from any `Text` with the given attributes.
    /// - parameter text: The content.
    /// - parameter attributes: The dispaly attributes of the text.
    public init(_ text: ContentKit.Text,
                attributes: [AttributedText.Attribute] = []) {
        self.content = text.content
        
        var attrs = Dictionary<String, AttributedText.Attribute>()
        for (key,value) in attributes.map({ ($0.key.rawValue, $0) }) {
            attrs[key] = value
        }
        self._attributes = attrs
    }
    
    /// Creates an `AttributedText` from a `NSAttributedString`.
    ///
    /// It translates the `NSAttributedString` attributes to
    /// `AttributedText.Attribute`s.
    /// - parameter string: The attributed string.
    public init(_ string: NSAttributedString) {
        self.content = string.string
        var attrs = Dictionary<String, AttributedText.Attribute>()
        for (key,value) in string
            .attributes(at: 0, effectiveRange: nil)
            .compactMap({ (key: NSAttributedString.Key, value: Any) -> (String,AttributedText.Attribute)? in
            guard let attribute = AttributedText.Attribute(string: string,
                                                           attribute: key,
                                                           value: value) else { return nil }
            return (key.rawValue, attribute)
        }) {
            attrs[key] = value
        }
        self._attributes = attrs
    }
}

// MARK: - Manipulators

extension AttributedText {

    /// Sets the given attribute to the entirety of the receiver.
    ///
    /// - parameter attribute: The attribute to set. If the attribute exists it
    /// will be replaced, otherwise it will be added to the list of attributes
    /// of the receiver.
    public mutating func set(attribute: AttributedText.Attribute) {
        self._attributes[attribute.key.rawValue] = attribute
    }

    /// Gets an `NSAttributedString` from the receiver.
    public var attributedString: NSAttributedString {
        return { () -> NSAttributedString in
            let string = NSMutableAttributedString(string: self.content)
            let range = NSMakeRange(0, (string.string as NSString).length)
            for attribute in self._attributes {
                let atts = [NSAttributedString.Key(rawValue: attribute.key): attribute.value.value]
                string.addAttributes(atts, range: range)
            }
            return string.copy() as! NSAttributedString
            }()
    }
}

// MARK: - Attributed Text Types

extension AttributedText {

    /// The alignement of an `AttributedText`.
    public enum Alignment {
        /// Text is visually left aligned.
        case left
        /// Text is visually center aligned.
        case center
        /// Text is visually right aligned.
        case right
        /// Text is justified.
        case justified
        /// Use the default alignment associated with the current localization
        /// of the app. The default alignment for left-to-right scripts is
        /// `AttributedText.Alignment.left`, and the default alignment for
        /// right-to-left scripts is AttributedText.Alignment.right.
        case natural
    }
}

#if canImport(UIKit) || canImport(AppKit)

#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

public extension AttributedText.Alignment {

    /// Creates a `AttributedText.Alignment` instance from the `UIKit` or
    /// `AppKit` equivalent.
    public init(textAlignment: NSTextAlignment) {
        self = { () -> AttributedText.Alignment in
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

fileprivate extension AttributedText.Alignment {

    /// The equivalent `UIKit` or `AppKit` text alignment.
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
#endif

extension AttributedText {

    /// Attributes that you can apply to an attributed text.
    public enum Attribute {
        /// The font.
        case font(Font)
        /// The foreground color.
        case color(Color)
        /// The background color.
        case backgroundColor(Color)
        /// The stroke color.
        case strokeColor(Color)
        /// The stroke width.
        ///
        /// This value represents the amount to change the
        /// stroke width and is specified as a percentage of the font point
        /// size. Specify 0 (the default) for no additional changes. Specify
        /// positive values to change the stroke width alone. Specify negative
        /// values to stroke and fill the text. For example, a typical value
        /// for outlined text would be 3.0.
        case strokeWidth(Float)
        /// The shadow.
        case shadow(AttributedText.Shadow)

        #if canImport(UIKit) || canImport(AppKit)
        /// The paragragh style.
        case style(AttributedText.ParagraphStyle)
        #endif
    }
}

extension AttributedText {

    /// The shadow of an `AttributedText`.
    public struct Shadow {
        /// The offset of the shadow in user space points.
        public let offset: AttributedText.Shadow.Offset
        /// The blur radius (in points) of the shadow.
        public let radius: Float
        /// The color of the shadow.
        public let color: Color
        
        /// Creates a shadow with the given attributes.
        /// - parameter offset: The offset in user space points.
        /// - parameter radius: The blur radius (in points) of the shadow.
        /// - parameter color: The color of the shadow. The default is black
        /// with an alpha value of 1/3.
        public init(offset: AttributedText.Shadow.Offset,
                    radius: Float = 0,
                    color: Color = BlackColor().with(alpha: 0.333)) {
            self.offset = offset
            self.radius = radius
            self.color = color
        }

        /// Creates a shadow with the given attributes.
        /// - parameter offset: A couple describing the shadow offset.
        /// - parameter radius: The blur radius (in points) of the shadow.
        /// - parameter color: The color of the shadow. The default is black
        /// with an alpha value of 1/3.
        public init(offset: (horizontal: Float, vertical: Float),
                    radius: Float = 0,
                    color: Color = BlackColor().with(alpha: 0.333)) {
            self.init(offset: AttributedText.Shadow.Offset(horizontal: offset.horizontal,
                                                           vertical: offset.vertical),
                      radius: radius,
                      color: color)
        }
    }
}

public extension AttributedText.Shadow {

    /// Defines a structure that specifies an amount to offset a shadow.
    public struct Offset {
        /// The horizontal offset in user space points.
        public let horizontal: Float
        /// The vertical offset in user space points.
        public let vertical: Float

        /// Creates a shadow offest with the given values.
        /// - parameter horizontal: The horizontal offset in user space points.
        /// - parameter vertical: The vertical offset in user space points.
        public init(horizontal: Float, vertical: Float) {
            self.horizontal = horizontal
            self.vertical = vertical
        }
    }
}

#if canImport(UIKit) || canImport(AppKit)

#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

public extension AttributedText.Shadow {

    /// Creates a `AttributedText.Shadow` from the equivalent `UIKit`/`AppKit`
    /// `NSShadow`.
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

    /// Creates an equivalent `UIKit`/`AppKit` `NSShadow` from the receiver.
    fileprivate var shadow: NSShadow {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(offset: self.offset)
        shadow.shadowColor = self.color.color
        shadow.shadowBlurRadius = CGFloat(self.radius)
        return shadow
    }
}
#endif

#if canImport(QuartzCore)
import QuartzCore

public extension CGSize {

    /// Creates a `CGSize` from an `AttributedText.Shadow.Offset`.
    public init(offset: AttributedText.Shadow.Offset) {
        self.init(width: Double(offset.horizontal),
                  height: Double(offset.vertical))
    }
}

public extension AttributedText.Shadow.Offset {

    /// Creates an `AttributedText.Shadow.Offset` from a `CGSize`.
    public init(size: CGSize) {
        self.init(horizontal: Float(size.width),
                  vertical: Float(size.height))
    }
}
#endif

#if canImport(UIKit) || canImport(AppKit)

#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

extension AttributedText {

    /// The paragraph attributes used by an attributed text.
    public struct ParagraphStyle {

        /// Specifies what happens when a line is too long for its container.
        public enum LineBreakMode {
            /// Wrapping occurs at word boundaries, unless the word itself
            /// doesn't fit on a single line.
            case byWordWrapping
            /// Wrapping occurs before the first character that doesn’t fit.
            case byCharWrapping
            /// Lines are simply not drawn past the edge of the text container.
            case byClipping
            /// The line is displayed so that the end fits in the container and
            /// the missing text at the beginning of the line is indicated by an
            /// ellipsis glyph. Although this mode works for multiline text, it
            /// is more often used for single line text.
            case byTruncatingHead // Truncate at head of line: "...wxyz"
            /// The line is displayed so that the beginning fits in the
            /// container and the missing text at the end of the line is
            /// indicated by an ellipsis glyph. Although this mode works for
            /// multiline text, it is more often used for single line text.
            case byTruncatingTail // Truncate at tail of line: "abcd..."
            /// The line is displayed so that the beginning and end fit in the
            /// container and the missing text in the middle is indicated by an
            /// ellipsis glyph. This mode is used for single-line layout; using
            /// it with multiline text truncates the text into a single line.
            case byTruncatingMiddle // Truncate middle of line:  "ab...yz"
        }

        /// Specifies the writing directions.
        public enum WritingDirection {
            /// The writing direction is determined using the Unicode Bidi
            /// Algorithm rules P2 and P3. Default.
            case natural // Determines direction using the Unicode Bidi Algorithm rules P2 and P3
            /// The writing direction is left to right.
            case leftToRight // Left to right writing direction
            /// The writing direction is right to left.
            case rightToLeft // Right to left writing direction
        }

        /// The distance in points between the bottom of one line fragment and
        /// the top of the next.
        ///
        /// This value is always nonnegative. This value is included in the line
        /// fragment heights in the layout manager.
        public var lineSpacing: Float
        /// The space after the end of the paragraph.
        ///
        /// This property contains the space (measured in points) added at the
        /// end of the paragraph to separate it from the following paragraph.
        /// This value is always nonnegative. The space between paragraphs is
        /// determined by adding the previous paragraph's paragraphSpacing and
        /// the current paragraph's `paragraphSpacingBefore`.
        public var paragraphSpacing: Float
        /// The text alignment of the receiver.
        ///
        /// Natural text alignment is realized as left or right alignment
        /// depending on the line sweep direction of the first script contained
        /// in the paragraph.
        public var alignment: AttributedText.Alignment
        /// The indentation of the first line of the receiver.
        ///
        /// This property contains the distance (in points) from the leading
        /// margin of a text container to the beginning of the paragraph's first
        /// line. This value is always nonnegative.
        public var firstLineHeadIndent: Float
        /// The indentation of the receiver’s lines other than the first.
        ///
        /// This property contains the distance (in points) from the leading
        /// margin of a text container to the beginning of lines other than the
        /// first. This value is always nonnegative.
        public var headIndent: Float
        /// The trailing indentation of the receiver.
        ///
        /// If positive, this value is the distance from the leading margin
        /// (for example, the left margin in left-to-right text). If 0 or
        /// negative, it’s the distance from the trailing margin.
        ///
        /// For example, a paragraph style designed to fit exactly in a 2-inch
        /// wide container has a head indent of 0.0 and a tail indent of 0.0.
        /// One designed to fit with a quarter-inch margin has a head indent of
        /// 0.25 and a tail indent of –0.25.
        public var tailIndent: Float
        /// The mode that should be used to break lines in the receiver.
        ///
        /// This property contains the line break mode to be used laying out the
        /// paragraph's text.
        public var lineBreakMode: AttributedText.ParagraphStyle.LineBreakMode
        /// The receiver’s minimum height.
        ///
        /// This property contains the minimum height in points that any line in
        /// the receiver will occupy, regardless of the font size or size of any
        /// attached graphic. This value is always nonnegative
        public var minimumLineHeight: Float
        /// The receiver’s maximum line height.
        ///
        /// This property contains the maximum height in points that any line in
        /// the receiver will occupy, regardless of the font size or size of any
        /// attached graphic. This value is always nonnegative.
        /// The default value is 0.
        ///
        /// Glyphs and graphics exceeding this height will overlap neighboring
        /// lines; however, a maximum height of 0 implies no line height limit.
        /// Although this limit applies to the line itself, line spacing adds
        /// extra space between adjacent lines.
        public var maximumLineHeight: Float
        /// The base writing direction for the receiver.
        ///
        /// If you the value of this property is
        /// `AttributedText.ParagraphStyle.WritingDirection`, the receiver
        /// resolves the writing direction to either `.leftToRight` or
        /// `.rightToLeft`, depending on the direction for the user’s language
        /// preference setting.
        public var baseWritingDirection: AttributedText.ParagraphStyle.WritingDirection
        /// The line height multiple.
        ///
        /// The natural line height of the receiver is multiplied by this factor
        /// (if positive) before being constrained by minimum and maximum line
        /// height. The default value of this property is 0.0.
        public var lineHeightMultiple: Float // Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height.
        /// The distance between the paragraph’s top and the beginning of its
        /// text content.
        ///
        /// This property contains the space (measured in points) between the
        /// paragraph's top and the beginning of its text content. The default
        /// value of this property is 0.0.
        public var paragraphSpacingBefore: Float // Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph.
        /// The paragraph’s threshold for hyphenation.
        ///
        /// Hyphenation is attempted when the ratio of the text width (as broken
        /// without hyphenation) to the width of the line fragment is less than
        /// the hyphenation factor. When the paragraph’s hyphenation factor is
        /// 0.0, the layout manager’s hyphenation factor is used instead. When
        /// both are 0.0, hyphenation is disabled. This property detects the
        /// user-selected language by examining the first item in
        /// `preferredLanguages`.
        public var hyphenationFactor: Float

        /// Creates a paragraph style.
        /// - parameter lineSpacing: The line spacing.
        /// - parameter paragraphSpacing: The paragraph spacing.
        /// - parameter alignment: The text alignment.
        /// - parameter firstLineHeadIndent: The first line head indent.
        /// - parameter headIndent: The head indent.
        /// - parameter tailIndent: The tail indent.
        /// - parameter lineBreakMode: The line break mode.
        /// - parameter minimumLineHeight: The minimum line height.
        /// - parameter maximumLineHeight: The maximum line height.
        /// - parameter baseWritingDirection: The base writing direction.
        /// - parameter lineHeightMultiple: The line height multiple.
        /// - parameter paragraphSpacingBefore: The paragraph spacing before.
        /// - parameter hyphenationFactor: The hyphenation factor.
        public init(lineSpacing: Float,
                    paragraphSpacing: Float,
                    alignment: AttributedText.Alignment,
                    firstLineHeadIndent: Float,
                    headIndent: Float,
                    tailIndent: Float,
                    lineBreakMode: AttributedText.ParagraphStyle.LineBreakMode,
                    minimumLineHeight: Float,
                    maximumLineHeight: Float,
                    baseWritingDirection: AttributedText.ParagraphStyle.WritingDirection,
                    lineHeightMultiple: Float,
                    paragraphSpacingBefore: Float,
                    hyphenationFactor: Float) {
            self.lineSpacing = lineSpacing
            self.paragraphSpacing = paragraphSpacing
            self.alignment = alignment
            self.firstLineHeadIndent = firstLineHeadIndent
            self.headIndent = headIndent
            self.tailIndent = tailIndent
            self.lineBreakMode = lineBreakMode
            self.minimumLineHeight = minimumLineHeight
            self.maximumLineHeight = maximumLineHeight
            self.baseWritingDirection = baseWritingDirection
            self.lineHeightMultiple = lineHeightMultiple
            self.paragraphSpacingBefore = paragraphSpacingBefore
            self.hyphenationFactor = hyphenationFactor
        }
    }
}

public extension AttributedText.ParagraphStyle.LineBreakMode {

    /// Creates an `AttributedText.ParagraphStyle.LineBreakMode` from the
    /// equivalent `UIKit`/`AppKit` `NSLineBreakMode`.
    public init(_ mode: NSLineBreakMode) {
        self = { () -> AttributedText.ParagraphStyle.LineBreakMode in
            switch mode {
            case NSLineBreakMode.byWordWrapping:
                return AttributedText.ParagraphStyle.LineBreakMode.byWordWrapping
            case NSLineBreakMode.byCharWrapping:
                return AttributedText.ParagraphStyle.LineBreakMode.byCharWrapping
            case NSLineBreakMode.byClipping:
                return AttributedText.ParagraphStyle.LineBreakMode.byClipping
            case NSLineBreakMode.byTruncatingHead:
                return AttributedText.ParagraphStyle.LineBreakMode.byTruncatingHead
            case NSLineBreakMode.byTruncatingTail:
                return AttributedText.ParagraphStyle.LineBreakMode.byTruncatingTail
            case NSLineBreakMode.byTruncatingMiddle:
                return AttributedText.ParagraphStyle.LineBreakMode.byTruncatingMiddle
            }
        }()
    }

    /// Creates the equivalent `UIKit`/`AppKit` `NSLineBreakMode` from a
    /// `AttributedText.ParagraphStyle.LineBreakMode`.
    fileprivate var lineBreakMode: NSLineBreakMode {
        switch self {
        case AttributedText.ParagraphStyle.LineBreakMode.byWordWrapping:
            return NSLineBreakMode.byWordWrapping

        case AttributedText.ParagraphStyle.LineBreakMode.byCharWrapping:
            return NSLineBreakMode.byCharWrapping

        case AttributedText.ParagraphStyle.LineBreakMode.byClipping:
            return NSLineBreakMode.byClipping

        case AttributedText.ParagraphStyle.LineBreakMode.byTruncatingHead:
            return NSLineBreakMode.byTruncatingHead

        case AttributedText.ParagraphStyle.LineBreakMode.byTruncatingTail:
            return NSLineBreakMode.byTruncatingTail

        case AttributedText.ParagraphStyle.LineBreakMode.byTruncatingMiddle:
            return NSLineBreakMode.byTruncatingMiddle
        }
    }
}

public extension AttributedText.ParagraphStyle.WritingDirection {

    /// Creates an `AttributedText.ParagraphStyle.WritingDirection` from the
    /// equivalent `UIKit`/`AppKit` `NSWritingDirection`.s
    public init(_ direction: NSWritingDirection) {
        self = { () -> AttributedText.ParagraphStyle.WritingDirection in
            switch direction {
            case NSWritingDirection.natural:
                return AttributedText.ParagraphStyle.WritingDirection.natural
            case NSWritingDirection.leftToRight:
                return AttributedText.ParagraphStyle.WritingDirection.leftToRight
            case NSWritingDirection.rightToLeft:
                return AttributedText.ParagraphStyle.WritingDirection.rightToLeft
            }
        }()
    }

    /// Creates the equivalent `UIKit`/`AppKit` `NSWritingDirection` from a
    /// `AttributedText.ParagraphStyle.WritingDirection`.
    fileprivate var writingDirection: NSWritingDirection {
        switch self {
        case AttributedText.ParagraphStyle.WritingDirection.natural:
            return NSWritingDirection.natural
        case AttributedText.ParagraphStyle.WritingDirection.leftToRight:
            return NSWritingDirection.leftToRight
        case AttributedText.ParagraphStyle.WritingDirection.rightToLeft:
            return NSWritingDirection.rightToLeft
        }
    }
}

extension AttributedText.ParagraphStyle {

    /// Creates the default paragraph style.
    public init() {
        self.init(style: NSParagraphStyle.default)
    }

    /// Creates an `AttributedText.ParagraphStyle` from the
    /// equivalent `UIKit`/`AppKit` `NSParagraphStyle`.s
    public init(style: NSParagraphStyle) {
        self.lineSpacing = Float(style.lineSpacing)
        self.paragraphSpacing = Float(style.paragraphSpacing)
        self.alignment = AttributedText.Alignment(textAlignment: style.alignment)
        self.firstLineHeadIndent = Float(style.firstLineHeadIndent)
        self.headIndent = Float(style.headIndent)
        self.tailIndent = Float(style.tailIndent)
        self.lineBreakMode = LineBreakMode(style.lineBreakMode)
        self.minimumLineHeight = Float(style.minimumLineHeight)
        self.maximumLineHeight = Float(style.maximumLineHeight)
        self.baseWritingDirection = WritingDirection(style.baseWritingDirection)
        self.lineHeightMultiple = Float(style.lineHeightMultiple)
        self.paragraphSpacingBefore = Float(style.paragraphSpacingBefore)
        self.hyphenationFactor = style.hyphenationFactor
    }

    /// Creates the equivalent `UIKit`/`AppKit` `NSParagraphStyle` from a
    /// `AttributedText.ParagraphStyle`.
    fileprivate var style: NSParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = CGFloat(self.lineSpacing)
        style.paragraphSpacing = CGFloat(self.paragraphSpacing)
        style.alignment = self.alignment.textAlignment
        style.firstLineHeadIndent = CGFloat(self.firstLineHeadIndent)
        style.headIndent = CGFloat(self.headIndent)
        style.tailIndent = CGFloat(self.tailIndent)
        style.lineBreakMode = self.lineBreakMode.lineBreakMode
        style.minimumLineHeight = CGFloat(self.minimumLineHeight)
        style.maximumLineHeight = CGFloat(self.maximumLineHeight)
        style.baseWritingDirection = self.baseWritingDirection.writingDirection
        style.lineHeightMultiple = CGFloat(self.lineHeightMultiple)
        style.paragraphSpacingBefore = CGFloat(self.paragraphSpacingBefore)
        style.hyphenationFactor = self.hyphenationFactor
        return style.copy() as! NSParagraphStyle
    }
}
#endif

extension AttributedText.Attribute {

    /// Creates an `AttributedText.Attribute` from a given attributed string
    /// attribute and value
    public init?(string: NSAttributedString,
                 attribute: NSAttributedString.Key,
                 value: Any) {
        guard let att = { () -> AttributedText.Attribute? in
            switch attribute {
            case NSAttributedString.Key.font:
                let font = AnyFont(font: value as! UIFont)
                return AttributedText.Attribute.font(font)
                
            case NSAttributedString.Key.foregroundColor:
                let color = AnyColor(color: value as! UIColor)
                return AttributedText.Attribute.color(color)
                
            case NSAttributedString.Key.backgroundColor:
                let color = AnyColor(color: value as! UIColor)
                return AttributedText.Attribute.backgroundColor(color)
                
            case NSAttributedString.Key.strokeColor:
                let color = AnyColor(color: value as! UIColor)
                return AttributedText.Attribute.strokeColor(color)
                
            case NSAttributedString.Key.strokeWidth:
                let width = (value as! NSNumber).floatValue
                return AttributedText.Attribute.strokeWidth(width)
                
            case NSAttributedString.Key.shadow:
                let shadow = AttributedText.Shadow(shadow: (value as! NSShadow))
                return AttributedText.Attribute.shadow(shadow)
                
            case NSAttributedString.Key.paragraphStyle:
                let style = AttributedText.ParagraphStyle(style: (value as! NSParagraphStyle))
                return AttributedText.Attribute.style(style)
                
            default: return nil
            }
            }() else { return nil }
        self = att
    }
}

#if canImport(UIKit)

fileprivate extension AttributedText.Attribute {
    
    fileprivate var key: NSAttributedString.Key {
        switch self {
        case AttributedText.Attribute.font:
            return NSAttributedString.Key.font
            
        case AttributedText.Attribute.color:
            return NSAttributedString.Key.foregroundColor
            
        case AttributedText.Attribute.backgroundColor:
            return NSAttributedString.Key.backgroundColor
            
        case AttributedText.Attribute.strokeColor:
            return NSAttributedString.Key.strokeColor
            
        case AttributedText.Attribute.strokeWidth:
            return NSAttributedString.Key.strokeWidth
            
        case AttributedText.Attribute.shadow:
            return NSAttributedString.Key.shadow
            
        case AttributedText.Attribute.style:
            return NSAttributedString.Key.paragraphStyle
        }
    }
    
    fileprivate var value: Any {
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

#endif


extension AttributedText {

    /// Makes a `UILabel` display the receiver.
    /// - parameter label: The `UILabel` to display the receiver.
    public func configure(label: UILabel) {
        label.customAttributedText = self
    }

    /// Makes a `UIButton` display the receiver.
    /// - parameter button: The `UIButton` to display the receiver.
    public func configure(button: UIButton) {
        self.configure(button: button, forStates: [UIControl.State.normal])
    }

    /// Makes a `UIButton` display the receiver for the given states.
    /// - parameter button: The `Button` to display the receiver.
    /// - parameter states: The state to configure.
    public func configure(button: UIButton, forStates states: [UIControl.State]) {
        let attributedString = self.attributedString
        for state in states {
            button.setAttributedTitle(attributedString, for: state)
        }
    }
}

extension UILabel {

    /// Retrieve/sets an `AttributedText` from/to a label.
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

public extension AttributedText {
    
    public var playgroundDescription: Any {
        return self.__visualRepresentation
    }
    
    public func debugQuickLookObject() -> AnyObject? {
        return self.__visualRepresentation
    }
    
    private var __visualRepresentation: UIView {
        let label = UILabel(frame: CGRect.zero)
        label.customAttributedText = self
        label.sizeToFit()
        return label
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

    /// The font of the text.
    ///
    /// The value of this attribute is a `AppearanceKit.Font` object. Use this
    /// attribute to change the font of the text. If you do not specify this
    /// attribute, the string uses a 12-point Helvetica(Neue) font by default.
    var font: Font? {
        get {
            guard let attr = self.attribute(name: NSAttributedString.Key.font.rawValue) else { return nil }
            return AnyFont(font: attr.value as! UIFont)
        }
        set {
            guard let font = newValue else { return }
            self.set(attribute: AttributedText.Attribute.font(font))
        }
    }

    /// The foreground color to display the text.
    ///
    /// The value of this attribute is a `AppearanceKit.Color` object. Use this
    /// attribute to specify the color of the text during rendering. If you do
    /// not specify this attribute, the text is rendered in black.
    var color: Color? {
        get {
            guard let attribute = self.attribute(name: NSAttributedString.Key.foregroundColor.rawValue) else { return nil }
            return AnyColor(color: attribute.value as! UIColor)
        }
        set {
            guard let color = newValue else { return }
            self.set(attribute: AttributedText.Attribute.color(color))
        }
    }

    /// The background color of the text.
    ///
    /// The value of this attribute is a `ApperanceKit.Color` object. Use this
    /// attribute to specify the color of the background area behind the text.
    /// If you do not specify this attribute, no background color is drawn.
    var backgroundColor: Color? {
        get {
            guard let attribute = self.attribute(name: NSAttributedString.Key.backgroundColor.rawValue) else { return nil }
            return AnyColor(color: attribute.value as! UIColor)
        }
        set {
            guard let color = newValue else { return }
            self.set(attribute: AttributedText.Attribute.backgroundColor(color))
        }
    }

    /// The stroke color of the text.
    ///
    /// The value of this parameter is a `AppearanceKit.Color` object. If it is
    /// not defined (which is the case by default), it is assumed to be the same
    /// as the value of `foregroundColor`; otherwise, it describes the outline
    /// color.
    var strokeColor: Color? {
        get {
            guard let attribute = self.attribute(name: NSAttributedString.Key.strokeColor.rawValue) else { return nil }
            return AnyColor(color: attribute.value as! UIColor)
        }
        set {
            guard let color = newValue else { return }
            self.set(attribute: AttributedText.Attribute.strokeColor(color))
        }
    }

    /// The stroke width.
    ///
    /// This value represents the amount to change the
    /// stroke width and is specified as a percentage of the font point
    /// size. Specify 0 (the default) for no additional changes. Specify
    /// positive values to change the stroke width alone. Specify negative
    /// values to stroke and fill the text. For example, a typical value
    /// for outlined text would be 3.0.
    var strokeWidth: Float? {
        get {
            guard let attribute = self.attribute(name: NSAttributedString.Key.strokeWidth.rawValue) else { return nil }
            return (attribute.value as! NSNumber).floatValue
        }
        set {
            guard let width = newValue else { return }
            self.set(attribute: AttributedText.Attribute.strokeWidth(width))
        }
    }

    /// The shadow of the text.
    ///
    /// The value of this attribute is an `AttributedText.Shadow` object. The
    /// default value of this property is `nil`.
    var shadow: AttributedText.Shadow? {
        get {
            guard let attribute = self.attribute(name: NSAttributedString.Key.shadow.rawValue) else { return nil }
            return AttributedText.Shadow(shadow: (attribute.value as! NSShadow))
        }
        set {
            guard let shadow = newValue else { return }
            self.set(attribute: AttributedText.Attribute.shadow(shadow))
        }
    }

    /// The paragraph style.
    ///
    /// The value of this attribute is an `AttributedText.ParagraphStyle`
    /// object. Use this attribute to apply multiple attributes to the text. If
    /// you do not specify this attribute, the string uses the default paragraph
    /// attributes, as returned by the `default` method of
    /// `AttributedText.ParagraphStyle`.
    var style: AttributedText.ParagraphStyle {
        get {
            guard let attribute = self.attribute(name: NSAttributedString.Key.paragraphStyle.rawValue) else { return AttributedText.ParagraphStyle() }
            return AttributedText.ParagraphStyle(style: (attribute.value as! NSParagraphStyle))
        }
        set {
            self.set(attribute: AttributedText.Attribute.style(newValue))
        }
    }
}
#endif
