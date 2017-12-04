//
//  AirtimeService.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 04/12/2017.
//
import Alamofire
import SwiftyJSON


public class AirtimeService: Service {
    
    internal override init() {
        super.init()
        baseUrl = "https://api.\(isSandbox ? Service.SANDBOX_DOMAIN : Service.PRODUCTION_DOMAIN)/version1/airtime"
    }
    
    private func makeJSONRecipients(recipients: [[String: Any?]]) -> String {
        let formattedRecipients = recipients.map { (val: [String: Any?]) -> [String: Any?] in
            let currency = val["currencyCode"]
            let amount = val["amount"]
            var result: [String: Any?] = ["phoneNumber": val["phoneNumber"] ?? nil ]
            if (currency != nil) {
                result["amount"] = "\(currency!!) \(amount!!)"
            }
            return result
        }
        let json = JSON(formattedRecipients)
        return json.rawString([.castNilToNSNull: true ])!
    }
    
    public func send(to: String, currencyCode: String, amount:Double, callback: @escaping AfricasTalking.Callback) {
        return self.send(recipients: [ [ "phoneNumber": to, "currencyCode": currencyCode, "amount": amount ] ], callback: callback)
    }
    
    public func send(recipients: [[String: Any?]], callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/send"
        let params: Parameters = [
            "username": Service.USERNAME!,
            "recipients": makeJSONRecipients(recipients: recipients)
        ]
        Alamofire.request(url, method: .post, parameters: params, headers: headers)
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
}
