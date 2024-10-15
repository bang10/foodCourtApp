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
    
    @State var isLogin: Bool = false
    @State var isFindId: Bool = false
    @State var isFindPw: Bool = false
    @State var isSignUp: Bool = false
    
    @State var loginDto: LoginDto?
    
    var memberViewModel = MemberViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                // ID 입력 부분
                HStack {
                    ImageComponentView(
                        sfSymbolName: "person",
                        widthValue: 25,
                        heightValue: 25,
                        imageSize: 10
                    )
                    InputComponentView(
                        text: .constant("ID")
                        , type: .constant("normal")
                        , widthValue: .constant(250)
                        , heightValue: .constant(30)
                        , inputValue: $userId
                        , isLock: .constant(false)
                    )
                } // HStack
                
                // PW 입력 부분
                HStack {
                    ImageComponentView(
                        sfSymbolName: "key",
                        widthValue: 25,
                        heightValue: 30,
                        imageSize: 10
                    )
                    
                    InputComponentView(
                        text: .constant("password")
                        , type: .constant("security")
                        , widthValue: .constant(250)
                        , heightValue: .constant(30)
                        , inputValue: $passcode
                        , isLock: .constant(false)
                    )
                } // HStack
                
                VStack(spacing: 10) {
                    // 로그인 버튼
                    ButtonComponentView(
                        buttonTittle: .constant("로그인"),
                        toggleVal: $isLogin,
                        boundStringVal: .constant(nil),
                        boundIntVal: .constant(nil),
                        isLock: .constant(nil),
                        onButtonClick: {
                            memberViewModel.Login(loginDto: LoginDto(userId: userId, passcode: passcode)) { res in
                                    self.isLogin = res
                            }
                        }
                    ) // ButtonComponentView
                    .padding(.top, 10)
                    
                    NavigationLink(destination: IndexView(userId: $userId), isActive: $isLogin) {
                        EmptyView()
                    }
                    
                    // 아이디 찾기, 비밀번호 초기화
                    HStack (spacing: 10) {
                        // ID찾기
                        ButtonComponentView(
                            buttonTittle: .constant("ID 찾기"),
                            toggleVal: $isLogin,
                            boundStringVal: .constant(nil),
                            boundIntVal: .constant(nil),
                            isLock: .constant(nil),
                            onButtonClick: {
                                self.isFindId.toggle()
                            }
                        ) // ButtonComponentView
                        
                        NavigationLink(destination: FIndUserIdView(), isActive: $isFindId) {
                            EmptyView()
                        }
                        
                        // PW 초기화
                        ButtonComponentView(
                            buttonTittle: .constant("비밀번호 초기화"),
                            toggleVal: $isLogin,
                            boundStringVal: .constant(nil),
                            boundIntVal: .constant(nil),
                            isLock: .constant(nil),
                            onButtonClick: {
                                self.isFindPw.toggle()
                            }
                        ) // ButtonComponentView
                    }
                    
                    NavigationLink(destination: ResetPasscodeAuthCheckView(), isActive: $isFindPw) {
                        EmptyView()
                    }
                    
                    // 회원 가입
                    ButtonComponentView(
                        buttonTittle: .constant("회원 가입"),
                        toggleVal: $isLogin,
                        boundStringVal: .constant(nil),
                        boundIntVal: .constant(nil),
                        isLock: .constant(nil),
                        onButtonClick: {
                            self.isSignUp.toggle()
                        }
                    ) // ButtonComponentView
                    
                    NavigationLink(destination: JoinView(), isActive: $isSignUp) {
                        EmptyView()
                    }
                    
                }// VStack
            } // VStack
        } // navigationView
        .navigationBarBackButtonHidden(true)
    } // View
} // Main view

#Preview {
    LoginView()
}
