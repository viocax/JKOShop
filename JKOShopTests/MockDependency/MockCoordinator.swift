//
//  MockCoordinator.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import Foundation
@testable import JKOShop
@testable import RxSwift

typealias CoordinatorProcotol = ProductCoordinatorProcotol & ProductDetailCoordinatorProtocol & CartViewCoordinatorProtocol & OrderChekingCoordinatorProtocol

class MockCoordinator: CoordinatorProcotol  {
    
    var injectShowDetailPage: ((ShopItemsViewModel) -> Observable<Void>)!
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void> {
        return injectShowDetailPage(model)
    }
    var injectShowHistoryView: Observable<Void> = .empty()
    func showHistoryView() -> Observable<Void> {
        return injectShowHistoryView
    }

    var injectShowCartView: Observable<Void> = .empty()
    func showCartView() -> Observable<Void> {
        return injectShowCartView
    }

    var injectOrderCheckingView: (() -> Observable<Void>)!
    func showOrderCheckingView() -> Observable<Void> {
        return injectOrderCheckingView()
    }

    var injectMoreOrderCheckingView: (() -> Observable<Void>)!
    func showOrderView() -> Observable<Void> {
        return injectMoreOrderCheckingView()
    }
    var injectShowAlert: Observable<Void> = .empty()
    func showAlert() -> Observable<Void> {
        return injectShowAlert
    }
    
    var injectPopToRoot: Observable<Void> = .empty()
    func popToRoot() -> Observable<Void> {
        return injectPopToRoot
    }
}
