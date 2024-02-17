//
//  OrderChekingCoordinatorProtocol.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift
import UIKit

protocol OrderChekingCoordinatorProtocol {
    func showAlert() -> Observable<Void>
    func popToRoot() -> Observable<Void>
}

extension Coordinator: OrderChekingCoordinatorProtocol {
    func showAlert() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            // TODO: 資料抽象
            let alert = UIAlertController(title: "付款成功", message: "請至交易紀錄查看詳細資料", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                subscriber.onNext(())
                subscriber.onCompleted()
            }
            alert.addAction(okAction)
            viewController.present(alert, animated: true, completion: nil)
            return Disposables.create()
        }
    }
    func popToRoot() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            navigation.popToRootViewController(animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
}
