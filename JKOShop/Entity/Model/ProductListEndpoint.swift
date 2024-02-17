//
//  ProductListEndpoint.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

struct ProductListEndpoint: Endpoint {
    typealias Model = [ShopItem]
    var path: String { "Product_list" }
}
