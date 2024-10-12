//
//  ViewModel.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/12/24.
//

import Foundation
import Alamofire

enum HttpMethod: String {
    case get
    case post
    case put
    case delete
}

class AlamfireViewModel {
    private let host = "http://localhost:8080"
    
    func apiRequest<T: Decodable> (
        url: String,
        method: HttpMethod,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders,
        completion: @escaping (ApiResponseViewModel<T>?, Error?) -> Void
    ) {
        let requestMehtod: HTTPMethod = (method == .get) ? .get : .post
        
        // GET인 경우
        var requestUrl: String = host + url
        if method == .get, let parameters = parameters {
            let urlComponents = NSURLComponents(string: requestUrl)!
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            requestUrl = urlComponents.url?.absoluteString ?? requestUrl
        }
        
        var param: [String: Any] = [:]
        if let parameters = parameters{
            param = parameters
        }
        
        
        print("reqeust url: \(requestUrl), method: \(requestMehtod), param: \(param), headers: \(headers), parameters: \(parameters)")
        AF.request(requestUrl, method: requestMehtod, parameters: method == .get ? nil : param, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let val):
                    print(val)
                case .failure(let error):
                    print(error)
                }
            }
    }
}


