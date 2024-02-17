//
//  MockUseCase.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import Foundation
import XCTest
@testable import JKOShop
@testable import RxSwift

typealias UseCaseProtocol = ProductListUseCase & ProductDetailUseCase

class MockUseCase: UseCaseProtocol {
    var injectRestePageCount: Observable<Void> = .empty()
    func resetPageCount() -> Observable<Void> {
        return injectRestePageCount
    }
    var injectPlusCount: Observable<Void> = .empty()
    func plusPage() -> Observable<Void> {
        return injectPlusCount
    }
    var injectGetShoppingList: [Observable<[ShopItemsViewModel]>] = []
    func getShoppingList() -> Observable<[ShopItemsViewModel]> {
        if !injectGetShoppingList.isEmpty {
            return injectGetShoppingList.removeFirst()
        }
        XCTFail()
        return .empty()
    }
    var injectAddToChart: ((ShopItemsViewModel) -> Void)?
    func addToChart(_ item: ShopItemsViewModel) {
        injectAddToChart?(item)
    }
    var injectShopItems: ShopItemsViewModel!
    func getCurrentShopItem() -> ShopItemsViewModel {
        return injectShopItems
    }
}
