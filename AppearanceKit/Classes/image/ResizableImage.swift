//
//  ResizableImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 07/03/2017.
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
import UIKit
import ContentKit

public class ResizableImage: Image {
    
    public enum Mode {
        case tile
        case stretch
    }
    
    public struct Insets {
        public let top: Float
        public let left: Float
        public let bottom: Float
        public let right: Float
        
        public init(top: Float,
                    left: Float,
                    bottom: Float,
                    right: Float) {
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }
        
        public var asUIEdgeInsets: UIEdgeInsets {
            return UIEdgeInsets(top: CGFloat(self.top),
                                left: CGFloat(self.left),
                                bottom: CGFloat(self.bottom),
                                right: CGFloat(self.right))
        }
    }
    
    final private let decorated: Image
    final fileprivate let insets: ResizableImage.Insets
    final fileprivate let mode: ResizableImage.Mode
    
    public init(_ image: Image,
                withCapInsets insets: ResizableImage.Insets,
                resizingMode: ResizableImage.Mode) {
        self.decorated = image
        self.insets = insets
        self.mode = resizingMode
    }
    
    public var image: UIImage {
        return self.decorated.image
            .resizableImage(withCapInsets: self.insets.asUIEdgeInsets,
                            resizingMode: self.mode.resizingMode)
    }
}

final public class MultipleStateResizableImage: ResizableImage, MultipleStateImage {
    final private let decorated: MultipleStateImage
    
    public init(_ image: MultipleStateImage,
                withCapInsets insets: ResizableImage.Insets,
                resizingMode: ResizableImage.Mode) {
        self.decorated = image
        super.init(image,
                   withCapInsets: insets,
                   resizingMode: resizingMode)
    }
    
    final private func resizable(_ image: Image?) -> ResizableImage? {
        guard let img = image else { return nil }
        return ResizableImage(img,
                              withCapInsets: self.insets,
                              resizingMode: self.mode)
    }
    
    public var normal: Image? { return self.resizable(self.decorated.normal) }
    
    public var highlighted: Image? { return self.resizable(self.decorated.highlighted) }
    
    public var selected: Image? { return self.resizable(self.decorated.selected) }
    
    public var disabled: Image? { return self.resizable(self.decorated.disabled) }
    
    public var original: UIImage? {
        return self.decorated.original?
            .resizableImage(withCapInsets: self.insets.asUIEdgeInsets,
                            resizingMode: self.mode.resizingMode) }
}

fileprivate extension ResizableImage.Mode {
    
    fileprivate var resizingMode: UIImageResizingMode {
        switch self {
        case ResizableImage.Mode.tile:
            return UIImageResizingMode.tile
        case ResizableImage.Mode.stretch:
            return UIImageResizingMode.stretch
        }
    }
}
