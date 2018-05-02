//
//  CGContextConfiguration.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 02/05/2018.
//

import Foundation

public extension CGContext {
    
    final public class Configuration {
        
        public struct Shadow {
            public let offset: CGSize
            public let blur: CGFloat
            public let color: Color?
        }
        public struct LineDash {
            public let phase: CGFloat
            public let lengths: [CGFloat]
        }
        
        public struct Pattern {
            public let pattern: CGPattern
            public let colorComponents: [CGFloat]
        }
        
        final public let lineWidth: CGFloat?
        final public let lineCap: CGLineCap?
        final public let lineJoin: CGLineJoin?
        final public let lineDash: LineDash?
        
        final public let miterLimit: CGFloat?
        final public let blendMode: CGBlendMode?
        final public let interpolationQuality: CGInterpolationQuality?
        
        final public let flatness: CGFloat?
        final public let alpha: CGFloat?
        
        final public let strokeColor: Color?
        final public let strokeColorSpace: CGColorSpace?
        final public let fillColor: Color?
        final public let fillColorSpace: CGColorSpace?
        
        final public let font: Font?
        
        final public let shadow: Shadow?
        final public let strokePattern: Pattern?
        final public let fillPattern: Pattern?
        final public let patternPhase: CGSize?
        
        final public let textPosition: CGPoint?
        final public let textDrawingMode: CGTextDrawingMode?
        final public let textMatrix: CGAffineTransform?
        
        final public let renderingIntent: CGColorRenderingIntent?
        
        final public let shouldAntialias: Bool?
        final public let allowsAntialiasing: Bool?
        
        final public let shouldSmoothFonts: Bool?
        final public let allowsFontSmoothing: Bool?
        
        final public let shouldSubpixelPositionFonts: Bool?
        final public let allowsFontSubpixelPositioning: Bool?
        
        final public let shouldSubpixelQuantizeFonts: Bool?
        final public let allowsFontSubpixelQuantization: Bool?
        
        public init(
            lineWidth: CGFloat? = 0,
            lineCap: CGLineCap? = nil,
            lineJoin: CGLineJoin? = nil,
            lineDash: LineDash? = nil,
            miterLimit: CGFloat? = nil,
            
            blendMode: CGBlendMode? = nil,
            interpolationQuality: CGInterpolationQuality? = nil,
            
            flatness: CGFloat? = nil,
            alpha: CGFloat? = nil,
            
            strokeColor: Color? = nil,
            strokeColorSpace: CGColorSpace? = nil,
            
            fillColor: Color? = nil,
            fillColorSpace: CGColorSpace? = nil,
            
            renderingIntent: CGColorRenderingIntent? = nil,
            
            font: Font? = nil,
            shadow: Shadow? = nil,
            
            fillPattern: Pattern? = nil,
            strokePattern: Pattern? = nil,
            patternPhase: CGSize? = nil,
            
            textPosition: CGPoint? = nil,
            textDrawingMode: CGTextDrawingMode? = nil,
            textMatrix: CGAffineTransform? = nil,
            
            shouldAntialias: Bool? = nil,
            allowsAntialiasing: Bool? = nil,
            
            shouldSmoothFonts: Bool? = nil,
            allowsFontSmoothing: Bool? = nil,
            
            shouldSubpixelPositionFonts: Bool? = nil,
            allowsFontSubpixelPositioning: Bool? = nil,
            
            shouldSubpixelQuantizeFonts: Bool? = nil,
            allowsFontSubpixelQuantization: Bool? = nil) {
            
            precondition((lineWidth ?? 0.0) >= 0.0)
            
            self.textDrawingMode                 = textDrawingMode
            self.interpolationQuality            = interpolationQuality
            self.blendMode                       = blendMode
            self.lineWidth                       = lineWidth
            self.lineCap                         = lineCap
            self.lineJoin                        = lineJoin
            self.miterLimit                      = miterLimit
            self.flatness                        = flatness
            self.alpha                           = alpha
            self.fillColor                       = fillColor
            self.strokeColor                     = strokeColor
            self.fillColorSpace                  = fillColorSpace
            self.strokeColorSpace                = strokeColorSpace
            self.patternPhase                    = patternPhase
            self.renderingIntent                 = renderingIntent
            self.textMatrix                      = textMatrix
            self.font                            = font
            self.shadow                          = shadow
            self.lineDash                        = lineDash
            self.textPosition                    = textPosition
            
            self.shouldAntialias                 = shouldAntialias
            self.allowsAntialiasing              = allowsAntialiasing
            
            self.shouldSmoothFonts               = shouldSmoothFonts
            self.allowsFontSmoothing             = allowsFontSmoothing
            
            self.shouldSubpixelPositionFonts     = shouldSubpixelPositionFonts
            self.allowsFontSubpixelPositioning   = allowsFontSubpixelPositioning
            
            self.shouldSubpixelQuantizeFonts     = shouldSubpixelQuantizeFonts
            self.allowsFontSubpixelQuantization  = allowsFontSubpixelQuantization
            
            self.strokePattern                   = strokePattern
            self.fillPattern                     = fillPattern
        }
    }
}

public extension CGContext.Configuration {
    
    public func configure(context: CGContext) {
        if let textDrawingMode = self.textDrawingMode {
            context.setTextDrawingMode(textDrawingMode)
        }
        if let interpolationQuality = self.interpolationQuality {
            context.interpolationQuality = interpolationQuality
        }
        if let blendMode = self.blendMode {
            context.setBlendMode(blendMode)
        }
        if let lineWidth = self.lineWidth {
            context.setLineWidth(lineWidth)
        }
        if let lineCap = self.lineCap {
            context.setLineCap(lineCap)
        }
        if let lineJoin = self.lineJoin {
            context.setLineJoin(lineJoin)
        }
        if let miterLimit = self.miterLimit {
            context.setMiterLimit(miterLimit)
        }
        if let flatness = self.flatness {
            context.setFlatness(flatness)
        }
        if let alpha = self.alpha {
            context.setAlpha(alpha)
        }
        if let fillColor = self.fillColor {
            context.setFillColor(fillColor.color.cgColor)
        }
        if let strokeColor = self.strokeColor {
            context.setStrokeColor(strokeColor.color.cgColor)
        }
        if let fillColorSpace = self.fillColorSpace {
            context.setFillColorSpace(fillColorSpace)
        }
        if let strokeColorSpace = self.strokeColorSpace {
            context.setStrokeColorSpace(strokeColorSpace)
        }
        if let patternPhase = self.patternPhase {
            context.setPatternPhase(patternPhase)
        }
        if let renderingIntent = self.renderingIntent {
            context.setRenderingIntent(renderingIntent)
        }
        if let textMatrix = self.textMatrix {
            context.textMatrix = textMatrix
        }
        if let font = self.font {
            let uifont = font.font
            let fontName = uifont.fontName as CFString
            if let cgFont = CGFont(fontName) {
                context.setFont(cgFont)
                context.setFontSize(CGFloat(font.fontSize))
            }
        }
        if let shadow = self.shadow {
            context.setShadow(offset: shadow.offset,
                              blur: shadow.blur,
                              color: shadow.color?.color.cgColor)
        }
        if let lineDash = self.lineDash {
            context.setLineDash(phase: lineDash.phase, lengths: lineDash.lengths)
        }
        if let textPosition = self.textPosition {
            context.textPosition = textPosition
        }
        
        if let shouldAntialias = self.shouldAntialias {
            context.setShouldAntialias(shouldAntialias)
        }
        if let allowsAntialiasing = self.allowsAntialiasing {
            context.setAllowsAntialiasing(allowsAntialiasing)
        }
        
        if let shouldSmoothFonts = self.shouldSmoothFonts {
            context.setShouldSmoothFonts(shouldSmoothFonts)
        }
        if let allowsFontSmoothing = self.allowsFontSmoothing {
            context.setAllowsFontSmoothing(allowsFontSmoothing)
        }
        
        if let shouldSubpixelPositionFonts = self.shouldSubpixelPositionFonts {
            context.setShouldSubpixelPositionFonts(shouldSubpixelPositionFonts)
        }
        if let allowsFontSubpixelPositioning = self.allowsFontSubpixelPositioning {
            context.setAllowsFontSubpixelPositioning(allowsFontSubpixelPositioning)
        }
        
        if let shouldSubpixelQuantizeFonts = self.shouldSubpixelQuantizeFonts {
            context.setShouldSubpixelQuantizeFonts(shouldSubpixelQuantizeFonts)
        }
        if let allowsFontSubpixelQuantization = self.allowsFontSubpixelQuantization {
            context.setAllowsFontSubpixelQuantization(allowsFontSubpixelQuantization)
        }
        
        if let strokePattern = self.strokePattern {
            let components = strokePattern.colorComponents
            context.setStrokePattern(strokePattern.pattern,
                                     colorComponents: components)
        }
        if let fillPattern = self.fillPattern {
            let components = fillPattern.colorComponents
            context.setFillPattern(fillPattern.pattern, colorComponents: components)
        }
    }
}

