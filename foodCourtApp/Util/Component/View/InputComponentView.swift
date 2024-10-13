//
//  InputView.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/12/24.
//

import SwiftUI

struct InputComponentView: View {
    @Binding var text: String
    @Binding var type: String
    @Binding var widthValue: CGFloat
    @Binding var heightValue: CGFloat
    
    @Binding var inputValue: String
    @Binding var isLock: Bool
    
    init(text: Binding<String> = .constant(" "), type: Binding<String> = .constant("normal"), widthValue: Binding<CGFloat> = .constant(100), heightValue: Binding<CGFloat> = .constant(30), inputValue: Binding<String> = .constant(""), isLock: Binding<Bool> = .constant(false)) {
        _type = type
        _text = text
        _widthValue = widthValue
        _heightValue = heightValue
        _inputValue = inputValue
        _isLock = isLock
    }
    
    var body: some View {
        VStack {
            if type == "normal" {
                TextField($text.wrappedValue, text: $inputValue)
                    .frame(width: $widthValue.wrappedValue, height: $heightValue.wrappedValue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .textCase(.lowercase)
                    .autocapitalization(.none)
                    .disableAutocorrection(false)
                    .disabled(isLock)
            } else {
                SecureField($text.wrappedValue, text: $inputValue)
                    .frame(width: $widthValue.wrappedValue, height: $heightValue.wrappedValue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .textCase(.lowercase)
                    .autocapitalization(.none)
                    .disableAutocorrection(false)
                    .disabled(isLock)
            }
            
        } // VStack
    } // View
}

//#Preview {
//    InputComponentView()
//}
