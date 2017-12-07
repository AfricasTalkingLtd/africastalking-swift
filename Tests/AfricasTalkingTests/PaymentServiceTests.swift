//
//  PaymentServiceTests.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 06/12/2017.
//

import XCTest
@testable import AfricasTalking

class PaymentServiceTests: XCTestCase {
    
    lazy var paymentService: PaymentService = {
        return AfricasTalking.getPaymentService()
    }()
    
    override func setUp() {
        super.setUp()
        AfricasTalking.initialize(username: Fixtures.USERNAME, apiKey: Fixtures.API_KEY)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCheckoutMobile() {
        
        let expectation = XCTestExpectation(description: "Checkout Mobile")
        let req = MobileCheckoutRequest(productName: "TestProduct", currencyCode: "KES",
                                        amount: Double(arc4random_uniform(551) + 999), phoneNumber: "0718769882")
        paymentService.checkout(request: req) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            print(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCheckoutCard() {
        
        let expectation = XCTestExpectation(description: "Checkout Card")
        let card = PaymentCard(number: "4111111111111111", cvvNumber: 234, expiryMonth: 11, expiryYear: 2019,
                               countryCode: "NG", authToken: "1234")
        let req = CardCheckoutRequest(productName: "TestProduct", currencyCode: "KES",
                                      amount: Double(arc4random_uniform(551) + 999),
                                      narration: "Some desc", paymentCard: card)
        paymentService.checkout(request: req) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            print(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testValidateCheckoutCard() {
        let expectation = XCTestExpectation(description: "Validate Card Chechout")
        let req = ValidateCheckoutRequest(type: CheckoutType.CARD, transactionId: "dededededd", token: "dwedwedwedwed")
        paymentService.validateCheckout(request: req) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            print(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCheckoutBank() {
        
        let expectation = XCTestExpectation(description: "Checkout Bank")
        let account = BankAccount(bankCode: BankCode.Access_NG, accountName: "Odeyola LeGrand",
                                  accountNumber: "4111111111111111", dateOfBirth: nil)
        let req = BankCheckoutRequest(productName: "TestProduct", currencyCode: "KES",
                                      amount: Double(arc4random_uniform(551) + 999),
                                      bankAccount: account, narration: "Some desc")
        paymentService.checkout(request: req) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            print(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testValidateCheckoutBank() {
        let expectation = XCTestExpectation(description: "Validate Bank Chechout")
        let req = ValidateCheckoutRequest(type: CheckoutType.BANK, transactionId: "dededededd", token: "dwedwedwedwed")
        paymentService.validateCheckout(request: req) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            print(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMobileB2C() {
        
        let expectation = XCTestExpectation(description: "Mobile B2C")
        let consumers: [Consumer] = [
            Consumer(name: "Bob G", phoneNumber: "0718769882", currencyCode: "KES",
                     amount: Double(arc4random_uniform(551) + 999), providerChannel: nil,
                     reason: REASON.SALARY, metadata: [:]
            ),
            Consumer(name: "Sally", phoneNumber: "0718769881", currencyCode: "KES",
                     amount: Double(arc4random_uniform(551) + 999), providerChannel: "50000",
                     reason: REASON.BUSINESS_WITH_CHARGE, metadata: [:]
            )
        ]
        paymentService.mobileB2C(productName:"TestProduct", recipients: consumers) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            print(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMobileB2B() {
        
        let expectation = XCTestExpectation(description: "Mobile B2B")
        let business = Business(currencyCode: "KES", amount: Double(arc4random_uniform(551) + 999),
                                provider: PROVIDER.ATHENA, transferType: TRANSFER_TYPE.PAYBILL,
                                destinationChannel: "Bob G", destinationAccount: "0718769882", metadata: [:])
        paymentService.mobileB2B(productName:"TestProduct", recipient: business) { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            print(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    static var allTests = [
        ("testCheckoutMobile", testCheckoutMobile),
        ("testCheckoutCard", testCheckoutCard),
        ("testValidateCheckoutCard", testValidateCheckoutCard),
        ("testCheckoutBank", testCheckoutBank),
        ("testValidateCheckoutBank", testValidateCheckoutBank),
        ("testMobileB2C", testMobileB2C),
        ("testMobileB2B", testMobileB2B)
    ]
}

