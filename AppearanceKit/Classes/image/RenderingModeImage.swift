//
//  RenderingModeImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 30/05/2017.
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

public class RenderingModeImage: ContentKit.Image {
    
    public enum Mode {
        case automatic
        case alwaysOriginal
        case alwaysTemplate
    }
    
    final private let decorated: Image
    final fileprivate let mode: RenderingModeImage.Mode
    
    public init(rendered image: Image,
                renderingMode: RenderingModeImage.Mode) {
        self.decorated = image
        self.mode = renderingMode
    }
    
    public var image: UIImage {
        return self.decorated.image.withRenderingMode(self.mode.renderingMode)
    }
}


final public class MultipleStateRenderingModeImage: RenderingModeImage, MultipleStateImage {
    
    final private let decorated: MultipleStateImage
    
    public init(rendered image: MultipleStateImage,
                renderingMode: RenderingModeImage.Mode) {
        self.decorated = image
        super.init(rendered: image,
                   renderingMode: renderingMode)
    }
    
    final private func rendered(_ image: Image?) -> RenderingModeImage? {
        guard let img = image else { return nil }
        return RenderingModeImage(rendered: img,
                              renderingMode: self.mode)
    }
    
    public var normal: Image? { return self.rendered(self.decorated.normal) }
    
    public var highlighted: Image? { return self.rendered(self.decorated.highlighted) }
    
    public var selected: Image? { return self.rendered(self.decorated.selected) }
    
    public var disabled: Image? { return self.rendered(self.decorated.disabled) }
    
    public var original: UIImage? { return self.decorated.original?.withRenderingMode(self.mode.renderingMode) }
}

fileprivate extension RenderingModeImage.Mode {
    
    fileprivate var renderingMode: UIImageRenderingMode {
        switch self {
        case RenderingModeImage.Mode.automatic:
            return UIImageRenderingMode.automatic
        case RenderingModeImage.Mode.alwaysOriginal:
            return UIImageRenderingMode.alwaysOriginal
        case RenderingModeImage.Mode.alwaysTemplate:
            return UIImageRenderingMode.alwaysTemplate
        }
    }
}
