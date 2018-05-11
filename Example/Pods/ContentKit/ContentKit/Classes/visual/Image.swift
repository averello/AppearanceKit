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

public protocol Image: VisualContent, CustomPlaygroundDisplayConvertible {
    var image: UIImage { get }
    var size: Size { get }
    func scaled(_ scale: Float) -> Image
    
    func configure(imageView: UIImageView)
    func configure(button: UIButton)
    func configureBackground(button: UIButton)
}

public extension Image {
    
    public var size: Size {
        return Size(size: self.image.size)
    }
    
    public func scaled(_ scale: Float) -> Image {
        return ScaledImage(original: self, scale: scale)
    }
}

public extension Image {
    
    public var playgroundDescription: Any {
        return self.image
    }
    
}

public extension Image {
    
    public func debugQuickLookObject() -> AnyObject? {
        return self.image
    }
}

public extension Image {
    
    public func configure(imageView: UIImageView) {
        imageView.image = self.image
    }
    
    public func configure(button: UIButton) {
        button.setImage(self.image,
                        for: UIControlState.normal)
    }
    
    func configureBackground(button: UIButton) {
        button.setBackgroundImage(self.image,
                                  for: UIControlState.normal)
    }
}
