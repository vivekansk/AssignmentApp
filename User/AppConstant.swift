//
//  AppConstant.swift
//  User
//
//  Created by Krishna Vivek on 20/03/22.
//

import Foundation

class AppConstant : NSObject {
    
    static let sharedInstance = AppConstant()
    
    var isPrintAllowed = AppDelegate().isPrintAllowed
    
    func log(message: Any,
             file: String = #file,
             function: String = #function,
             line: Int = #line) {
        if isPrintAllowed {
            let url = NSURL(fileURLWithPath: file)
            print("\(message)\" \n(File: \(url.lastPathComponent ?? "?"), \nFunction: \(function),Line: \(line))\n\n")
        }
    }
}
