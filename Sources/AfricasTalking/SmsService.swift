//
//  SmsService.swift
//  AfricasTalkingPackageDescription
//
//  Created by Salama Balekage on 01/12/2017.
//
import Alamofire
import SwiftyJSON

public class SmsService: Service {
    
    internal override init() {
        super.init()
        baseUrl = "https://api.\(isSandbox ? Service.SANDBOX_DOMAIN : Service.PRODUCTION_DOMAIN)/version1"
    }
    
    private func _send(
        message: String,
        to:[String],
        from: String?,
        bulkSMSMode: Bool?,
        enqueue: Bool?,
        keyword: String?,
        linkId: String?,
        retryDurationInHours: Int?,
        callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/messaging"
        var params: Parameters = [
            "username": Service.USERNAME!,
            "message": message,
            "to": to.joined(separator: ","),
        ]
        
        if let from = from {
            params["from"] = from
        }
        
        if let bulkSMSMode = bulkSMSMode {
            params["bulkSMSMode"] = bulkSMSMode == true ? 1 : 0
        }
        
        if let enqueue = enqueue {
            params["enqueue"] = enqueue == true ? 1 : 0
        }
        
        if let keyword = keyword {
            params["keyword"] = keyword
        }
        
        if let linkId = linkId {
            params["linkId"] = linkId
        }
        
        if let retryDurationInHours = retryDurationInHours {
            params["retryDurationInHours"] = retryDurationInHours
        }
    
        
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
    
    public func send(message: String, to:[String], from: String? = nil, callback: @escaping AfricasTalking.Callback) {
        return self._send(message: message, to: to, from: from, bulkSMSMode:nil, enqueue:nil, keyword:nil, linkId:nil, retryDurationInHours:nil, callback: callback)
    }
    
    public func sendBulk(message: String, to:[String], from: String? = nil, callback: @escaping AfricasTalking.Callback) {
        return self._send(message: message, to: to, from: from, bulkSMSMode: true, enqueue:nil, keyword:nil, linkId:nil, retryDurationInHours:nil, callback: callback)
    }
    
    public func sendPremium(message: String, keyword: String, linkId: String, to:[String], from: String?, callback: @escaping AfricasTalking.Callback) {
        return self._send(message: message, to: to, from: from, bulkSMSMode: false, enqueue:nil, keyword: keyword, linkId: linkId, retryDurationInHours:nil, callback: callback)
    }
    
    public func fetchMessages(lastReceivedId: Int? = 0, callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/messaging"
        var params: Parameters = [
            "username": Service.USERNAME!,
        ]
        if let lastReceivedId = lastReceivedId {
            params["lastReceivedId"] = lastReceivedId
        }
        
        Alamofire.request(url, method: .get, parameters: params, headers: headers)
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
    
    public func fetchSubscriptions(lastReceivedId: Int? = 0, shortCode: String, keyword: String, callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/subscription"
        var params: Parameters = [
            "username": Service.USERNAME!,
            "shortCode": shortCode,
            "keyword": keyword
        ]
        
        if let lastReceivedId = lastReceivedId {
            params["lastReceivedId"] = lastReceivedId
        }
        
        Alamofire.request(url, method: .get, parameters: params, headers: headers)
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
    
    public func createSubscription(shortCode: String, keyword: String, phoneNumber: String, callback: @escaping AfricasTalking.Callback) {
        
        // Get checkout token first
        let tokenService = AfricasTalking.getTokenService()
        tokenService.createCheckoutToken(phoneNumber: phoneNumber) {error, data in
            if (error != nil) {
                return callback(error, nil)
            }
            
            let url = "\(self.baseUrl!)/subscription/create"
            let params: Parameters = [
                "username": Service.USERNAME!,
                "shortCode": shortCode,
                "keyword": keyword,
                "phoneNumber": phoneNumber,
                "checkoutToken": data!["token"]
            ]
            
            Alamofire.request(url, method: .post, parameters: params, headers: self.headers)
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
    
}
