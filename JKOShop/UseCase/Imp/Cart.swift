//
//  Cart.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import Kingfisher

extension UseCase {
    class Cart {
        private let repository: RepositoryProtocol
        init(repository: RepositoryProtocol = Repository.shared) {
            self.repository = repository
        }
    }
}

extension UseCase.Cart: CartUseCase {
    private struct WrapShopInfo: CartViewCellViewModel {
        var id: String
        var image: Resource
        var title: String
        var price: String
        var isSelected: Bool
    }
    func getCurrentChartItems() -> [CartViewCellViewModel] {
        let selectID = repository.selectKeys
        let dictionary = Dictionary(
            grouping: repository.getShopItemOfChart().enumerated(),
            by: { $0.element.identifier }
        )

        return dictionary
            .reduce([], { current, next -> [(CartViewCellViewModel, Int)] in
                guard !next.value.isEmpty else {
                    return current
                }
                let count = next.value.count
                let info = next.value[0].element
                let price = "$ \(info.price) * \(count) = \(info.price * count)"
                let isSelected = selectID.contains(next.key)
                let newNext: [(CartViewCellViewModel, Int)] = [
                    (
                        WrapShopInfo(
                            id: info.identifier,
                            image: info.image,
                            title: info.title,
                            price: price,
                            isSelected: isSelected
                        ),
                        next.value[0].offset
                    )
                ]
                return current + newNext
            })
            .sorted(by: { $0.1 < $1.1 })
            .map(\.0)
    }
    func canCheckOut() -> Bool {
        return !repository.selectKeys.isEmpty
    }
    func toggleItems(_ cell: CartViewCellViewModel) {
        let isSelect = !cell.isSelected
        let currentSelectID = repository.selectKeys
        if isSelect {
            repository.selectKeys += [cell.id]
        } else {
            guard let index = currentSelectID.firstIndex(of: cell.id) else {
                return
            }
            repository.selectKeys.remove(at: index)
        }
    }
}
