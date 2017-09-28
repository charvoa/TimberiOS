//
//  TimberLogger.swift
//  TimberiOS
//
//  Created by Nicolas on 28/09/2017.
//

import Foundation
//import Alamofire

public enum LogType: String {
    case frame = "/frames"
    case alert = "/alert"
}

public enum LogLevel: String {
    case debug = "debug"
    case info = "info"
    case notice = "notice"
    case warn = "warn"
    case error = "error"
    case criticial = "critical"
    case alert = "alert"
    case emergency = "emergency"
}

open class TimberLogger: NSObject {
    
    open static let shared = TimberLogger()
    
    var apiToken:String?
    
    private override init() {}

    open static func initialize(with apiToken:String) {
        TimberLogger.shared.apiToken = apiToken
    }
    
    open func log(type: LogType,
                  level: LogLevel,
                  severity: Int,
                  tags: [String],
                  message:String) {
        print("TimberLogger::log()")
        guard self.apiToken != nil else {
            assertionFailure("Could not initalize TimberLogger without apiToken | ERROR : API_TOKEN_ERROR")
            return
        }
        guard severity >= 0 && severity <= 7 else {
            assertionFailure("Severity must be between 0 and 7 | ERROR : SEVERITY_LEVEL_ERROR")
            return
        }
        guard tags.count >= 0 && tags.count <= 20 else {
            assertionFailure("Tags array count must be between 0 and 20 | ERROR : TAGS_COUNT_ERROR")
            return
        }
        
        let params = [
            "level": level.rawValue,
            "severity": severity,
            "message": message,
            "runtime": [
                "properties": [
                    "application": [
                        "type": "iOS",
                        "description": Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
                    ]
                ]
            ]
        ] as [String:Any]
        
        
        NetworkManager.shared.request(apiToken: self.apiToken!, endpoint: type.rawValue, method: .post, params: params) { (response) in
            print(response)
        }
    }
    
}
