//
//  VoiceService.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 04/12/2017.
//
import Alamofire
import SwiftyJSON


public class VoiceService: Service {
    
    internal override init() {
        super.init()
        baseUrl = "https://voice.\(isSandbox ? Service.SANDBOX_DOMAIN : Service.PRODUCTION_DOMAIN)"
    }
    
    public func makeCall(from: String, to: [String], callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/call"
        let params: Parameters = [
            "username": Service.USERNAME!,
            "from": from,
            "to": to.joined(separator: ",")
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
    
    public func queueStatus(phoneNumbers: [String], callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/queueStatus"
        let params: Parameters = [
            "username": Service.USERNAME!,
            "phoneNumbers": phoneNumbers.joined(separator: ",")
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
    
    public func mediaUpload(url: String, phoneNumber: String, callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/mediaUpload"
        let params: Parameters = [
            "username": Service.USERNAME!,
            "url": url,
            "phoneNumber": phoneNumber,
        ]
        var customHeaders = headers;
        customHeaders["Accept"] = "text/plain"
        Alamofire.request(url, method: .post, parameters: params, headers: customHeaders)
            .validate()
            .responseString { resp in
                switch(resp.result) {
                case .success:
                    let data = JSON(parseJSON: "{\"message\":\"\(resp.result.value!)\"}")
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

