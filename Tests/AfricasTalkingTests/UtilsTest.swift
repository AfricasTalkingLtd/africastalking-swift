//
//  UtilsTest.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 07/12/2017.
//

import XCTest
@testable import AfricasTalking

class UtilsTests: XCTestCase {
    

    func testJSONSerializable() {
        
        let account = BankAccount(bankCode: BankCode.Access_NG, accountName: "Odeyola LeGrand",
                                  accountNumber: "4111111111111111", dateOfBirth: nil)
        //print(account.JSONRepresentation)
        //print(account.toJSON()!)
        let bankCode = account.JSONRepresentation["bankCode"] as! Int
        XCTAssertEqual(bankCode, 234003)
        
        let consumer = Consumer(name: "Bob G", phoneNumber: "0718769882", currencyCode: "KES",
                             amount: Double(arc4random_uniform(551) + 999), providerChannel: nil,
                             reason: REASON.SALARY, metadata: [:])
        
        //print(consumer.JSONRepresentation)
        //print(consumer.toJSON()!)
        let reason = consumer.JSONRepresentation["reason"] as! String
        XCTAssertEqual(reason, "SalaryPayment")
    }
    
    static var allTests = [
        ("testJSONSerializable", testJSONSerializable),
        ]
}
