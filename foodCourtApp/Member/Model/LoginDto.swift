//
//  LoginDto.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/11/24.
//

import Foundation

struct LoginDto: Hashable, Identifiable, Decodable {
    var userId: String
    var passcode: String
    
    var id: String { userId }
}
