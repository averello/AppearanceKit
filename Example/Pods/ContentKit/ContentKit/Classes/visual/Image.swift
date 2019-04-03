//
//  Image.swift
//  ContentKit
//
//  Created by Georges Boumis on 12/08/2016.
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

#if canImport(UIKit) && canImport(CoreGraphics)
import UIKit

/// An image is a visual content.
public protocol Image: VisualContent, CustomPlaygroundDisplayConvertible {
    /// The backing `UIKit` image.
    var image: UIImage { get }
    /// The size of the Image.
    var size: ContentKit.Size { get }
}

public extension Image {
    
    var size: ContentKit.Size {
        return ContentKit.Size(size: self.image.size)
    }
}

public extension Image {
    
    var playgroundDescription: Any {
        return self.image
    }
    
}

public extension Image {
    
    func debugQuickLookObject() -> AnyObject? {
        return self.image
    }
}

public extension Image {

    /// Configures an image view with the receiver.
    /// - parameter imageView: The image view.
    func configure(imageView: UIImageView) {
        imageView.image = self.image
    }

    /// Configures a button with the receiver.
    /// - parameter button: The button.
    func configure(button: UIButton) {
        button.setImage(self.image,
                        for: UIControl.State.normal)
    }

    /// Configures the background of the receiver.
    /// - parameter button: The button.
    func configureBackground(button: UIButton) {
        button.setBackgroundImage(self.image,
                                  for: UIControl.State.normal)
    }
}
#endif
