//
//  MockCoordinator.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import Foundation
@testable import JKOShop
@testable import RxSwift

typealias CoordinatorProcotol = ProductCoordinatorProcotol

class MockCoordinator: CoordinatorProcotol  {
    
    var injectShowDetailPage: ((ShopItemsViewModel) -> Observable<Void>)!
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void> {
        return injectShowDetailPage(model)
    }
    var injectShowHistoryView: Observable<Void> = .empty()
    func showHistoryView() -> Observable<Void> {
        return injectShowHistoryView
    }
    
}
