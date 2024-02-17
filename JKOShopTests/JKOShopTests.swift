//
//  JKOShopTests.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import XCTest
@testable import JKOShop
@testable import RxTest
@testable import RxBlocking
@testable import RxSwift

final class JKOShopTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let test = Observable.just(())
            .toBlocking().materialize()
        switch test {
        case .completed(let elements):
            XCTAssertTrue(true)
        case .failed(let elements, let error):
            XCTAssertTrue(false)
        }
        let testSche = TestScheduler(initialClock: .zero)
        let bag = DisposeBag()
        let expect: [Recorded<Event<Void>>] = [
            .next(0, ())
        ]
        let obser = testSche.createObserver(Void.self)
        testSche.createColdObservable(expect)
            .bind(to: obser)
            .disposed(by: bag)
        testSche.start()
        XCTAssertEqual(expect.map(\.time), obser.events.map(\.time))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
