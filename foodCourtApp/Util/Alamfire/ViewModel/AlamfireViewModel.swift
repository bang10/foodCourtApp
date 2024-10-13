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
        
        AF.request(requestUrl, method: requestMehtod, parameters: method == .get ? nil : param, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                        case .success(let val):
                            do {
                                // JSON 데이터로부터 ApiResponseViewModel<T>를 디코딩
                                let data = try JSONSerialization.data(withJSONObject: val, options: .prettyPrinted)
                                let decodedResponse = try JSONDecoder().decode(ApiResponseViewModel<T>.self, from: data)
                                completion(decodedResponse, nil)
                            } catch {
                                // 디코딩 실패 시 오류 처리
                                print("Decoding error: \(error)")
                                completion(nil, error)
                            }
                        case .failure(let error):
                            print(error)
                            completion(nil, error)
                        }
            }
    }
}


