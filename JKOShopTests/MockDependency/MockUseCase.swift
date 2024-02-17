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

typealias UseCaseProtocol = ProductListUseCase

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
}
