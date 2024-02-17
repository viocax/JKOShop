//
//  ProductDetailUseCaseTests.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import XCTest
@testable import JKOShop

class ProductDetailUseCaseTessts: XCTestCase {

    func test() {
        let mockModel = MockShopModel(999)
        let mockRepo = MockRepo()
        let useCase = UseCase.ProductDetail(model: mockModel, repository: mockRepo)
        let expect = expectation(description: "call addTo chart")
        mockRepo.injectAddToChart = { model in
            XCTAssertEqual(model.identifier, mockModel.identifier)
            expect.fulfill()
        }
        useCase.addToChart(mockModel)
        wait(for: [expect], timeout: 0.1)
    }
}
