//
//  TokenService.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 04/12/2017.
//

import Alamofire
import SwiftyJSON


public class TokenService: Service {
    
    internal override init() {
        super.init()
        baseUrl = "https://api.\(isSandbox ? Service.SANDBOX_DOMAIN : Service.PRODUCTION_DOMAIN)"
    }
    
    public func createCheckoutToken(phoneNumber: String, callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/checkout/token/create"
        let params: Parameters = [
            "phoneNumber": phoneNumber
        ]
        Alamofire.request(url, method: .post, parameters: params)
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
