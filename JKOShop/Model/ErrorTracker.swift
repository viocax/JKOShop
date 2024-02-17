//
//  ErrorTracker.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import RxCocoa
import RxSwift

class ErrorTracker: SharedSequenceConvertibleType {
    typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<ErrorInfo>()

    func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable()
            .do(onError: onErrorDo)
    }

    func asSharedSequence() -> SharedSequence<SharingStrategy, ErrorInfo> {
        return _subject.asObservable()
            .asDriver(onErrorDriveWith: .empty())
    }

    func asObservable() -> Observable<ErrorInfo> {
        return _subject.asObservable()
    }

    func onErrorDo(_ error: Error) {
        if let info = error as? ErrorInfo {
            _subject.onNext(info)
        } else {
            _subject.onNext(ErrorInfo.init(case: .unspport, message: "\(error.localizedDescription)"))
        }
    }

    deinit {
        _subject.onCompleted()
    }
}

extension ObservableConvertibleType {
    func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
}
