//
//  ResetPasscode.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/14/24.
//

import SwiftUI

struct ResetPasscodeView: View {
    @Binding var userId: String
    @State var passcode: String = ""
    @State var passcodeCheck: String = ""
    @State var isSuccessUpdatePasscode: Bool = false
    
    init(userId: Binding<String> = .constant("")) {
        _userId = userId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
        } // NavigationView
        .navigationBarBackButtonHidden()
    } // View
} // View

#Preview {
    ResetPasscodeView()
}
