//
//  Log.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/01.
//
import OSLog
import Foundation


extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
}

struct Log {
    enum Level {
        case debug
        case info
        case network
        case error
        
        fileprivate var category: String {
            switch self {
                case .debug:
                    return "Debug"
                case .info:
                    return "Info"
                case .network:
                    return "Network"
                case .error:
                    return "Error"
            }
        }
        
        fileprivate var osLog: OSLog {
            switch self {
                case .debug:
                    return OSLog.debug
                case .info:
                    return OSLog.info
                case .network:
                    return OSLog.network
                case .error:
                    return OSLog.error
            }
        }
        
        fileprivate var osLogType: OSLogType {
            switch self {
                case .debug:
                    return .debug
                case .info:
                    return .info
                case .network:
                    return .default
                case .error:
                    return .error
            }
        }
    }
    
    static private func log(_ message: Any, _ arguments: [Any], level: Level) {
        #if DEVLEOPE
        if #available(iOS 14.0, *) {
            let extraMessage: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
            let logger = Logger(subsystem: OSLog.subsystem, category: level.category)
            let logMessage = "\(message) \(extraMessage)"
            switch level {
                case .debug:
                    logger.debug("\(logMessage, privacy: .public)")
                case .info:
                    logger.info("\(logMessage, privacy: .public)")
                case .network:
                    logger.log("\(logMessage, privacy: .public)")
                case .error:
                    logger.error("\(logMessage, privacy: .public)")
            }
        } else {
            let extraMessage: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
            os_log("%{public}@", log: level.osLog, type: level.osLogType, "\(message) \(extraMessage)")
        }
        #endif
    }
}

extension Log {
    static func debug(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .debug)
    }
    
    static func info(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .info)
    }
    
    static func network(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .network)
    }
    
    static func error(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .network)
    }
}
