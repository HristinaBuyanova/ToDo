import Foundation
import CocoaLumberjackSwift

struct Logger {

    static func setupLogger() {
        let loger = DDOSLogger.sharedInstance
        DDLog.add(loger)

        let fileLogger: DDFileLogger = DDFileLogger()
        fileLogger.rollingFrequency = TimeInterval(60*60*24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger, with: .info)
    }

    static func verbose(_ message: DDLogMessageFormat) {
        DDLogVerbose(message)
    }

    static func info(_ message: DDLogMessageFormat) {
        DDLogInfo(message)
    }

    static func error(_ message: DDLogMessageFormat) {
        DDLogError(message)
    }

    static func warm(_ message: DDLogMessageFormat) {
        DDLogWarn(message)
    }

}
