//
//  HistoryOrderCoordinatorProtocol.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift

protocol HistoryOrderCoordinatorProtocol {
    func dismiss() -> Observable<Void>
}

extension Coordinator: HistoryOrderCoordinatorProtocol {
    func dismiss() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            viewController.dismiss(animated: true) {
                subscriber.onNext(())
                subscriber.onCompleted()
            }
            return Disposables.create()
        }
    }
}
