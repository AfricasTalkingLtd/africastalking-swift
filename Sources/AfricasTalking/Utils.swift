//
//  Utils.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 07/12/2017.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

protocol JSONRepresentable {
    var JSONRepresentation: [String:Any] { get }
}

protocol JSONSerializable: JSONRepresentable {}

extension JSONSerializable {
    
    var JSONRepresentation: [String:Any] {
        var representation = [String: Any]()
        
        for case let (label?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as JSONRepresentable:
                representation[label] = value.JSONRepresentation
            
            case let value as REASON:
                representation[label] = value.rawValue
            case let value as TRANSFER_TYPE:
                representation[label] = value.rawValue
            case let value as PROVIDER:
                representation[label] = value.rawValue
            case let value as BankCode:
                representation[label] = value.rawValue
                
            case let value as NSObject:
                representation[label] = value
                
            default:
                // Ignore any unserializable properties
                break
            }
        }
        
        return representation
    }
}

extension JSONSerializable {
    func toJSON() -> String? {
        let representation = JSONRepresentation
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            return String(data: data, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
}
