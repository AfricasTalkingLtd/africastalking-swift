//
//  AfricasTalking.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 05/12/2017.
//
import SwiftyJSON

public struct AfricasTalking {
    
    public typealias Callback = (_ error: String?, _ data: JSON?) -> Void
    
    private static var accountService: AccountService? = nil
    private static var airtimeService: AirtimeService? = nil
    private static var voiceService: VoiceService? = nil
    private static var tokenService: TokenService? = nil
    private static var smsService: SmsService? = nil
    private static var paymentService: PaymentService? = nil
    
    private init() { }
    
    public static func initialize(username: String, apiKey: String) {
        Service.USERNAME = username
        Service.API_KEY = apiKey
    }
    
    public static func initialize(withHost host: String, andPort port: Int = 35897, butWithoutTls disableTls: Bool = false) {
        Service.HOST = host
        Service.PORT = port
        Service.DISABLE_TLS = disableTls
    }
 
    public static func getAccountService() -> AccountService {
        if (accountService == nil) {
            accountService = AccountService()
        }
        return accountService!
    }
    
    public static func getAirtimeService() -> AirtimeService {
        if (airtimeService == nil) {
            airtimeService = AirtimeService()
        }
        return airtimeService!
    }
    
    public static func getTokenService() -> TokenService {
        if (tokenService == nil) {
            tokenService = TokenService()
        }
        return tokenService!
    }
    
    public static func getVoiceService() -> VoiceService {
        if (voiceService == nil) {
            voiceService = VoiceService()
        }
        return voiceService!
    }
    
    public static func getSmsService() -> SmsService {
        if (smsService == nil) {
            smsService = SmsService()
        }
        return smsService!
    }
    
    public static func getPaymentService() -> PaymentService {
        if (paymentService == nil) {
            paymentService = PaymentService()
        }
        return paymentService!
    }
}
