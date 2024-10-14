//
//  BaseUserDto.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/14/24.
//

import Foundation

struct BaseUserDto: Decodable, Hashable {
    var userId: String?
    var passcode: String?
    var passcodeCheck: String?
    var userName: String?
    var tellNumber: String?
    var sysRegDate: Date?
    var sysRegId: String?
    var sysModDate: Date?
    var sysModId: String?
    var status: String?
    var note: String?
}
