//
//  MemberDto.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/13/24.
//

import Foundation

struct FindMemberInfoDto: Decodable, Hashable {
    var userId: String?
    var userName: String
    var tellNumber: String
}
