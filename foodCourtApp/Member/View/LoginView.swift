//
//  Login.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/11/24.
//

import SwiftUI

struct LoginView: View {
    @State var userId: String = ""
    @State var passcode: String = ""
    @State var inputWidhtValue: CGFloat = 250
    @State var inputHeightValue: CGFloat = 30
    @State var imageSize: CGFloat = 20
    
    @State var isLogin: Bool? = false
    @State var isFindId: Bool? = false
    @State var isFindPw: Bool? = false
    @State var isSignUp: Bool? = false
    
    @State var loginDto: LoginDto?
    
    var memberViewModel = MemberViewModel()
    
    
    var body: some View {
        VStack {
            // ID 입력 부분
            HStack {
                ImageComponentView(
                    sfSymbolName: "person",
                    widthValue: 25,
                    heightValue: 25,
                    imageSize: 10
                )
                InputComponentView(text: .constant("ID"), type: .constant("normal"), widthValue: $inputWidhtValue, heightValue: $inputHeightValue, inputValue: $userId)
            } // HStack
            
            // PW 입력 부분
            HStack {
                ImageComponentView(
                    sfSymbolName: "key",
                    widthValue: 25,
                    heightValue: 30,
                    imageSize: 10
                )
                
                InputComponentView(text: .constant("password"), type: .constant("security"), widthValue: $inputWidhtValue, heightValue: $inputHeightValue, inputValue: $passcode)
            } // HStack
            
            VStack(spacing: 10) {
                // 로그인 버튼
                ButtonComponentView(
                    buttonTittle: .constant("로그인"),
                    toggleVal: $isLogin,
                    boundStringVal: .constant(nil),
                    boundIntVal: .constant(nil),
                    onButtonClick: {
                        memberViewModel.Login(loginDto: LoginDto(userId: userId, passcode: passcode)) { res, error in
                            
                        }
                    }
                )
                // 아이디 찾기, 비밀번호 초기화
                
                // 회원 가입
            }
            // VStack
            
            
        } // VStack
    } // View
} // Main view

#Preview {
    LoginView()
}
