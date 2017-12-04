//
//  TokenServiceTests.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 04/12/2017.
//

import XCTest
@testable import AfricasTalking

class TokenServiceTests: XCTestCase {
    
    lazy var service: TokenService = {
        return AfricasTalking.getTokenService()
    }()
    
    override func setUp() {
        super.setUp()
        AfricasTalking.initialize(username: Fixtures.USERNAME, apiKey: Fixtures.API_KEY)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateCheckoutToken() {
        
        let expectation = XCTestExpectation(description: "Creates checkout token")
        
        service.createCheckoutToken(phoneNumber: "0718769882") { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if (data != nil) {
                XCTAssertNotNil(data!["token"])
                XCTAssertEqual(data!["description"], "Success")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    static var allTests = [
        ("testCreateCheckoutToken", testCreateCheckoutToken),
    ]
}
