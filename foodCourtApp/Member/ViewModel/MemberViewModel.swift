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
    
    /**
     로그인
     */
    func Login(loginDto: LoginDto, result: @escaping (Bool) -> Void){
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let params = common.toDictionary(loginDto)
        
        alamofireViewModel.apiRequest(url: "/api-1/member/login", method: .post, parameters: params, headers: headers) { (res: ApiResponseViewModel<Bool>?, err) in
            if let res = res {
                let requestResult = res.result
                if res.code != "0" {
                    self.common.alert(message: res.message)
                }
                result(requestResult)
            } else {
                result(false)
                self.common.alert(message: "데이터를 처리하던 중 오류가 발생했습니다.")
            }
            

        }
    }
    
    /**
     ID 찾기
     */
    func findUserId(isCheck: Bool, findMemberInfoDto: FindMemberInfoDto){
        if isCheck {
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            let params = common.toDictionary(findMemberInfoDto)
            
            alamofireViewModel.apiRequest(url: "/api-1/member/info/check", method: .post, parameters: params, headers: headers) { (res: ApiResponseViewModel<String>?, err) in
                if let res = res {
                    if res.code != "0" {
                        self.common.alert(message: res.message)
                    }
                    self.common.alert(message: "ID는 \(res.result)입니다.")
                } else {
                    self.common.alert(message: "데이터를 처리하던 중 오류가 발생했습니다.")
                }
            }
        } else {
            common.alert(message: "전화번호 인증을 먼저 해주세요.")
        }
    }
    
}
