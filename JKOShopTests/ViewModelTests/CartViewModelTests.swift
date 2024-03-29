//
//  CartViewModelTests.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import XCTest
@testable import JKOShop
@testable import RxSwift
@testable import RxTest
@testable import RxCocoa
@testable import Kingfisher

final class CartViewModelTests: XCTestCase {
    
    class Model: CartViewCellViewModel {
        var id: String
        var image: Resource
        var title: String
        var price: String
        var isSelected: Bool = false
        init(id: Int) {
            let model = MockShopModel(id)
            self.id = model.identifier
            self.image = model.image
            self.title = model.title
            self.price = "\(model.price)"
        }
    }
    func test_bindView_and_toggle() {
        let testScheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let mockUseCase = MockUseCase()
        let mockCoordinator = MockCoordinator()
        let viewModel = CartViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
        let triggerBindView = PublishRelay<Void>()
        let triggerTapCell = PublishRelay<CartViewCellViewModel>()
        let input = CartViewModel
            .Input(
                bindView: triggerBindView.asDriverOnErrorJustComplete(),
                tapCell: triggerTapCell.asDriverOnErrorJustComplete(),
                clickCheckOut: .empty()
            )
        let mockModels: [CartViewCellViewModel] = (0...10).map(Model.init)
        mockUseCase.injectCurrnetChartItems = mockModels
        mockUseCase.injectToggleEvent = { model in
            let isContain = mockModels.contains(where: { $0.title == model.title })
            XCTAssertTrue(isContain)
        }
        mockUseCase.injectCanCheckOut = {
            return true
        }

        let output = viewModel.transform(input)
        // MARK: trigger UpStream
        let bineView = testScheduler.createColdObservable([
            .next(100, ())
        ])
        bineView.bind(to: triggerBindView)
            .disposed(by: disposeBag)

        let tapCell = testScheduler.createColdObservable([
            .next(200, mockModels[0]),
            .next(300, mockModels[2])
        ])
        tapCell.bind(to: triggerTapCell)
            .disposed(by: disposeBag)

        let expectList: [Recorded<Event<[CartViewCellViewModel]>>] = [
            .next(100, mockModels),
            .next(200, mockModels),
            .next(300, mockModels)
        ]
        
        let observerList = testScheduler.createObserver([CartViewCellViewModel].self)
        output.list.drive(observerList)
            .disposed(by: disposeBag)

        let expecIsEnable: [Recorded<Event<Bool>>] = [
            .next(100, true)
        ]
        let observerIsEnable = testScheduler.createObserver(Bool.self)
        output.isEnablePurchase
            .drive(observerIsEnable)
            .disposed(by: disposeBag)
        
        testScheduler.start()

        XCTAssertEqual(expectList.map(\.time), observerList.events.map(\.time))
        XCTAssertEqual(expecIsEnable, observerIsEnable.events)
        
    }

}
