//
//  Endpoint.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

protocol Endpoint {
    associatedtype Model: Codable
    var path: String { get }
    var type: String { get }
    func getData() throws -> Data
}

extension Endpoint {
    var type: String {
        return "json"
    }
    func getData() throws -> Data {
        guard let bundlePath = Bundle.main.path(forResource: path, ofType: type) else {
            throw ErrorInfo(case: .pathMissing, message: "Endpoint layer")
        }
        let url = URL(fileURLWithPath: bundlePath)
        return try .init(contentsOf: url)
    }
}
