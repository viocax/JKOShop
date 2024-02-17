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
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = UseCase.ProductDetail(model: model)
            let coordinator = Coordinator()
            let viewModel = ProductDetailViewModel(useCase: useCase, coordinator: coordinator)
            let detailView = ProductDetailViewController(viewModel)
            coordinator.viewController = detailView
            viewController.navigationController?.pushViewController(detailView, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
    func showHistoryView() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = UseCase.HistoryOrder()
            let coordinator = Coordinator()
            let viewModel = HistoryOrderViewModel(useCase: useCase, coordinator: coordinator)
            let history = HistoryOrderViewController(viewModel: viewModel)
            history.modalPresentationStyle = .fullScreen
            coordinator.viewController = history
            viewController.present(history, animated: true, completion: {
                subscriber.onNext(())
                subscriber.onCompleted()
            })
            return Disposables.create()
        }
    }
}
