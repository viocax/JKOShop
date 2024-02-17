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
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = UseCase.OrderChecking()
            let coordinator = Coordinator()
            let viewModel = OrderCheckingViewModel(useCase: useCase, coordinator: coordinator)
            let orderCheck = OrderCheckingViewController(viewModel: viewModel)
            coordinator.viewController = orderCheck
            navigation.pushViewController(orderCheck, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
}
