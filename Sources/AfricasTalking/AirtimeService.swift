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
    
    private func makeJSONRecipients(to: [[String: Any?]]) -> String {
        let json = JSON(to)
        return json.rawString([.castNilToNSNull: true ])!
    }
    
    public func send(to: String, amount: String, callback: @escaping AfricasTalking.Callback) {
        return self.send(to: [ [ "phoneNumber": to, "amount": amount ] ], callback: callback)
    }
    
    public func send(to: [[String: Any?]], callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/send"
        let params: Parameters = [
            "username": Service.USERNAME!,
            "recipients": makeJSONRecipients(to: to)
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
