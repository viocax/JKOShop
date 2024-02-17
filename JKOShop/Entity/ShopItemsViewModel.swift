//
//  ShopItemsViewModel.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import protocol Kingfisher.Resource

protocol ShopItemsViewModel {
    var identifier: String { get set }
    var title: String { get }
    var description: String { get set }
    var price: Int { get }
    var image: Resource { get }
    var createTime: Date { get }
}
