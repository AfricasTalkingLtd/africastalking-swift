//
//  VoiceServiceTests.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 04/12/2017.
//

import XCTest
@testable import AfricasTalking

class VoiceServiceTests: XCTestCase {
    
    lazy var service: VoiceService = {
        return AfricasTalking.getVoiceService()
    }()
    
    override func setUp() {
        super.setUp()
        AfricasTalking.initialize(username: Fixtures.USERNAME, apiKey: Fixtures.API_KEY)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMakeCall() {
        
        let expectation = XCTestExpectation(description: "Initiates an outbound call")
        
        service.makeCall(from: "+254718769882", to: ["0718769881"]) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if (data != nil) {
                XCTAssertNotNil(data!["status"])
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testQueueStatus() {
        
        let expectation = XCTestExpectation(description: "Initiates an outbound call")
        
        service.queueStatus(phoneNumbers: ["0718769882"]) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMediaUpload() {
        
        let expectation = XCTestExpectation(description: "Initiates an outbound call")
        
        service.mediaUpload(url: "htps://fake.news.media.mp3", phoneNumber: "+254718769882") { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    static var allTests = [
        ("testMakeCall", testMakeCall),
        ("testQueueStatus", testQueueStatus),
        ("testMediaUpload", testMediaUpload)
    ]
}
