//
//  ProductDetailCoordinatorProtocol.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import RxSwift

protocol ProductDetailCoordinatorProtocol {
    func showChartView() -> Observable<Void>
    func showOrderCheckingView() -> Observable<Void>
}

extension Coordinator: ProductDetailCoordinatorProtocol {
    func showChartView() -> Observable<Void> {
        fatalError()
    }
    func showOrderCheckingView() -> Observable<Void> {
        fatalError()
    }
}
