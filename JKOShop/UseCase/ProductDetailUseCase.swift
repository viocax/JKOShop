//
//  ProductDetailUseCase.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

protocol ProductDetailUseCase {
    func getCurrentShopItem() -> ShopItemsViewModel
    func addToChart(_ item: ShopItemsViewModel)
}
