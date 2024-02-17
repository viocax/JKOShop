//
//  ProductDetailCoordinatorProtocol.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import RxSwift

protocol ProductDetailCoordinatorProtocol {
    func showCartView() -> Observable<Void>
    func showOrderCheckingView() -> Observable<Void>
}

extension Coordinator: ProductDetailCoordinatorProtocol {
    func showCartView() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = UseCase.Cart()
            let coordinator = Coordinator()
            let viewModel = CartViewModel(useCase: useCase, coordinator: coordinator)
            let chartView = CartViewController(viewModel: viewModel)
            coordinator.viewController = chartView
            navigation.pushViewController(chartView, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
    func showOrderCheckingView() -> Observable<Void> {
        fatalError()
    }
}
