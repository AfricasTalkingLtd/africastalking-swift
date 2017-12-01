//
//  AccountServiceTests.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 01/12/2017.
//

import XCTest
@testable import AfricasTalking

class AccountServiceTests: XCTestCase {
    
    lazy var accountService: AccountService = {
        return AfricasTalking.getAccountService()
    }()
    
    override func setUp() {
        super.setUp()
        AfricasTalking.initialize(username: "sandbox", apiKey: "f9d6e02ccb75a634c49231b6b1f8b19eabfca4ae63df9659cfe3a15bad27fa43")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetUserData() {
        
        let expectation = XCTestExpectation(description: "Gets user balance")
        
        accountService.getUserData { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            print(data)
            if (data != nil) {
                XCTAssertEqual(data!.balance.starts(with: "KES"), true)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    static var allTests = [
        ("testGetUserData", testGetUserData),
    ]
}

