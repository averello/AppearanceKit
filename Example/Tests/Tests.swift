import UIKit
import XCTest
import AppearanceKit

#if canImport(ContentKit)
import ContentKit

@available(iOS 10.0, *)
class Tests: XCTestCase {

    var base: UIImage!
    
    override func setUp() {
        super.setUp()

        let size = CGSize(width: 100, height: 80)
        let renderer = UIGraphicsImageRenderer(size: size)
        self.base = renderer.image(actions: { (context: UIGraphicsImageRendererContext) in
            let cgContext = context.cgContext
            cgContext.saveGState()
            defer { cgContext.restoreGState() }

            let rect = CGRect(origin: CGPoint.zero, size: size)

            let r1 = rect.divided(atDistance: 80/3, from: CGRectEdge.minYEdge)
            cgContext.setFillColor(UIColor.cyan.withAlphaComponent(0.65).cgColor)
            cgContext.fill(r1.slice)

            let r2 = r1.remainder.divided(atDistance: 80/3, from: CGRectEdge.minYEdge)
            cgContext.setFillColor(UIColor.magenta.withAlphaComponent(0.65).cgColor)
            cgContext.fill(r2.slice)

            cgContext.setFillColor(UIColor.yellow.withAlphaComponent(0.65).cgColor)
            cgContext.fill(r2.remainder)
        })
    }
    
    override func tearDown() {
        self.base = nil
        super.tearDown()
    }

    func testScaledImage() {
        let any = AnyImage(image: self.base)
        let scaled = ScaledImage(any, scale: 0.5)
        let scaled2 = ScaledImage(any, toSize: AppearanceKit.Size(width: 10, height: 8))
        XCTAssertTrue(scaled.size.width == 50 && scaled.size.height == 40)
        XCTAssertTrue(scaled2.size.width == 10 && scaled2.size.height == 8)
    }

    func testRotatedImageLeft() {
        let rotated = RotatedImage(self.base, rotation: .left)
        XCTAssertTrue(rotated.size.width == 80 && rotated.size.height == 100)
    }

    func testRotatedImageRight() {
        let rotated = RotatedImage(self.base, rotation: .right)
        XCTAssertTrue(rotated.size.width == 80 && rotated.size.height == 100)
    }

    func testRotatedImageArb1() {
        let rotated = RotatedImage(self.base, rotation: .arbitrary(-90))
        XCTAssertTrue(rotated.size.width == 80 && rotated.size.height == 100)
    }

    func testRotatedImageArb2() {
        let rotated = RotatedImage(self.base, rotation: .arbitrary(90))
        XCTAssertTrue(rotated.size.width == 80 && rotated.size.height == 100)
    }

    func testRotatedImageArb3() {
        let rotated = RotatedImage(self.base, rotation: .arbitrary(180))
        XCTAssertTrue(rotated.size.width == 100 && rotated.size.height == 80)
    }

    func testRotatedImageArb4() {
        let rotated = RotatedImage(self.base, rotation: .arbitrary(360))
        XCTAssertTrue(rotated.size.width == 100 && rotated.size.height == 80)
    }

    func testRotatedImageArb5() {
        let rotated = RotatedImage(self.base, rotation: .arbitrary(45))
        XCTAssertTrue(rotated.size.width.rounded(.down) == 127 && rotated.size.height.rounded(.down) == 127)
    }
    
    @available(iOS 10.0, *)
    func testTrimmed() {
        // This is an example of a functional test case.
        let size = CGSize(width: 100, height: 90)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image(actions: { (context: UIGraphicsImageRendererContext) in
            let cgContext = context.cgContext
            cgContext.saveGState()
            defer { cgContext.restoreGState() }
            
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            let r1 = rect.divided(atDistance: 90/3, from: CGRectEdge.minYEdge)
//            cgContext.setFillColor(UIColor.cyan.withAlphaComponent(0.65).cgColor)
//            cgContext.fill(r1.slice)
            
            let r2 = r1.remainder.divided(atDistance: 90/3, from: CGRectEdge.minYEdge)
            cgContext.setFillColor(UIColor.magenta.withAlphaComponent(0.65).cgColor)
            cgContext.fill(r2.slice)
            
            cgContext.setFillColor(UIColor.yellow.withAlphaComponent(0.65).cgColor)
            cgContext.fill(r2.remainder)
        })
        let any = AnyImage(image: image)
        let trimmed = TrimmedImage(any)
        let trimmedImage = trimmed.image
        print(trimmedImage)
    }
}

#endif /* ContentKit */
