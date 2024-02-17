//
//  CartViewCoordinatorProtocol.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift

protocol CartViewCoordinatorProtocol {
    func showOrderView() -> Observable<Void>
}

extension Coordinator: CartViewCoordinatorProtocol {
    func showOrderView() -> Observable<Void> {
        fatalError()
    }
}
