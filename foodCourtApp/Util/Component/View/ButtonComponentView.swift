//
//  ButtonComponentView.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/12/24.
//

import SwiftUI

struct ButtonComponentView: View {
    @Binding var buttonTittle: String
    @Binding var toggleVal: Bool
    @Binding var boundStringVal: String?
    @Binding var boundIntVal: Int?
    @Binding var isLock: Bool?
    var onButtonClick: (() -> Void)?
    
    var isAlertDialog: Bool?
    var alertEvent: Alert?
    
    var body: some View {
        if let isAlertDialog = isAlertDialog{
            Button {
                onButtonClick?()
            } label: {
                Text(buttonTittle)
                    .background(Color.white.opacity(0.1))
                    .foregroundStyle(.black)
            }
            .disabled(isLock ?? false)
            .alert(isPresented: .constant(isAlertDialog)) { alertEvent! }
        } else {
            Button {
                onButtonClick?()
            } label: {
                Text(buttonTittle)
                    .background(Color.white.opacity(0.1))
                    .foregroundStyle(.black)
            }
            .disabled(isLock ?? false)
        }
        

    } // View
}
//
//#Preview {
//    ButtonComponentView()
//}
