//
//  CartViewModel.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift
import RxCocoa

final class CartViewModel {
    private let useCase: CartUseCase
    private let coordinator: CartViewCoordinatorProtocol

    init(
        useCase: CartUseCase,
        coordinator: CartViewCoordinatorProtocol
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

extension CartViewModel: ViewModelType {
    struct Input {
        let bindView: Driver<Void>
        let tapCell: Driver<CartViewCellViewModel>
        let clickCheckOut: Driver<Void>
    }
    struct Output {
        let list: Driver<[CartViewCellViewModel]>
        let isEnablePurchase: Driver<Bool>
        let configuration: Driver<Void>
    }
    func transform(_ input: Input) -> Output {

        let initalList = input.bindView
            .map { self.useCase.getCurrentChartItems() }

        let toggle = input.tapCell
            .map(useCase.toggleItems(_:))
            .map { self.useCase.getCurrentChartItems() }

        let list = Driver
            .merge(
                initalList,
                toggle
            )

        let toOrderView = input.clickCheckOut
            .flatMap {
                return self.coordinator.showOrderView()
                    .asDriverOnErrorJustComplete()
            }
        
        let isEnable = Driver
            .merge(
                input.bindView,
                toggle.map { _ in }
            )
            .map { _ in self.useCase.canCheckOut() }
            .distinctUntilChanged()

        let configuration = Driver
            .merge(
                toOrderView
            )

        return .init(
            list: list,
            isEnablePurchase: isEnable,
            configuration: configuration
        )
    }
}


