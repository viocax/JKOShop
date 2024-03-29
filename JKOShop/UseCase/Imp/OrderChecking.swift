//
//  OrderChecking.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift
import Kingfisher

extension UseCase {
    class OrderChecking {
        private let repository: RepositoryProtocol
        init(repository: RepositoryProtocol = Repository.shared) {
            self.repository = repository
        }
    }
}

extension UseCase.OrderChecking: OrderCheckingUseCase {
    func getFooterInfo() -> OrderFooterViewModel {
        struct TempFooter: OrderFooterViewModel {
            var content: String
            var priceString: String
        }
        let totalPrice = repository.getShopItemOfChart()
            .reduce(.zero, { currentPrice, nextModel -> Int in
                return currentPrice + nextModel.price
            })
        let content = "您的購物袋符合棉額外付費運送服務資格\n分期付款僅於購買單件商品提供。請注意，行動支付僅支持全額付款。\n欲享有多種分期付款方式請至實體門市消費。"
        return TempFooter(
            content: content,
            priceString: "總共金額:$\(totalPrice)"
        )
    }
    func checkOut() -> Observable<Void> {
        let checkoutToServer = Observable.just(repository) // replace to server event
        return checkoutToServer.map { repo -> Void in
            let needToPurchaseList = repo.getShopItemOfChart()
                .filter { repo.selectKeys.contains($0.identifier) }
            repo.saveToHistory(needToPurchaseList)
            repo.removeItemInChart(needToPurchaseList)
            return repo.selectKeys = []
        }
        .delay(.milliseconds(1500), scheduler: MainScheduler.instance)
    }
    func getItemsToCheckOut() -> Observable<[OrderCellDisplayModel]> {
        struct TempOrderCell: OrderCellDisplayModel {
            var id: String
            var image: Resource
            var title: String
            var price: String
        }
        return .create { [weak self] subscriber in
            let selectKeys = self?.repository.selectKeys ?? []
            let currentListInChart = (self?.repository.getShopItemOfChart() ?? [])
                .filter { selectKeys.contains($0.identifier) }
            let dictionary = Dictionary(
                grouping: currentListInChart,
                by: { $0.identifier }
            )
            let list = dictionary
                .reduce(.init(), { current, next -> [OrderCellDisplayModel] in
                    guard !next.value.isEmpty else {
                        return current
                    }
                    let count = next.value.count
                    let info = next.value[0]
                    let price = "$ \(info.price) * \(count) = \(info.price * count)"
                    let new = TempOrderCell(id: info.identifier, image: info.image, title: info.title, price: price)
                    return current + [new]
                })
            subscriber.onNext(list)
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
}
