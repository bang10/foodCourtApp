//
//  MemberViewModel.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/12/24.
//

import Foundation
import Alamofire

class MemberViewModel {
    private var common = Common()
    private var alamofireViewModel = AlamfireViewModel()
    
    func Login(loginDto: LoginDto, result: @escaping (ApiResponseViewModel<LoginDto>?, Error?) -> Void){
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let params = common.toDictionary(loginDto)
        
        alamofireViewModel.apiRequest(url: "/api-1/member/login", method: .post, parameters: params, headers: headers) { (res: ApiResponseViewModel<LoginDto>?, err) in
            
        }
        
    }
}
