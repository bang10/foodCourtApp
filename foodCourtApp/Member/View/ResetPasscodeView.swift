//
//  ResetPasscode.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/14/24.
//

import SwiftUI

struct ResetPasscodeView: View {
    @Binding var userId: String
    @Binding var userName: String
    @Binding var tellNumber: String
    
    @State var passcode: String = ""
    @State var passcodeCheck: String = ""
    @State var isSuccessUpdatePasscode: Bool = false
    @State var isClose: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var common: Common = Common()
    var validation: ValidationService = ValidationService()
    var memberViewModel: MemberViewModel = MemberViewModel()
    
    init(userId: Binding<String> = .constant(""), userName: Binding<String> = .constant(""), tellNumber: Binding<String> = .constant("")) {
        _userId = userId
        _userName = userName
        _tellNumber = tellNumber
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("대소문자, 영어, 특수문자를 \n최소 1개씩 사용하여 12자 ~ 20자 \n로 입력해 주세요.")
                    .padding(.bottom, 10)
                
                Text("비밀번호")
                    .padding(.trailing, 190)
                InputComponentView(
                    text: .constant("비밀번호")
                    , type: .constant("security")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $passcode
                )
                .padding(.bottom, 10)
                
                Text("비밀번호 재입력")
                    .padding(.trailing, 140)
                InputComponentView(
                    text: .constant("비밀번호 재입력")
                    , type: .constant("security")
                    , widthValue: .constant(250)
                    , heightValue: .constant(36)
                    , inputValue: $passcodeCheck
                )
                .padding(.bottom, 10)
                
                if !validation.validationId(value: passcode, target: "passcode") {
                    Text("비밀번호 형식을 지켜주세요.")
                        .foregroundStyle(.red)
                } else if (passcode != passcodeCheck) {
                    Text("비밀번호가 일치하지 않아요.")
                }
                
                ButtonComponentView(
                    buttonTittle: .constant("비밀번호 변경")
                    , toggleVal: .constant(false)
                    , boundStringVal: .constant(nil)
                    , boundIntVal: .constant(nil)
                    , isLock: .constant(false)
                    , onButtonClick: {
                        memberViewModel.updatePasscode(baseUserDto: BaseUserDto(userId: userId, passcode: passcode, passcodeCheck: passcodeCheck, userName: userName, tellNumber: tellNumber)) { res in
                            if res {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                )
                .padding(.top, 5)
                .padding(.bottom, 5)
                
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
        .navigationBarBackButtonHidden()
    } // View
} // View

#Preview {
    ResetPasscodeView()
}
