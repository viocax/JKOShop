//
//  MockRepo.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import Foundation
@testable import JKOShop

class MockRepo: RepositoryProtocol {
    var selectKeys: [String] = []
    
    var injectCurrnetChart: (() -> ([ShopItemsViewModel]))?
    func getShopItemOfChart() -> [ShopItemsViewModel] {
        return injectCurrnetChart?() ?? []
    }

    var injectRemoveAllChart: (() -> Void)?
    func removeItemInChart(_ items: [ShopItemsViewModel]) {
        injectRemoveAllChart?()
    }
    var injectSaveToHistory: (([ShopItemsViewModel]) -> Void)?
    func saveToHistory(_ items: [ShopItemsViewModel]) {
        injectSaveToHistory?(items)
    }

    var injectGetHistory: [ShopItemsViewModel] = []
    func getHistory() -> [ShopItemsViewModel] {
        return injectGetHistory
    }
    var injectAddToChart: ((ShopItemsViewModel) -> Void)?
    func addToChart(_ item: ShopItemsViewModel) {
        injectAddToChart?(item)
    }
}
