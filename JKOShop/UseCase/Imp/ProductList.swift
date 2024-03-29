//
//  ProductList.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import RxSwift

extension UseCase {
    class ProductList {
        private var pageCount: Int = 1
        // MARK: from server will better
        private let maxPage: Int
        private let service: NetworkService
        private var tempList: [ShopItemsViewModel] = []
        
        init(service: NetworkService = APIService(), maxCount: Int = 5) {
            self.service = service
            self.maxPage = maxCount
        }
    }
}

extension UseCase.ProductList: ProductListUseCase {
    func resetPageCount() -> Observable<Void> {
        tempList = []
        return .just(pageCount = 1)
    }

    func plusPage() -> Observable<Void> {
        return .just(pageCount += 1)
    }

    func getShoppingList() -> Observable<[ShopItemsViewModel]> {
        let currentCount = pageCount
        guard currentCount <= maxPage else {
            return .empty()
        }
        let result = service.request(ProductListEndpoint())
            .map { [weak self] item -> [ShopItemsViewModel] in
                let new = item + item + item + item + item + item + item
                let tempNames = ["Dan", "Ben", "Ken", "Jane", "Kylle"]
                let result = new.map { showItem  -> ShopItemsViewModel  in
                    var copy = showItem
                    copy.randomImageURL()
                    copy.identifier = UUID().uuidString + copy.identifier
                    copy.name = "Page: \(currentCount), Name: \(tempNames.randomElement() ?? "")"
                    copy.description = "interger \(currentCount)" + copy.description
                    copy.price = copy.price + [20, 30, 40, 50].randomElement()!
                    return copy
                }
                self?.tempList += result
                return self?.tempList ?? []
            }
        return result
    }
    #if DEBUG
    func getCurrentCount() -> Int {
        return pageCount
    }
    #endif
}
