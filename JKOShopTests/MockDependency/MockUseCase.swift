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

typealias UseCaseProtocol = ProductListUseCase & ProductDetailUseCase & CartUseCase & OrderCheckingUseCase & HistoryOrderUseCase

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
    var injectToggleEvent: ((CartViewCellViewModel) -> Void)?
    func toggleItems(_ cell: CartViewCellViewModel) {
        injectToggleEvent?(cell)
    }
    var injectCurrnetChartItems: [CartViewCellViewModel] = []
    func getCurrentChartItems() -> [CartViewCellViewModel] {
        return injectCurrnetChartItems
    }
    var injectCanCheckOut: (() -> Bool)?
    func canCheckOut() -> Bool {
        return injectCanCheckOut?() ?? false
    }
    
    var injectCheckOut: Observable<Void> = .empty()
    func checkOut() -> Observable<Void> {
        return injectCheckOut
    }

    var injectGetItemsToCheckOut: Observable<[OrderCellDisplayModel]> = .empty()
    func getItemsToCheckOut() -> Observable<[OrderCellDisplayModel]> {
        return injectGetItemsToCheckOut
    }
    var injectFooterModel: OrderFooterViewModel?
    func getFooterInfo() -> OrderFooterViewModel {
        return injectFooterModel!
    }
    var injectGetHistoryList: Observable<[ShopItemsViewModel]> = .empty()
    func getHistoryList() -> Observable<[ShopItemsViewModel]> {
        return injectGetHistoryList
    }
}
