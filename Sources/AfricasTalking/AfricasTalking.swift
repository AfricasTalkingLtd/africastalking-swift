import Alamofire

open class Service {
    
    internal static let PRODUCTION_DOMAIN = "africastalking.com"
    internal static let SANDBOX_DOMAIN = "sandbox.africastalking.com"
    internal static var HOST = "localhost"
    internal static var PORT = 35897
    
    internal static var DISABLE_TLS = false
    
    internal static var USERNAME: String? = nil
    internal static var API_KEY: String? = nil
    
    internal var token: String? = nil
    internal var baseUrl: String? = nil
    
    internal var isSandbox: Bool {
        get {
            return Service.USERNAME == "sandbox"
        }
    }
    
    internal var headers: HTTPHeaders {
        get {
            let authHeader = token == nil ? "apiKey" : "token"
            let authValue = token == nil ? Service.API_KEY! : token!
            return [
                authHeader : authValue,
                "Accept": "application/json"
            ]
        }
    }
    
    init() { }
    
    internal func fetchToken() {
        // grpc
        token = "some token"
    }
}

public struct AfricasTalking {
    
    private static var accountService: AccountService? = nil
    
    private init() {
        
    }
    
    static func initialize(username: String, apiKey: String) {
        Service.USERNAME = username
        Service.API_KEY = apiKey
    }
    
    static func initialize(host: String, port: Int = 35897, disableTls: Bool = false) {
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
}
