import UIKit
import XCTest
import AppearanceKit

#if canImport(ContentKit)
import ContentKit

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    @available(iOS 10.0, *)
    func testScaledImage() {
        // This is an example of a functional test case.
        let size = CGSize(width: 100, height: 80)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image(actions: { (context: UIGraphicsImageRendererContext) in
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
        let any = AnyImage(image: image)
        let scaled = ScaledImage(any, scale: 0.5)
        let scaled2 = ScaledImage(any, toSize: AppearanceKit.Size(width: 10, height: 8))
        XCTAssertTrue(scaled.size.width == 50 && scaled.size.height == 40)
        XCTAssertTrue(scaled2.size.width == 10 && scaled2.size.height == 8)
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
