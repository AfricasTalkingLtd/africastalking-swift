//
//  AirtimeServiceTests.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 04/12/2017.
//


import XCTest
@testable import AfricasTalking

class AirtimeServiceTests: XCTestCase {
    
    lazy var service: AirtimeService = {
        return AfricasTalking.getAirtimeService()
    }()
    
    override func setUp() {
        super.setUp()
        AfricasTalking.initialize(username: Fixtures.USERNAME, apiKey: Fixtures.API_KEY)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSend() {
        
        let expectation = XCTestExpectation(description: "Sends airtime to one recipient")
        
        service.send(to: "+254718769882", amount: "KES \(Double(arc4random_uniform(51) + 50))") { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if (data != nil) {
                XCTAssertEqual(data!["numSent"].intValue, 1)
                XCTAssertEqual(data!["responses"][0]["status"].stringValue, "Sent")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSendMultiple() {
        
        let expectation = XCTestExpectation(description: "Sends airtime to many recipient")
        let recipients = [
            ["phoneNumber": "254718769882", "amount": "KES \(Double(arc4random_uniform(51) + 50))" ],
            ["phoneNumber": "254718769881", "amount": "KES \(Double(arc4random_uniform(51) + 50))"]
        ]
        service.send(to: recipients) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if (data != nil) {
                XCTAssertEqual(data!["numSent"].intValue, 2)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    static var allTests = [
        ("testSend", testSend),
        ("testSendMultiple", testSendMultiple),
    ]
}
