//
//  ErrorInfo.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

struct ErrorInfo: Error, Equatable {
    var `case`: ErrorCase
    var message: String
}

enum ErrorCase: Error {
    case decodeError, unspport, pathMissing
}
