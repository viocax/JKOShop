//
//  ProductDetailViewModel.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift
import RxCocoa

final class ProductDetailViewModel {
    private let useCase: ProductDetailUseCase
    private let coordinator: ProductDetailCoordinatorProtocol

    init(
        useCase: ProductDetailUseCase,
        coordinator: ProductDetailCoordinatorProtocol
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

extension ProductDetailViewModel: ViewModelType {
    struct Input {
        let addToChat: Driver<Void>
        let purchase: Driver<Void>
        let bindView: Driver<Void>
    }
    struct Output {
        let configuration: Driver<Void>
        let displayModel: Driver<ShopItemsViewModel>
    }
    func transform(_ input: Input) -> Output {
        let displayModel = input.bindView
            .map { self.useCase.getCurrentShopItem() }

        let gotoChartView = input.addToChat
            .withLatestFrom(displayModel)
            .map(useCase.addToChart(_:))
            .flatMap {
                return self.coordinator.showCartView()
                    .asDriverOnErrorJustComplete()
            }

        let gotoOrderView = input.purchase
            .withLatestFrom(displayModel)
            .map(useCase.addToChart(_:))
            .flatMap { item in
                return self.coordinator.showOrderCheckingView()
                    .asDriverOnErrorJustComplete()
            }

        let configuration = Driver
            .merge(
                gotoChartView,
                gotoOrderView
            )

        return .init(
            configuration: configuration,
            displayModel: displayModel
        )
    }
}
