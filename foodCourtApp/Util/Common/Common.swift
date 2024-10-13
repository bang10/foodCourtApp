//
//  Alert.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/11/24.
//

import Foundation
import UIKit
import SwiftUI

class Common {
    init() {}
        
    /**
     알럿
     */
    func alert(message: String) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /**
     확인, 취소 알럿
     */
    func alertDialog(title: String, message: String, confirmAction: @escaping () -> Void) -> Alert {
        return Alert (
            title: Text(title),
            message: Text(message),
            primaryButton: .default(Text("확인"), action: confirmAction),
            secondaryButton: .cancel(Text("취소"))
        )
    }
    
    /**
     DTO to Dictionary
     */
    func toDictionary(_ dto: Any) -> [String: Any] {
        let mirror = Mirror(reflecting: dto)
        var dict = [String: Any]()
    
        for child in mirror.children {
            if let propertyName = child.label {
                dict[propertyName] = child.value
            }
        }
        
        return dict
    }
}
