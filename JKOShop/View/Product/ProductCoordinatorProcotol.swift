//
//  ProductCoordinatorProcotol.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift

protocol ProductCoordinatorProcotol {
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void>
    func showHistoryView() -> Observable<Void>
}

extension Coordinator: ProductCoordinatorProcotol {
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void> {
        fatalError()
    }
    func showHistoryView() -> Observable<Void> {
        fatalError()
    }
}
