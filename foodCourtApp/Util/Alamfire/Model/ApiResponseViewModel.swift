//
//  ApiResponse.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/12/24.
//

import Foundation

struct ApiResponseViewModel<T: Decodable>: Decodable {
    let code: String
    let message: String
    let result: T
}
