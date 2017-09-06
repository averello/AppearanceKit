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
    final private let decorated: Image
    final fileprivate let insets: UIEdgeInsets
    final fileprivate let mode: UIImageResizingMode
    
    public init(resizable image: Image,
         withCapInsets insets: UIEdgeInsets,
         resizingMode: UIImageResizingMode) {
        self.decorated = image
        self.insets = insets
        self.mode = resizingMode
    }
    
    public var image: UIImage {
        return self.decorated.image.resizableImage(withCapInsets: self.insets,
                                                   resizingMode: self.mode)
    }
}

final public class MultipleStateResizableImage: ResizableImage, MultipleStateImage {
    final private let decorated: MultipleStateImage
    public init(resizable image: MultipleStateImage,
         withCapInsets insets: UIEdgeInsets,
         resizingMode: UIImageResizingMode) {
        self.decorated = image
        super.init(resizable: image,
                   withCapInsets: insets,
                   resizingMode: resizingMode)
    }
    
    final private func resizable(_ image: Image?) -> ResizableImage? {
        guard let img = image else { return nil }
        return ResizableImage(resizable: img,
                              withCapInsets: self.insets,
                              resizingMode: self.mode)
    }
    
    public var normal: Image? { return self.resizable(self.decorated.normal) }
    
    public var highlighted: Image? { return self.resizable(self.decorated.highlighted) }
    
    public var selected: Image? { return self.resizable(self.decorated.selected) }
    
    public var disabled: Image? { return self.resizable(self.decorated.disabled) }
    
    public var original: UIImage? { return self.decorated.original?.resizableImage(withCapInsets: self.insets, resizingMode: self.mode) }
}
