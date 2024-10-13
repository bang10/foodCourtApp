//
//  FIndUserIdView.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/13/24.
//

import SwiftUI

struct FIndUserIdView: View {
    @State var userName: String = ""
    @State var tellNumber: String = ""
    @State var authCode: String = ""
    @State var authSendMessage: String = "인증번호 발송"
    @State var isSendAuth: Bool = false
    @State var isCheckAuth: Bool = false
    @State var isSuccessCheck: Bool = false
    @State var isClose: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var authViewModel: AuthViewModel = AuthViewModel()
    var memberViewModel: MemberViewModel = MemberViewModel()
    var common: Common = Common()
    var findMemberDto: FindMemberInfoDto
    
    init() {
        findMemberDto = FindMemberInfoDto(userId: "", userName: "", tellNumber: "")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 이름 입력 칸
                Text("이름")
                    .padding(.trailing, 220)
                InputComponentView(
                    text: .constant("이름")
                    , type: .constant("normal")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $userName
                )
                .padding(.bottom, 10)
                
                Text("전화번호")
                    .padding(.trailing, 190)
                InputComponentView(
                    text: .constant("전화번호")
                    , type: .constant("normal")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $tellNumber
                    , isLock: $isSendAuth
                )
                .padding(.bottom, 10)
                
                // 인증번호 입력 칸, 버튼
                HStack {
                    InputComponentView(
                        text: .constant("인증번호")
                        , type: .constant("normal")
                        , widthValue: .constant(150)
                        , heightValue: .constant(36)
                        , inputValue: $authCode
                        , isLock: .constant(isSuccessCheck)
                    )
                    .padding(.bottom, 10)
                    
                    
                    if !self.isSendAuth {
                        // 인증번호 전송
                        ButtonComponentView(
                            buttonTittle: $authSendMessage
                            , toggleVal: .constant(false)
                            , boundStringVal: .constant(nil)
                            , boundIntVal: .constant(nil)
                            , isLock: .constant(nil)
                            , onButtonClick: {
                                authViewModel.requestAuthMessage(findMemberInfoDto: FindMemberInfoDto(userId: "", userName: userName, tellNumber: tellNumber)) { res in
                                    self.isSendAuth = res
                                }
                            }
                        )
                        .padding(.bottom, 10)
                    } else {
                        // 인증 번호 확인
                        ButtonComponentView(
                            buttonTittle: .constant("인증하기")
                            , toggleVal: .constant(false)
                            , boundStringVal: .constant(nil)
                            , boundIntVal: .constant(nil)
                            , isLock: .constant(isCheckAuth)
                            , onButtonClick: {
                                authViewModel.requestAuthCheck(authModel: AuthModel(sendTo: tellNumber, code: authCode, requestRedisType: "id")) { res in
                                    self.isCheckAuth = res
                                    self.isSuccessCheck = res
                                }
                            }
                        )
                        .padding(.bottom, 10)
                    }
                    
                } // HStack
                
                ButtonComponentView(
                    buttonTittle: .constant("아이디 찾기")
                    , toggleVal: .constant(false)
                    , boundStringVal: .constant(nil)
                    , boundIntVal: .constant(nil)
                    , isLock: .constant(nil)
                    , onButtonClick: {
                        memberViewModel.findUserId(isCheck: isCheckAuth, findMemberInfoDto: FindMemberInfoDto(userId: nil, userName: userName, tellNumber: tellNumber))
                    }
                )
                .padding(.bottom, 10)
                
                ButtonComponentView(
                    buttonTittle: .constant("페이지 닫기")
                    , toggleVal: .constant(false)
                    , boundStringVal: .constant(nil)
                    , boundIntVal: .constant(nil)
                    , isLock: .constant(nil)
                    , onButtonClick: {
                        self.isClose = true
                    }
                    , isAlertDialog: isClose
                    , alertEvent: (
                        self.common.alertDialog(
                            title: "닫기"
                            , message: "창을 닫으면 입력된 모든 데이터가 사라집니다. 창을 닫으시겠습니까?"
                            , confirmAction: {
                                presentationMode.wrappedValue.dismiss()
                            }
                        )
                    )
                )
                
            } // VStack
        } // navigationView
        .navigationTitle("아이디 찾기")
        .navigationBarTitleDisplayMode(.automatic)
        
    } // View
} // Main View

#Preview {
    FIndUserIdView()
}
