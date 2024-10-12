//
//  ValidationService.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/12/24.
//

import Foundation
class ValidationService {
    func validationId(value: String, target: String) -> Bool {
        var parttern = ""
        
        switch target {
        case "id":
                parttern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$"
        case "passcode":
                parttern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{12,20}$"
        case "tellNumber":
                parttern = "^010\\d{7,12}$"
        default:
            parttern = ""
        }
                
        do {
            let regex = try NSRegularExpression(pattern: parttern, options: .caseInsensitive)
            let matches = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.count))
            return matches.count > 0
        } catch {
            return false
        }
    }
}
