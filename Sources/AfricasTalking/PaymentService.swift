//
//  PaymentService.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 06/12/2017.
//
import Alamofire
import SwiftyJSON

public enum CheckoutType {
    case CARD
    case BANK
    case MOBILE
}

public enum REASON: String {
    case SALARY = "SalaryPayment"
    case SALARY_WITH_CHARGE = "SalaryPaymentWithWithdrawalChargePaid"
    case BUSINESS = "BusinessPayment"
    case BUSINESS_WITH_CHARGE = "BusinessPaymentWithWithdrawalChargePaid"
    case PROMISION = "PromotionPayment"
}

public enum PROVIDER: String {
    case MPESA = "Mpesa"
    case ATHENA = "Athena"
}

public enum TRANSFER_TYPE: String {
    case BUYGOODS = "BusinessBuyGoods"
    case PAYBILL = "BusinessPayBill"
    case DISBURSE = "DisburseFundsToBusiness"
    case B2B = "BusinessToBusinessTransfer"
}

public enum BankCode: Int {
    case FCMB_NG = 234001
    case Zenith_NG = 234002
    case Access_NG = 234003
    case GTBank_NG = 234004
    case Ecobank_NG = 234005
    case Diamond_NG = 234006
    case Providus_NG = 234007
    case Unity_NG = 234008
    case Stanbic_NG = 234009
    case Sterling_NG = 234010
    case Parkway_NG = 234011
    case Afribank_NG = 234012
    case Enterprise_NG = 234013
    case Fidelity_NG = 234014
    case Heritage_NG = 234015
    case Keystone_NG = 234016
    case Skye_NG = 234017
    case Stanchart_NG = 234018
    case Union_NG = 234019
    case Uba_NG = 234020
    case Wema_NG = 234021
    case First_NG = 234022
    case CBA_KE = 254001
    case UNKNOWN = -1
}

public struct PaymentCard: JSONSerializable {
    var number: String
    var cvvNumber: Int
    var expiryMonth: Int
    var expiryYear: Int
    var countryCode: String
    var authToken: String
}

public struct BankAccount: JSONSerializable {
    var bankCode: BankCode
    var accountName: String
    var accountNumber: String
    var dateOfBirth: String? = nil
}

public struct Consumer: JSONSerializable {
    var name: String
    var phoneNumber: String
    var currencyCode: String
    var amount: Double
    var providerChannel: String? = nil
    var reason: REASON
    var metadata: [String:String] = [:]
}

public struct Business: JSONSerializable {
    var currencyCode: String
    var amount: Double
    var provider: PROVIDER
    var transferType: TRANSFER_TYPE
    var destinationChannel: String
    var destinationAccount: String? = nil
    var metadata: [String:String] = [:]
}

public class CheckoutRequest {
    var type: CheckoutType
    var productName: String
    var amount: Double
    var currencyCode: String
    var narration: String? = nil
    var metadata: [String: String] = [:]
    
    internal init(type: CheckoutType, productName: String, currencyCode: String, amount: Double,
                  narration: String?, metadata: [String:String] = [:]) {
        self.type = type
        self.productName = productName
        self.amount = amount
        self.currencyCode = currencyCode
        self.narration = narration
        self.metadata = metadata
    }
}

public class MobileCheckoutRequest: CheckoutRequest {
    var providerChannel: String? = nil
    var phoneNumber: String
    public init(productName: String, currencyCode: String, amount: Double,
                phoneNumber: String, providerChannel: String? = nil) {
        self.phoneNumber = phoneNumber
        self.providerChannel = providerChannel
        super.init(type: CheckoutType.MOBILE, productName: productName,
                   currencyCode: currencyCode, amount: amount, narration: nil)
    }
}

public class CardCheckoutRequest: CheckoutRequest {
    var paymentCard: PaymentCard? = nil
    var checkoutToken: String? = nil
    public init(productName: String, currencyCode: String, amount: Double,
                narration: String, paymentCard: PaymentCard? = nil, checkoutToken: String? = nil) {
        self.paymentCard = paymentCard
        self.checkoutToken = checkoutToken
        super.init(type: CheckoutType.CARD, productName: productName,
                   currencyCode: currencyCode, amount: amount, narration: narration)
    }
}

public class BankCheckoutRequest: CheckoutRequest {
    var bankAccount: BankAccount
    public init(productName: String, currencyCode: String, amount: Double, bankAccount: BankAccount, narration: String) {
        self.bankAccount = bankAccount
        super.init(type: CheckoutType.BANK, productName: productName,
                   currencyCode: currencyCode, amount: amount, narration: narration)
    }
}

public class ValidateCheckoutRequest {
    var type: CheckoutType
    var transactionId: String
    var token: String
    
    public init(type: CheckoutType, transactionId: String, token: String) {
        self.type = type
        self.transactionId = transactionId
        self.token = token
    }
}

public class PaymentService: Service {
    
    internal override init() {
        super.init()
        baseUrl = "https://payments.\(isSandbox ? Service.SANDBOX_DOMAIN : Service.PRODUCTION_DOMAIN)"
    }
    
    private func makeCheckoutRequestBody(req: CheckoutRequest) -> Parameters {
        return [
            "username": Service.USERNAME!,
            "productName": req.productName,
            "amount": req.amount,
            "currencyCode": req.currencyCode,
            "metadata": req.metadata,
            "narration": req.narration ?? "none"
        ]
    }
    
    private func postJSON(url: String, data: Parameters, callback: @escaping AfricasTalking.Callback) {
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseString { resp in
                switch(resp.result) {
                case .success:
                    let data = JSON(parseJSON: resp.result.value!)
                    callback(nil, data)
                case .failure:
                    var body: String? = nil
                    if (resp.data != nil) {
                        body = String(data: resp.data!, encoding: String.Encoding.utf8) as String?
                    }
                    let message =  body ?? resp.error?.localizedDescription ?? "Unexpected error"
                    callback(message, nil)
                }
        }
    }
        
    
    public func checkout(request: CheckoutRequest, callback: @escaping AfricasTalking.Callback) {
        var url: String
        var params = self.makeCheckoutRequestBody(req: request as CheckoutRequest)
        
        switch request.type {
        case .MOBILE:
            url = "\(baseUrl!)/mobile/checkout/request"
            let rq = request as! MobileCheckoutRequest
            params["phoneNumber"] = rq.phoneNumber
            if let providerChannel = rq.providerChannel {
                params["providerChannel"] = providerChannel
            }
            break
        case .CARD:
            url = "\(baseUrl!)/card/checkout/charge"
            let rq = request as! CardCheckoutRequest
            if rq.paymentCard != nil {
                params["paymentCard"] = rq.paymentCard?.JSONRepresentation ?? [:]
            } else {
                params["checkoutToken"] = rq.checkoutToken ?? ""
            }
            break
        case .BANK:
            url = "\(baseUrl!)/bank/checkout/charge"
            params["bankAccount"] = (request as! BankCheckoutRequest).bankAccount.JSONRepresentation
            break
        }
        
        return self.postJSON(url: url, data: params, callback: callback)
    }
    
    public func validateCheckout(request: ValidateCheckoutRequest, callback: @escaping AfricasTalking.Callback) {
        var url: String
        let data = [
            "username": Service.USERNAME!,
            "transactionId": request.transactionId,
            "otp": request.token
        ]
        switch request.type {
        case .CARD:
            url = "\(baseUrl!)/card/checkout/validate"
            break
        case .BANK:
            url = "\(baseUrl!)/bank/checkout/validate"
            break
        default:
            return callback("Unsupported or invalid checkout type", nil)
        }
        
        return self.postJSON(url: url, data: data, callback: callback)
    }
    
    public func mobileB2C(productName: String, recipients: [Consumer], callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/mobile/b2c/request"
        let data: Parameters = [
            "username": Service.USERNAME!,
            "productName": productName,
            "recipients": recipients.map({ (consumer: Consumer) -> [String:Any] in
                return consumer.JSONRepresentation
            })
        ]
        return self.postJSON(url: url, data: data, callback: callback)
    }
    
    public func mobileB2B(productName: String, recipient: Business, callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/mobile/b2b/request"
        let data: Parameters = [
            "username": Service.USERNAME!,
            "productName": productName,
            "currencyCode": recipient.currencyCode,
            "amount": recipient.amount,
            "provider": recipient.provider.rawValue,
            "transferType": recipient.transferType.rawValue,
            "destinationChannel": recipient.destinationChannel,
            "destinationAccount": recipient.destinationAccount ?? "",
            "metadata": recipient.metadata
        ]
        return self.postJSON(url: url, data: data, callback: callback)
    }
    
}
