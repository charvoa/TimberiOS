//
//  TimberLogger.swift
//  TimberiOS
//
//  Created by Nicolas on 28/09/2017.
//

import Foundation
//import Alamofire



public enum LogType: String {
    case frame = "frames"
    case alert = "alert"
}

public enum LogLevel: String {
    case debug = "debug"
    case info = "info"
    case notice = "notice"
    case warn = "warn"
    case error = "error"
    case critical = "critical"
    case alert = "alert"
    case emergency = "emergency"
}

public enum InternalLogLevel: String {
    case debugInternal
    case warnInternal
    case criticalInternal
}

open class TimberLogger: NSObject {
    
    public static let shared = TimberLogger()
    
    var apiToken: String?
    var sourceIdentification: String?
    var internalLogLevel: InternalLogLevel?
    private var uniqueIdentifier: String?

    // MARK: Private Static variables
    private static let debugLevelArray: [LogLevel] = [.debug, .info, .notice, .warn, .error, .critical, .alert, .emergency]
    private static let warnLevelArray: [LogLevel]  = [.warn, .error, .critical, .alert, .emergency]
    private static let criticalLevelArray: [LogLevel]  = [.critical, .alert, .emergency]
    private static let logLevelEmoji: [LogLevel:String] = [
        .debug: "🖥️",
        .info: "ℹ️",
        .notice: "🔔",
        .warn: "⚠️",
        .error: "⛔",
        .critical:"❌",
        .alert:"☣️",
        .emergency:"🆘"
    ]
    
    private var internalLogLevelArray: [LogLevel]?
    
    private override init() {}

    public static func initialize(with apiToken: String,
                                  sourceIdentification: String,
                                  internalLogLevel: InternalLogLevel,
                                  uniqueIdentifier: String) {
        TimberLogger.shared.apiToken = apiToken
        TimberLogger.shared.sourceIdentification = sourceIdentification
        TimberLogger.shared.internalLogLevel = internalLogLevel
        TimberLogger.shared.uniqueIdentifier = uniqueIdentifier

        switch (internalLogLevel) {
            case .debugInternal:
                TimberLogger.shared.internalLogLevelArray = debugLevelArray
            case .warnInternal:
                TimberLogger.shared.internalLogLevelArray = warnLevelArray
            case .criticalInternal:
                TimberLogger.shared.internalLogLevelArray = criticalLevelArray
        }
    }
    
    open func log(type: LogType,
                  level: LogLevel,
                  severity: Int,
                  tags: [String],
                  message:String) {

        guard let apiToken = self.apiToken else {
            assertionFailure("Could not initalize TimberLogger without apiToken | ERROR : INIT_API_TOKEN_ERROR")
            return
        }
        guard let sourceIdentification = self.sourceIdentification else {
            assertionFailure("Could not initalize TimberLogger without sourceIdentification | ERROR : INIT_SOURCE_IDENTIFICATION_ERROR")
            return
        }
        guard self.internalLogLevel != nil else {
            assertionFailure("Could not initialize TimberLogger without InternalLogLevel | ERROR : INIT_INTERNAL_LOG_LEVEL_ERROR")
            return
        }
        guard self.internalLogLevelArray != nil else {
            assertionFailure("Could not initialize TimberLogger without InternalLogLevelArray | ERROR : INIT_INTERNAL_LOG_LEVEL_ARRAY_ERROR")
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
            ],
            "device": [
                "identifier": TimberLogger.shared.uniqueIdentifier
            ],
            "user": [
                "identifier": "accountId",
                "phoneNumber": "+33769069025"
            ],
            "tags": tags
        ] as [String: Any]

        if (TimberLogger.shared.internalLogLevelArray?.contains(level))! {
            let emoji: String! = TimberLogger.logLevelEmoji[level]
            let line: String = "\n--------------------\n"
            
            print(line + emoji + "\n" + " \(params as AnyObject)" + line)
        }

        NetworkManager.shared.request(apiToken: apiToken, sourceIdentification: sourceIdentification, endpoint: type.rawValue, method: .post, params: params) { (response) in
            print(response)
        }
    }
}
