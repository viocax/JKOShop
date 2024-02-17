//
//  HistoryOrder.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift

extension UseCase {
    class HistoryOrder {
        private let repository: RepositoryProtocol
        init(repository: RepositoryProtocol = Repository.shared) {
            self.repository = repository
        }
    }
}

// MARK: HistoryOrderUseCase
extension UseCase.HistoryOrder: HistoryOrderUseCase {
    func getHistoryList() -> Observable<[ShopItemsViewModel]> {
        return .just(repository.getHistory())
    }
}
