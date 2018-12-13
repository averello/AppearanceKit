//
//  ConfigurableUIButtonAppearance.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 14/11/2018.
//

import Foundation

/// A configurable `UIButtonApperanace`.
public struct ConfigurableUIButtonAppearance: UIButtonAppearance {
    public var font: Font?
    public var titleColor: TextColor?
    public var shadowColor: TextColor?
    public var shadowOffset: Size?
    public var titleLabelAppearance: UILabelAppearance?
    public var backgroundColor: Color?
    public var tintColor: Color?
    public var layerAppearance: CAContentAppearance?


    public init(appearance: UIButtonAppearance = DefaultUIButtonAppearance()) {
        self.init(font: appearance.font,
                  titleColor: appearance.titleColor,
                  shadowColor: appearance.shadowColor,
                  shadowOffset: appearance.shadowOffset,
                  titleLabelAppearance: appearance.titleLabelAppearance,
                  backgroundColor: appearance.backgroundColor,
                  tintColor: appearance.tintColor,
                  layerAppearance: appearance.layerAppearance)
    }

    public init(font: Font? = DefaultUIButtonAppearance().font,
                titleColor: TextColor? = DefaultUIButtonAppearance().titleColor,
                shadowColor: TextColor? = DefaultUIButtonAppearance().shadowColor,
                shadowOffset: Size? = DefaultUIButtonAppearance().shadowOffset,
                titleLabelAppearance: UILabelAppearance? = DefaultUIButtonAppearance().titleLabelAppearance,
                backgroundColor: Color? = DefaultUIButtonAppearance().backgroundColor,
                tintColor: Color? = DefaultUIButtonAppearance().tintColor,
                layerAppearance: CAContentAppearance? = DefaultUIButtonAppearance().layerAppearance) {
        self.font = font
        self.titleColor = titleColor
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.titleLabelAppearance = titleLabelAppearance
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.layerAppearance = layerAppearance
    }
}
