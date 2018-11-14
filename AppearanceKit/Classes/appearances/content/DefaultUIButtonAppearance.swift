//
//  DefaultUIButtonAppearance.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 14/11/2018.
//

import Foundation


public struct DefaultUIButtonAppearance: UIButtonAppearance {
    public var font: Font? = SystemFont()
    public var titleColor: TextColor? = TextColor(normal: WhiteColor(), disabled: LightTextColor())
    public var backgroundColor: Color?
    public var tintColor: Color?

    public var layerAppearance: CAContentAppearance?

    public var shadowColor: TextColor?
    public var shadowOffset: AppearanceKit.Size?

    public var titleLabelAppearance: UILabelAppearance?

    public init(font: Font? = SystemFont(),
                titleColor: TextColor? = TextColor(normal: WhiteColor(), disabled: LightTextColor()),
                backgroundColor: Color? = nil,
                tintColor: Color? = nil,
                shadowColor: TextColor? = nil,
                shadowOffset: AppearanceKit.Size? = nil,
                titleLabelAppearance: UILabelAppearance? = nil,
                layerAppearance: CAContentAppearance? = nil) {
        self.font = font
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.titleLabelAppearance = titleLabelAppearance
        self.layerAppearance = layerAppearance
    }
}
