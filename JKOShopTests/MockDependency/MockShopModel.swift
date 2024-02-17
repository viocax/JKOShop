//
//  MockShopModel.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import Foundation
@testable import JKOShop
@testable import Kingfisher

class MockShopModel: ShopItemsViewModel {
    var identifier: String = UUID().uuidString
    var title: String = ""
    var description: String = ""
    var price: Int = 999
    var image: Resource = RandomImageInfo(urlString: "")
    var createTime: Date = .init()
    init(_ id: Int) {
        self.title = "Test: \(id)"
    }
}
