//
//  ResetPasscodeAuthCheckView.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/14/24.
//

import SwiftUI

struct ResetPasscodeAuthCheckView: View {
    @State private var userName: String = ""
    @State private var userId: String = ""
    @State private var tellNumber: String = ""
    @State private var code: String = ""
    @State var authSendMessage: String = "인증번호 발송"
    @State var isSendAuth: Bool = false
    @State var isCheckAuth: Bool = false
    @State var isSuccessCheck: Bool = false
    @State var isClose: Bool = false
    @State var isClickReset: Bool = false
    
    var common: Common = Common()
    var authViewModel: AuthViewModel = AuthViewModel()
    var memberViewModel: MemberViewModel = MemberViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
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
                
                Text("ID")
                    .padding(.trailing, 220)
                InputComponentView(
                    text: .constant("ID")
                    , type: .constant("normal")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $userId
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
                
                HStack {
                    InputComponentView(
                        text: .constant("인증번호")
                        , type: .constant("normal")
                        , widthValue: .constant(150)
                        , heightValue: .constant(36)
                        , inputValue: $code
                        , isLock: $isSuccessCheck
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
                            , isLock: .constant(isSuccessCheck)
                            , onButtonClick: {
                                authViewModel.requestAuthCheck(authModel: AuthModel(sendTo: tellNumber, code: code, requestRedisType: "pass")) { res in
                                    self.isCheckAuth = res
                                    self.isSuccessCheck = res
                                }
                            }
                        )
                        .padding(.bottom, 10)
                    }
                } // HStack
                
                ButtonComponentView(
                    buttonTittle: .constant("비밀번호 재설정")
                    , toggleVal: .constant(false)
                    , boundStringVal: .constant(nil)
                    , boundIntVal: .constant(nil)
                    , isLock: .constant(nil)
                    , onButtonClick: {
                        if isSuccessCheck {
                            // TODO 사용자 확인 절차 필요
                            memberViewModel.checkUserInfo(baseUserDto: BaseUserDto(userId: $userId.wrappedValue, userName: $userName.wrappedValue, tellNumber: $tellNumber.wrappedValue)) { res in
                                if !res {
                                    common.alert(message: "회원 정보가 존재하지 않습니다.")
                                }
                                self.isClickReset = res
                            }
                            
                        } else {
                            self.common.alert(message: "인증을 먼저 진행해 주세요.")
                        }
                    }
                )
                .padding(.bottom, 10)
                .sheet(isPresented: $isClickReset) {
                    ResetPasscodeView(userId: $userId, userName: $userName, tellNumber: $tellNumber)
                }
                
                ButtonComponentView(
                    buttonTittle: .constant("페이지 닫기")
                    , toggleVal: .constant(false)
                    , boundStringVal: .constant(nil)
                    , boundIntVal: .constant(nil)
                    , isLock: .constant(nil)
                    , onButtonClick: {
                        self.isClose.toggle()
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
        } // NavigationView
        .navigationTitle("비밀번호 초기화")
        .navigationBarTitleDisplayMode(.automatic)
    } // view
}// View

#Preview {
    ResetPasscodeAuthCheckView()
}
