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
    private var validation = ValidationService()
    
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
    
    /**
     사용자 여부 확인
     */
    func checkUserInfo(baseUserDto: BaseUserDto, result: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let params = common.toDictionary(baseUserDto)
        
        alamofireViewModel.apiRequest(url: "/api-1/member/check/user/info", method: .post, parameters: params, headers: headers) { (res: ApiResponseViewModel<Bool>?, err) in
            if let res = res {
                if res.code != "0" {
                    self.common.alert(message: res.message)
                }
                result(res.result)
            }
        }
        
    }
    
    /**
        비밀번호 변경
     */
    func updatePasscode(baseUserDto: BaseUserDto, result: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let params = common.toDictionary(baseUserDto)
        alamofireViewModel.apiRequest(url: "/api-1/member/update/passcode", method: .post, parameters: params, headers: headers) { (res: ApiResponseViewModel<Bool>?, err) in
            if let res = res {
                self.common.alert(message: res.message)
                result(res.result)
            }
        }
    }
    
    /**
     회원가입
     */
    func join(baseUserDto: BaseUserDto, result: @escaping (Bool) -> Void) {
        if !validation.validationId(value: baseUserDto.userId!, target: "id") {
            common.alert(message: "아이디 형식이 올바르지 않습니다.")
            return
        }
        if baseUserDto.passcode != baseUserDto.passcodeCheck {
            common.alert(message: "비밀번호가 일치하지 않습니다.")
            return
        }
        if !validation.validationId(value: baseUserDto.tellNumber!, target: "tellNumber") {
            common.alert(message: "전화번호 형식이 올바르지 않습니다. \n숫자만 입력해 주세요.")
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let params = common.toDictionary(baseUserDto)
        
        alamofireViewModel.apiRequest(url: "/api-1/member/join", method: .post, parameters: params, headers: headers) { (res: ApiResponseViewModel<Bool>?, err) in
            if let res = res {
                if !res.result {
                    self.common.alert(message: res.message)
                }
                result(res.result)
            }
        }
        
    }
    
}
