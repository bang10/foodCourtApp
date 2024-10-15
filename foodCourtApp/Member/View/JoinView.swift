//
//  JoinView.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/15/24.
//

import SwiftUI

struct JoinView: View {
    @State var userId: String = ""
    @State var isDuplicationId: Bool = false
    @State var passcode: String = ""
    @State var passcodeCheck: String = ""
    @State var isValidatePasscode: Bool = false
    @State var userName: String = ""
    @State var tellNumber: String = ""
    @State var authCode: String = ""
    @State var isSendAuth: Bool = false
    @State var isSuccessCheck: Bool = false
    @State var authSendMessage: String = "인증번호 발송"
    @State var isCheckAuth: Bool = false
    @State var isClose: Bool = false
    @State var isClickJoin: Bool = false
    @State var isSuccessJoin: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var authViewModel: AuthViewModel = AuthViewModel()
    var common: Common = Common()
    var validation: ValidationService = ValidationService()
    var memberViewModel: MemberViewModel = MemberViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("ID")
                    .padding(.trailing, 245)
                
                HStack {
                    InputComponentView(
                        text: .constant("ID")
                        , type: .constant("normal")
                        , widthValue: .constant(200)
                        , heightValue: .constant(36)
                        , inputValue: $userId
                    )
                    .padding(.bottom, 10)
                    
                    ButtonComponentView(
                        buttonTittle: .constant("중복확인")
                        , toggleVal: .constant(false)
                        , boundStringVal: .constant(nil)
                        , boundIntVal: .constant(nil)
                        , isLock: .constant(nil)
                        , onButtonClick: {
                            if !validation.validationId(value: userId, target: "id") {
                                self.common.alert(message: "ID 형식에 맞춰 작성해 주세요.")
                                self.isDuplicationId = false
                                return
                            }
                            memberViewModel.checkUserInfo(baseUserDto: .init(userId: userId)) { res in
                                if !res {
                                    self.common.alert(message: "사용 가능한 ID입니다.")
                                } else {
                                    self.common.alert(message: "이미 사용중인 ID입니다.")
                                }
                                self.isDuplicationId = !res
                            }
                        }
                    )
                    .padding(.bottom, 10)
                } // HStack
                
                Text("영어 숫자를 조합하여 8자~12자로 입력해주세요.")
                    .font(.footnote)
                    .padding(.bottom, 10)
                
                Text("비밀번호")
                    .padding(.trailing, 199)
                InputComponentView(
                    text: .constant("비밀번호")
                    , type: .constant("security")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $passcode
                )
                .padding(.bottom, 10)
                .padding(.trailing, 18)
                
                if !validation.validationId(value: passcode, target: "passcode") {
                    Text("대소문자, 영어, 특수문자를 최소 1개씩 사용하여 12자 ~ 20자로 입력해 주세요.")
                        .font(.footnote)
                        .padding(.trailing, 100)
                        .padding(.leading, 77)
                        .padding(.bottom, 10)
                }
                Text("비밀번호 재입력")
                    .padding(.trailing, 155)
                InputComponentView(
                    text: .constant("비밀번호 재입력")
                    , type: .constant("security")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $passcodeCheck
                )
                .padding(.bottom, 10)
                .padding(.trailing, 18)
                
                if (passcode != passcodeCheck) {
                    Text("비밀번호가 일치하지 않습니다.")
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .padding(.trailing, 100)
                        .padding(.leading, 77)
                        .padding(.bottom, 10)
                }
                
                Text("이름")
                    .padding(.trailing, 235)
                
                InputComponentView(
                    text: .constant("이름")
                    , type: .constant("normal")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $userName
                )
                .padding(.bottom, 10)
                .padding(.trailing, 18)
                
                Text("전화번호")
                    .padding(.trailing, 208)
                InputComponentView(
                    text: .constant("전화번호")
                    , type: .constant("normal")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $tellNumber
                    , isLock: $isSendAuth
                )
                .padding(.bottom, 10)
                .padding(.trailing, 18)
                
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
                    .padding(.trailing, 18)
                    
                    
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
                                authViewModel.requestAuthCheck(authModel: AuthModel(sendTo: tellNumber, code: authCode, requestRedisType: "join")) { res in
                                    self.isCheckAuth = res
                                    self.isSuccessCheck = res
                                }
                            }
                        )
                        .padding(.bottom, 10)
                    }
                } // HStack
                
                ButtonComponentView(
                    buttonTittle: .constant("회원 가입")
                    , toggleVal: .constant(false)
                    , boundStringVal: .constant(nil)
                    , boundIntVal: .constant(nil)
                    , isLock: .constant(nil)
                    , onButtonClick: {
                        self.isClickJoin.toggle()
                    }
                    , isAlertDialog: isClickJoin
                    , alertEvent: (
                        self.common.alertDialog(
                            title: "가입"
                            , message: "입력하신 정보로 가입을 완료하시겠습니까?"
                            , confirmAction: {
                                // TODO 가입
                                if !self.isDuplicationId {
                                    self.common.alert(message: "ID 중복여부를 확인해 주세요.")
                                    return
                                }
                                if !self.isSuccessCheck || !self.isCheckAuth {
                                    self.common.alert(message: "번호 인증을 진행해 주세요.")
                                    return
                                }
                                memberViewModel.join(baseUserDto: .init(userId: userId, passcode: passcode, passcodeCheck: passcodeCheck, userName: userName, tellNumber: tellNumber)) {res in
                                    if res {
                                        common.alert(message: "가입이 완료되었습니다.")
                                        self.isSuccessJoin = res
                                    }
                                }
                            }
                        )
                    )
                )
                .padding(.bottom, 10)
                
                NavigationLink(destination: LoginView(), isActive: $isSuccessJoin) {
                    EmptyView()
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
                
            } // ScrollView
        } // navigationView
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.automatic)
    } // view
} // View

#Preview {
    JoinView()
}
