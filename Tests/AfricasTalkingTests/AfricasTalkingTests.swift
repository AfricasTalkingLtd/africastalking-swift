import XCTest
@testable import AfricasTalking

class AfricasTalkingTests: XCTestCase {
    
    func testInit() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        AfricasTalking.initialize(username: "sandbox", apiKey: "dede")
        XCTAssertEqual(AfricasTalking.getAccountService().isSandbox, true)
        AfricasTalking.initialize(username: "salama", apiKey: "dede")
        XCTAssertEqual(AfricasTalking.getAccountService().isSandbox, false)
    }


    static var allTests = [
        ("testInit", testInit),
    ]
}
