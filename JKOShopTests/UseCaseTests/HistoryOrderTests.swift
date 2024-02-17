//
//  HistoryOrderTests.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import XCTest
@testable import JKOShop
@testable import RxBlocking

class HistoryOrderTests: XCTestCase {

    func test_GetHistoryList() {
        let mockRepo = MockRepo()
        let useCase = UseCase.HistoryOrder(repository: mockRepo)
        let mockModels: [ShopItemsViewModel] = (0...10).map(MockShopModel.init)
        mockRepo.injectGetHistory = mockModels

        let expetResultList = useCase.getHistoryList()
            .toBlocking().materialize()
        switch expetResultList {
        case .completed(let elements):
            XCTAssertEqual(elements.count, 1)
            zip(mockModels, elements[0]).forEach { mock, result in
                XCTAssertEqual(mock.identifier, result.identifier)
                XCTAssertEqual(mock.createTime, result.createTime)
                XCTAssertEqual(mock.price, result.price)
                XCTAssertEqual(mock.title, result.title)
            }
        case .failed:
            XCTFail()
        }
    }
}
