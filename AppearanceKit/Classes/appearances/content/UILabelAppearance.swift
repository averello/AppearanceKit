//
//  UILabelAppearance.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 25/07/2016.
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

public protocol UILabelAppearance: UIContentAppearance {
    var font: Font? { get }
    var textColor: TextColor? { get }
    var shadowColor: Color? { get }
    var shadowOffset: AppearanceKit.Size? { get }
    var numberOfLines: Int? { get }
    var adjustsFontSizeToFitWidth: Bool? { get }
    var minimumScaleFactor: Float? { get }
    var alignement: NSTextAlignment? { get }
}

public extension UILabelAppearance {
    
    public func configure(_ content: ConfigurableUIContent) {
        if let aLabel = content as? UILabel {
            self.configure(aLabel)
            return
        }
        if let aTextField = content as? UITextField {
            self.configure(aTextField)
            return
        }
        if let aTextView = content as? UITextView {
            self.configure(aTextView)
            return
        }
        //assert(false)
    }
    
    public func configure<L>(_ content: L) where L: UILabel {
        let aContent = content
        
        aContent.backgroundColor = self.backgroundColor?.color
        aContent.tintColor = self.tintColor?.color
        
        aContent.font = self.font?.font
        aContent.textColor = self.textColor?.color
        aContent.highlightedTextColor = self.textColor?.highlighted?.color
        aContent.shadowColor = self.shadowColor?.color
        
        if let alignement = self.alignement {
            aContent.textAlignment = alignement
        }
        if let offset = self.shadowOffset {
            aContent.shadowOffset = CGSize(size: offset)
        }
        if let adjusts = self.adjustsFontSizeToFitWidth {
            aContent.adjustsFontSizeToFitWidth = adjusts
        }
        if let scaleFactor = self.minimumScaleFactor {
            aContent.minimumScaleFactor = CGFloat(scaleFactor)
        }
        if let numberOfLines = self.numberOfLines {
            aContent.numberOfLines = numberOfLines
        }
        
    }
    
    public func configure<TF>(_ content: TF) where TF: UITextField {
        let aContent = content
        
        aContent.backgroundColor = self.backgroundColor?.color
        aContent.tintColor = self.tintColor?.color
        
        aContent.font = self.font?.font
        aContent.textColor = self.textColor?.color
        
        if let alignement = self.alignement {
            aContent.textAlignment = alignement
        }
        if let adjusts = self.adjustsFontSizeToFitWidth {
            aContent.adjustsFontSizeToFitWidth = adjusts
        }
    }
    
    public func configure<TV>(_ content: TV) where TV: UITextView {
        let aContent = content
        
        aContent.backgroundColor = self.backgroundColor?.color
        aContent.tintColor = self.tintColor?.color
        
        aContent.font = self.font?.font
        aContent.textColor = self.textColor?.color
        
        if let alignement = self.alignement {
            aContent.textAlignment = alignement
        }
    }
}

