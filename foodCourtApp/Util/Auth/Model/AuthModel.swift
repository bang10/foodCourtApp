//
//  AuthModel.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/13/24.
//

import Foundation

struct AuthModel: Decodable, Hashable {
    var authId: String?
    var groupId: String?
    var sendTo: String
    var sendFrom: String?
    var messageType: String?
    var statusMessage: String?
    var contury: String?
    var messageId: String?
    var statusCode: String?
    var accountId: String?
    var sysRegDate: Date?
    var code: String?
    var requestRedisType: String?
}

