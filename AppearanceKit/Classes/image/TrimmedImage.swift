//
//  TrimmedImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 24/08/2018.
//

import Foundation
import ContentKit

final public class TrimmedImage: ContentKit.Image {
    
    final private let decorated: ContentKit.Image
    
    public init(_ decorated: ContentKit.Image) {
        self.decorated = decorated
    }
    
    final public var image: UIImage {
        let image = self.decorated.image.trimmedImage()
        return image
    }
}

fileprivate extension UIImage {
    
    final func transparencyInsets(opaque: Bool) -> UIEdgeInsets {
        guard let cgImage = self.cgImage else { return UIEdgeInsets.zero }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerRow: Int = width * MemoryLayout<UInt8>.size
        
        let size = bytesPerRow * height
        let bitmapData = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        bitmapData.initialize(repeating: 0, count: size)
        defer { bitmapData.deallocate() }
        // alpha-only bitmap context
        guard let context = CGContext(data: bitmapData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: bytesPerRow,
                                      space: CGColorSpaceCreateDeviceGray(),
                                      bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue)
            else { return UIEdgeInsets.zero }
        let rect = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
        context.draw(cgImage, in: rect)
        
        // Sum all non-transparent pixels
        let rowSum = UnsafeMutableBufferPointer<UInt16>.allocate(capacity: height)
        rowSum.initialize(repeating: 0)
        defer { rowSum.deallocate() }
        let colSum = UnsafeMutableBufferPointer<UInt16>.allocate(capacity: width)
        colSum.initialize(repeating: 0)
        defer { colSum.deallocate() }
        
        for row in 0..<height {
            for col in 0..<width {
                let pixel = bitmapData[row * bytesPerRow + col]
                if opaque {
                    if pixel == UINT8_MAX {
                        rowSum[row] += UInt16(1)
                        colSum[col] += UInt16(1)
                    }
                }
                else {
                    if pixel != 0 {
                        rowSum[row] += UInt16(1)
                        colSum[col] += UInt16(1)
                    }
                }
            }
        }
        // find non-empty columns and row
        // find non-empty columns and row
        var cropInsets: UIEdgeInsets = UIEdgeInsets.zero
        let rowRange = (rowSum.startIndex..<rowSum.endIndex)
        let top = rowRange.first(where: { (index: Int) -> Bool in
            return rowSum[index] > 0
        }) ?? 0
        cropInsets.top = CGFloat(top)

        let bottom = rowRange.reversed().first(where: { (index: Int) -> Bool in
            return rowSum[index] > 0
        }) ?? 0
        cropInsets.bottom = CGFloat(rowRange.endIndex - bottom - 1)
        
        let colRange = (colSum.startIndex..<colSum.endIndex)
        let left = colRange.first(where: { (index: Int) -> Bool in
            return colSum[index] > 0
        }) ?? 0
        cropInsets.left = CGFloat(left)

        let right = colRange.reversed().first(where: { (index: Int) -> Bool in
            return colSum[index] > 0
        }) ?? 0
        cropInsets.right = CGFloat(max(0, colRange.endIndex - right - 1))
        return cropInsets
    }
    
    final func trimmedImage() -> UIImage {
        return self.trimmedImage(opaque: false)
    }
    
    final func trimmedImage(opaque: Bool) -> UIImage {
        if self.size.height < 2 || self.size.width < 2 {
            return self
        }
        
        let crop = self.transparencyInsets(opaque: opaque)
        if crop.top == 0 && crop.bottom == 0 && crop.left == 0 && crop.right == 0 {
            return self
        }
        else {
            let rect = CGRect(x: 0, y: 0, width: self.size.width * self.scale, height: self.size.height * self.scale)
            let cropRect = rect.inset(by: crop)
            if let cropped = self.cgImage?.cropping(to: cropRect) {
                let image = UIImage(cgImage: cropped,
                                    scale: self.scale,
                                    orientation: self.imageOrientation)
                return image
            }
        }
        return self
    }
}
