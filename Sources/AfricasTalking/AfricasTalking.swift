import Foundation
import Alamofire
import SwiftyJSON

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

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
                authHeader : authValue ?? "none",
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

public struct AfricasTalking {
    
    public typealias Callback = (_ error: String?, _ data: JSON?) -> Void
    
    private static var accountService: AccountService? = nil
    private static var airtimeService: AirtimeService? = nil
    private static var tokenService: TokenService? = nil
    
    private init() { }
    
    static func initialize(username: String, apiKey: String) {
        Service.USERNAME = username
        Service.API_KEY = apiKey
    }
    
    static func initialize(withHost host: String, andPort port: Int = 35897, butWithoutTls disableTls: Bool = false) {
        Service.HOST = host
        Service.PORT = port
        Service.DISABLE_TLS = disableTls
    }
 
    static func getAccountService() -> AccountService {
        if (accountService == nil) {
            accountService = AccountService()
        }
        return accountService!
    }
    
    static func getAirtimeService() -> AirtimeService {
        if (airtimeService == nil) {
            airtimeService = AirtimeService()
        }
        return airtimeService!
    }
    
    static func getTokenService() -> TokenService {
        if (tokenService == nil) {
            tokenService = TokenService()
        }
        return tokenService!
    }
}
