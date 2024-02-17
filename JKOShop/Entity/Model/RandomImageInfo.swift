//
//  RandomImageInfo.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import protocol Kingfisher.Resource

struct RandomImageInfo: Resource {
    var cacheKey: String
    private let urlString: String
    var downloadURL: URL {
        guard let url = URL(string: urlString) else {
            fatalError("checking")
        }
        return url
    }
    init(urlString: String, _ key: String = UUID().uuidString) {
        self.cacheKey = key
        self.urlString = urlString
    }
}
