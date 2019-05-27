//
//  NetworkManager.swift
//  TimberiOS
//
//  Created by Nicolas on 28/09/2017.
//

import Foundation
import Alamofire

extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}

open class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}
    
    
    open func request(apiToken: String,
                      endpoint: String,
                      method: HTTPMethod,
//                      body:String?,
                      params: [String: Any],
                      completionHandler: @escaping (DataResponse<String>) -> ()) {
        
        let encodedToken = apiToken.toBase64()
        
        let headers: HTTPHeaders = [
            "authorization": "Basic \(encodedToken)",
            "accept": "content/json",
            "content-type": "application/json"
        ]

        Alamofire.request("https://logs.timber.io\(endpoint)",
            method: method,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: headers)
            .validate(contentType: ["text/plain"])
            .responseString { (response) in
                completionHandler(response)
        }
    }
}
