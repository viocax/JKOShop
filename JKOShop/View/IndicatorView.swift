//
//  IndicatorView.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import UIKit
import RxSwift

class IndicatorView: UIView {
    private let blurView: UIView = .init()
    private let indicatorView: UIActivityIndicatorView = .init(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView() {
        isUserInteractionEnabled = true
        addSubview(blurView)
        blurView.isUserInteractionEnabled = true
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blurView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(67)
        }
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(35)
        }
    }
    public func startAnimation() {
        indicatorView.startAnimating()
    }
    public func stopAnimation() {
        indicatorView.stopAnimating()
    }
}

extension Reactive where Base: UIView {
    var indicatorAnimator: Binder<Bool> {
        return Binder(self.base) { (targetView, isLoading) in
            if isLoading {
                let indicatorView: IndicatorView
                if let indicator = self.base.subviews.first(where: { $0 is IndicatorView }) as? IndicatorView {
                    indicatorView = indicator
                } else {
                    let indicator = IndicatorView()
                    self.base.addSubview(indicator)
                    indicator.translatesAutoresizingMaskIntoConstraints = false
                    indicator.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                    indicatorView = indicator
                }
                indicatorView.startAnimation()
            } else {
                let indicator = self.base.subviews.first(where: { $0 is IndicatorView }) as? IndicatorView
                indicator?.stopAnimation()
                indicator?.removeFromSuperview()
            }
         }
     }
}
