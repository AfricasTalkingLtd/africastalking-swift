// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: SdkServerService.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Africastalking_ClientTokenRequest: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".ClientTokenRequest"

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }
}

struct Africastalking_ClientTokenResponse: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".ClientTokenResponse"

  var username: String = String()

  var token: String = String()

  var expiration: Int64 = 0

  var environment: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.username)
      case 2: try decoder.decodeSingularStringField(value: &self.token)
      case 3: try decoder.decodeSingularInt64Field(value: &self.expiration)
      case 4: try decoder.decodeSingularStringField(value: &self.environment)
      default: break
      }
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.username.isEmpty {
      try visitor.visitSingularStringField(value: self.username, fieldNumber: 1)
    }
    if !self.token.isEmpty {
      try visitor.visitSingularStringField(value: self.token, fieldNumber: 2)
    }
    if self.expiration != 0 {
      try visitor.visitSingularInt64Field(value: self.expiration, fieldNumber: 3)
    }
    if !self.environment.isEmpty {
      try visitor.visitSingularStringField(value: self.environment, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }
}

struct Africastalking_SipCredentialsRequest: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".SipCredentialsRequest"

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }
}

struct Africastalking_SipCredentials: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".SipCredentials"

  var host: String = String()

  var port: Int32 = 0

  var username: String = String()

  var password: String = String()

  var transport: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.host)
      case 2: try decoder.decodeSingularInt32Field(value: &self.port)
      case 3: try decoder.decodeSingularStringField(value: &self.username)
      case 4: try decoder.decodeSingularStringField(value: &self.password)
      case 5: try decoder.decodeSingularStringField(value: &self.transport)
      default: break
      }
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.host.isEmpty {
      try visitor.visitSingularStringField(value: self.host, fieldNumber: 1)
    }
    if self.port != 0 {
      try visitor.visitSingularInt32Field(value: self.port, fieldNumber: 2)
    }
    if !self.username.isEmpty {
      try visitor.visitSingularStringField(value: self.username, fieldNumber: 3)
    }
    if !self.password.isEmpty {
      try visitor.visitSingularStringField(value: self.password, fieldNumber: 4)
    }
    if !self.transport.isEmpty {
      try visitor.visitSingularStringField(value: self.transport, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }
}

struct Africastalking_SipCredentialsResponse: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".SipCredentialsResponse"

  var credentials: [Africastalking_SipCredentials] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.credentials)
      default: break
      }
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.credentials.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.credentials, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "africastalking"

extension Africastalking_ClientTokenRequest: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  func _protobuf_generated_isEqualTo(other: Africastalking_ClientTokenRequest) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Africastalking_ClientTokenResponse: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "username"),
    2: .same(proto: "token"),
    3: .same(proto: "expiration"),
    4: .same(proto: "environment"),
  ]

  func _protobuf_generated_isEqualTo(other: Africastalking_ClientTokenResponse) -> Bool {
    if self.username != other.username {return false}
    if self.token != other.token {return false}
    if self.expiration != other.expiration {return false}
    if self.environment != other.environment {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Africastalking_SipCredentialsRequest: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  func _protobuf_generated_isEqualTo(other: Africastalking_SipCredentialsRequest) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Africastalking_SipCredentials: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "host"),
    2: .same(proto: "port"),
    3: .same(proto: "username"),
    4: .same(proto: "password"),
    5: .same(proto: "transport"),
  ]

  func _protobuf_generated_isEqualTo(other: Africastalking_SipCredentials) -> Bool {
    if self.host != other.host {return false}
    if self.port != other.port {return false}
    if self.username != other.username {return false}
    if self.password != other.password {return false}
    if self.transport != other.transport {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Africastalking_SipCredentialsResponse: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "credentials"),
  ]

  func _protobuf_generated_isEqualTo(other: Africastalking_SipCredentialsResponse) -> Bool {
    if self.credentials != other.credentials {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}
