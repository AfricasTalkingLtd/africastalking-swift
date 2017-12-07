//
//  Service.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 07/12/2017.
//
import Foundation
import Alamofire

open class Service {
    
    internal static let PRODUCTION_DOMAIN = "africastalking.com"
    internal static let SANDBOX_DOMAIN = "sandbox.africastalking.com"
    internal static var HOST = "localhost"
    internal static var PORT = 35897
    
    internal static var DISABLE_TLS = false
    
    internal static var USERNAME: String? = nil
    internal static var API_KEY: String? = nil
    internal static var AUTH_TOKEN: Africastalking_ClientTokenResponse? = nil
    
    internal static let GrpcClient: Africastalking_SdkServerServiceService = {
        let address = "\(Service.HOST):\(Service.PORT)"
        if (Service.DISABLE_TLS) {
            return Africastalking_SdkServerServiceService(address: address)
        } else {
            return Africastalking_SdkServerServiceService(address: address, certificates: "", host: Service.HOST) // FIXME
        }
    }()
    
    internal var baseUrl: String? = nil
    
    internal var isSandbox: Bool {
        get {
            return Service.USERNAME == "sandbox"
        }
    }
    
    internal var headers: HTTPHeaders {
        get {
            let authHeader = Service.API_KEY != nil ? "apiKey" : "authToken"
            var authValue = Service.API_KEY
            if (authValue == nil) {
                if (Service.AUTH_TOKEN == nil || Service.AUTH_TOKEN!.expiration < Date().millisecondsSince1970) {
                    Service.fetchToken()
                }
                authValue = Service.AUTH_TOKEN?.token
            }
            
            return [
                authHeader : authValue ?? "not set",
                "Accept": "application/json"
            ]
        }
    }
    
    init() {
        if (Service.API_KEY == nil && Service.AUTH_TOKEN == nil) {
            // init token
            Service.fetchToken()
        }
    }
    
    private static func fetchToken() {
        do {
            let req = Africastalking_ClientTokenRequest()
            Service.AUTH_TOKEN = try Service.GrpcClient.gettoken(req)
            Service.USERNAME = Service.AUTH_TOKEN?.username ?? nil
        } catch { }
    }
    
}
