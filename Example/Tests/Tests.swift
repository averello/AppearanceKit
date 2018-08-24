import UIKit
import XCTest
import AppearanceKit
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
    func testExample() {
        // This is an example of a functional test case.
        let size = CGSize(width: 100, height: 80)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image(actions: { (context: UIGraphicsImageRendererContext) in
            let cgContext = context.cgContext
            cgContext.saveGState()
            defer { cgContext.restoreGState() }
            cgContext.setFillColor(UIColor.cyan.withAlphaComponent(0.65).cgColor)
            let rect = CGRect(origin: CGPoint.zero, size: size)
            cgContext.fill(rect)
        })
        let any = AnyImage(image: image)
        let scaled = ScaledImage(any, scale: 0.5)
        let scaledImage = scaled.image
        let scaled2 = ScaledImage(any, size: AppearanceKit.Size(width: 10, height: 8))
        let scaledImage2 = scaled2.image
        print(image)
        print(scaledImage)
        print(scaledImage2)
    }
}
