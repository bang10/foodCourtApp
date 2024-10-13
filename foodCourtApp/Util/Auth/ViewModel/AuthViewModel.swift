//
//  AuthViewModel.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/13/24.
//

import Foundation
import Alamofire

class AuthViewModel{
    private var common = Common()
    private var alamofireViewModel = AlamfireViewModel()
    
    /**
     인증 번호 전송 요청
     */
    func requestAuthMessage(findMemberInfoDto: FindMemberInfoDto, result: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let params = common.toDictionary(findMemberInfoDto)
        
        alamofireViewModel.apiRequest(url: "/api-1/auth/send/sms", method: .post, parameters: params,headers: headers) {(res: ApiResponseViewModel<Bool>?, err) in
            if let res = res {
                self.common.alert(message: res.message)
                result(res.result)
            }
        }
    }
    
    /**
     인증 번호 확인
     */
    func requestAuthCheck(authModel: AuthModel, result: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let params = common.toDictionary(authModel)
        
        alamofireViewModel.apiRequest(url: "/api-1/auth/check/sms", method: .post, parameters: params, headers: headers) {(res: ApiResponseViewModel<Bool>?, err) in
            if let res = res {
                self.common.alert(message: res.message)
                result(res.result)
            }
        }
    }
}
