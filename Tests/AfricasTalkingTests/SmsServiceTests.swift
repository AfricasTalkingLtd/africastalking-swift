//
//  SmsServiceTests.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 04/12/2017.
//

import XCTest
@testable import AfricasTalking

class SmsServiceTests: XCTestCase {
    
    lazy var service: SmsService = {
        return AfricasTalking.getSmsService()
    }()
    
    override func setUp() {
        super.setUp()
        AfricasTalking.initialize(username: Fixtures.USERNAME, apiKey: Fixtures.API_KEY)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSend() {
        
        let expectation = XCTestExpectation(description: "Sends an SMS")
        
        service.send(message: "Hi There!", to: ["0718768772"]) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if (data != nil) {
                XCTAssertEqual(data!["SMSMessageData"]["Recipients"][0]["status"].stringValue, "Success")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSendBulk() {
        
        let expectation = XCTestExpectation(description: "Sends an SMS")
        
        service.sendBulk(message: "Hi There!", to: ["0718768772"]) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if (data != nil) {
                XCTAssertEqual(data!["SMSMessageData"]["Recipients"][0]["status"].stringValue, "Success")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSendPremium() {
        
        let expectation = XCTestExpectation(description: "Sends a premium SMS")
        
        service.sendPremium(message: "Hi There!", keyword: "test", linkId: "someLinkId", to: ["0718768772"], from: "AT2FA") { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if (data != nil) {
                XCTAssertEqual(data!["SMSMessageData"]["Recipients"][0]["status"].stringValue, "Success")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchMessages() {
        
        let expectation = XCTestExpectation(description: "Fetches message inbox")
        
        service.fetchMessages(lastReceivedId: nil) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchSubscriptions() {
        
        let expectation = XCTestExpectation(description: "Fetches premium subscriptions")
        
        service.fetchSubscriptions(shortCode: "2222", keyword: "test"){ error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCreateSubscription() {
        
        let expectation = XCTestExpectation(description: "Sends a premium SMS")
        
        service.createSubscription(shortCode: "20022", keyword: "test", phoneNumber: "0718768772") { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    static var allTests = [
        ("testSend", testSend),
        ("testSendBulk", testSendBulk),
        ("testSendPremium", testSendPremium),
        ("testFetchMessages", testFetchMessages),
        ("testFetchSubscription", testFetchSubscriptions),
        ("testCreateSubscription", testCreateSubscription),
    ]
}


