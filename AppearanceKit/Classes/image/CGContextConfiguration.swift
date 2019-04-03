//
//  CGContextConfiguration.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 02/05/2018.
//

import Foundation

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGContext {
    
    /// A `CGContext`'s configuration.
    final class Configuration {
        
        /// The shadow the context should use.
        public struct Shadow {
            /// The shadow offset in base-space.
            public let offset: CGSize
            /// The non-negative blur radius of the shadow in points.
            public let blur: CGFloat
            /// The color of the shadow. If `nil` shadowing is disabled.
            public let color: Color?
        }
        /// The line dash pattern for drawing dashed lines.
        public struct LineDash {
            /// A value that specifies how far into the dash pattern the line
            /// starts, in units of the user space. For example, a value of 0
            /// draws a line starting with the beginning of a dash pattern, and
            /// a value of 3 means the line is drawn with the dash pattern
            /// starting at three units from its beginning.
            public let phase: CGFloat
            /// An array of values that specify the lengths, in user space
            /// coordinates, of the painted and unpainted segments of the dash
            /// pattern.
            ///
            /// For example, the array [2,3] sets a dash pattern that alternates
            /// between a 2-unit-long painted segment and a 3-unit-long
            /// unpainted segment. The array [1,3,4,2] sets the pattern to a
            /// 1-unit painted segment, a 3-unit unpainted segment, a 4-unit
            /// painted segment, and a 2-unit unpainted segment.Pass an empty
            /// array to clear the dash pattern so that all stroke drawing in
            /// the context uses solid lines.
            public let lengths: [CGFloat]
        }
        /// The stroke pattern the context should use.
        public struct Pattern {
            /// A pattern for stroking.
            ///
            /// The current stroke color space must be a pattern color space.
            /// Otherwise, the result of calling this function is undefined.
            public let pattern: CGPattern
            /// If the specified pattern is an uncolored (or masking) pattern,
            /// pass an array of intensity values that specify the color to use
            /// when the pattern is painted. The number of array elements must
            /// equal the number of components in the base space of the stroke
            /// pattern color space, plus an additional component for the alpha
            /// value.
            /// If the specified pattern is a colored pattern, pass an alpha
            /// value.
            public let colorComponents: [CGFloat]
        }
        
        /// Sets the line width for a graphics context.
        ///
        /// The default line width is 1 unit. When stroked, the line straddles
        /// the path, with half of the total width on either side.
        ///
        /// The value must be greater than 0.
        final public let lineWidth: CGFloat?
        /// Sets the style for the endpoints of lines drawn in a graphics
        /// context.
        ///
        /// A line cap style constant—CGLineCap.butt (the default),
        /// CGLineCap.round, or CGLineCap.square. See CGPath.
        final public let lineCap: CGLineCap?
        /// Sets the style for the joins of connected lines in a graphics
        /// context.
        ///
        /// A line join value—CGLineJoin.miter (the default), CGLineJoin.round,
        /// or CGLineJoin.bevel. See CGPath.
        final public let lineJoin: CGLineJoin?
        /// Sets the pattern for drawing dashed lines.
        final public let lineDash: LineDash?
        /// Sets the miter limit for the joins of connected lines in a graphics
        /// context.
        ///
        /// If the current line join style is set to CGLineJoin.miter, the miter
        /// limit determines whether the lines should be joined with a bevel
        /// instead of a miter. The length of the miter is divided by the line
        /// width. If the result is greater than the miter limit, the style is
        /// converted to a bevel.
        final public let miterLimit: CGFloat?
        /// Sets how sample values are composited by a graphics context.
        ///
        /// A blend mode. See CGBlendMode for a list of the constants you can
        /// supply.
        final public let blendMode: CGBlendMode?
        /// Sets the current level of interpolation quality for a graphics
        /// context.
        ///
        /// Interpolation quality is a graphics state parameter that provides a
        /// hint for the level of quality to use for image interpolation (for
        /// example, when scaling the image). Not all contexts support all
        /// interpolation quality levels.
        final public let interpolationQuality: CGInterpolationQuality?
        /// Sets the accuracy of curved paths in a graphics context.
        ///
        /// This function controls how accurately curved paths are rendered.
        /// Setting the flatness value to less than 1.0 renders highly accurate
        /// curves, but lengthens rendering times.
        ///
        /// In most cases, you should not change the flatness value. Customizing
        /// the flatness value for the capabilities of a particular output
        /// device impairs the ability of your application to render to other
        /// devices.
        final public let flatness: CGFloat?
        /// Sets the opacity level for objects drawn in a graphics context.
        ///
        /// Sets the alpha value parameter for the specified graphics context. A
        /// value that specifies the opacity level. Values can range from 0.0
        /// (transparent) to 1.0 (opaque). Values outside this range are clipped
        /// to 0.0 or 1.0.
        final public let alpha: CGFloat?
        /// Sets the current stroke color in a context, using a
        /// `Appearance.Color`.
        final public let strokeColor: Color?
        /// Sets the stroke color space in a graphics context.
        ///
        /// As a side effect when you call this function, Core Graphics assigns
        /// an appropriate initial value to the stroke color, based on the color
        /// space you specify.
        final public let strokeColorSpace: CGColorSpace?
        /// Sets the current fill color in a graphics context, using a
        /// `AppearanceKit.Color`.
        final public let fillColor: Color?
        /// Sets the fill color space in a graphics context.
        ///
        /// As a side effect of this function, Core Graphics assigns an
        /// appropriate initial value to the fill color, based on the specified
        /// color space.
        final public let fillColorSpace: CGColorSpace?
        
        /// Sets the platform font in a graphics context.
        final public let font: Font?
        
        /// Enables shadowing with color a graphics context.
        final public let shadow: Shadow?
        /// Sets the stroke pattern in the specified graphics context.
        ///
        /// The current stroke color space must be a pattern color space.
        /// Otherwise, the result of setting this property is undefined.
        final public let strokePattern: Pattern?
        /// Sets the fill pattern in the specified graphics context.
        ///
        /// The current fill color space must be a pattern color space.
        /// Otherwise, the result of setting this property is undefined.
        final public let fillPattern: Pattern?
        /// Sets the pattern phase of a context.
        ///
        /// The pattern phase is a translation that Core Graphics applies prior
        /// to drawing a pattern in the context. The pattern phase is part of
        /// the graphics state of a context, and the default pattern phase is
        /// (0,0). Setting the pattern phase has the effect of temporarily
        /// changing the pattern matrix of any pattern you draw. For example,
        /// setting the context’s pattern phase to (2,3) has the effect of
        /// moving the start of pattern cell tiling to the point (2,3) in
        /// default user space.
        final public let patternPhase: CGSize?
        
        /// Sets the location at which text is drawn.
        ///
        /// A point that specifies the x and y values at which text is to be
        /// drawn, in user space coordinates.
        final public let textPosition: CGPoint?
        /// Sets the current text drawing mode.
        ///
        /// A text drawing mode (such as CGTextDrawingMode.fill or
        /// CGTextDrawingMode.stroke) that specifies how Core Graphics renders
        /// individual glyphs in a graphics context. See CGTextDrawingMode for a
        /// complete list.
        final public let textDrawingMode: CGTextDrawingMode?
        /// Sets the current text matrix.
        final public let textMatrix: CGAffineTransform?
        
        /// Sets the rendering intent in the current graphics state.
        ///
        /// The rendering intent specifies how to handle colors that are not
        /// located within the gamut of the destination color space of a
        /// graphics context. If you do not explicitly set the rendering intent,
        /// Core Graphics uses perceptual rendering intent when drawing sampled
        /// images and relative colorimetric rendering intent for all other
        /// drawing.
        final public let renderingIntent: CGColorRenderingIntent?
        
        /// Sets antialiasing on or off for a graphics context.
        final public let shouldAntialias: Bool?
        /// Sets whether or not to allow antialiasing for a graphics context.
        ///
        /// Core Graphics performs antialiasing for a graphics context if both
        /// the allowsAntialiasing parameter and the graphics state parameter
        /// shouldAntialias are `true`.
        final public let allowsAntialiasing: Bool?
        
        /// Enables or disables font smoothing in a graphics context.
        ///
        /// There are cases, such as rendering to a bitmap, when font smoothing is not appropriate and should be disabled. Note that some contexts (such as PostScript contexts) do not support font smoothing.
        ///
        /// This parameter is part of the graphics state. Because of this, you
        /// use this when you want to temporarily override this setting in a
        /// drawing method.
        final public let shouldSmoothFonts: Bool?
        /// Sets whether or not to allow font smoothing for a graphics context.
        ///
        /// Font are smoothed if they are antialiased when drawn and if font
        /// smoothing is both allowed and enabled. For information on how to
        /// enable font smoothing, see the `shouldSmoothFonts` property. It is
        /// not usually necessary to make changes to both parameters at the same
        /// time; either can be used to disable font smoothing.
        final public let allowsFontSmoothing: Bool?
        
        /// Enables or disables subpixel positioning in a graphics context.
        ///
        /// When enabled, the graphics context may position glyphs on
        /// nonintegral pixel boundaries. When disabled, the position of glyphs
        /// are always forced to integral pixel boundaries.
        final public let shouldSubpixelPositionFonts: Bool?
        /// Sets whether or not to allow subpixel positioning for a graphics
        /// context.
        /// Sub-pixel positioning is used by the graphics context if it is
        /// allowed, enabled, and if the font itself is antialiased when drawn.
        /// For information on how to enable subpixel positioning, see the
        /// `shouldSubpixelPositionFonts` property.
        final public let allowsFontSubpixelPositioning: Bool?
        
        /// Enables or disables subpixel quantization in a graphics context.
        ///
        /// When enabled, the graphics context may quantize the subpixel
        /// positions of glyphs.
        final public let shouldSubpixelQuantizeFonts: Bool?
        /// Sets whether or not to allow subpixel quantization for a graphics
        /// context.
        ///
        /// Sub-pixel quantization is used by the graphics context if it is
        /// allowed, enabled, and if glyphs would be drawn at subpixel
        /// positions. For information on how to enable subpixel quantization,
        /// see the `shouldSubpixelQuantizeFonts` function.
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
            
            self.textDrawingMode = textDrawingMode
            self.interpolationQuality = interpolationQuality
            self.blendMode = blendMode
            self.lineWidth = lineWidth
            self.lineCap = lineCap
            self.lineJoin = lineJoin
            self.miterLimit = miterLimit
            self.flatness = flatness
            self.alpha = alpha
            self.fillColor = fillColor
            self.strokeColor = strokeColor
            self.fillColorSpace = fillColorSpace
            self.strokeColorSpace = strokeColorSpace
            self.patternPhase = patternPhase
            self.renderingIntent = renderingIntent
            self.textMatrix = textMatrix
            self.font = font
            self.shadow = shadow
            self.lineDash = lineDash
            self.textPosition = textPosition
            
            self.shouldAntialias = shouldAntialias
            self.allowsAntialiasing = allowsAntialiasing
            
            self.shouldSmoothFonts = shouldSmoothFonts
            self.allowsFontSmoothing = allowsFontSmoothing
            
            self.shouldSubpixelPositionFonts = shouldSubpixelPositionFonts
            self.allowsFontSubpixelPositioning = allowsFontSubpixelPositioning
            
            self.shouldSubpixelQuantizeFonts = shouldSubpixelQuantizeFonts
            self.allowsFontSubpixelQuantization = allowsFontSubpixelQuantization
            
            self.strokePattern = strokePattern
            self.fillPattern = fillPattern
        }
    }
}

public extension CGContext.Configuration {
    
    /// Configures a `CGContext` with the receiver.
    func configure(context: CGContext) {
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
#endif
