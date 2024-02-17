//
//  CartTableViewCell.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

class CartTableViewCell: UITableViewCell {

    private let pictureImageView: UIImageView = .init()
    private let checkBarView: UIImageView = .init()
    private let titleLabel: UILabel = .init()
    private let priceLabel: UILabel = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension CartTableViewCell {
    func setupView() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(checkBarView)
        checkBarView.image = .init(named: "uncheck")
        checkBarView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.size.equalTo(24)
        }
        contentView.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(checkBarView.snp.trailing).offset(16)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(4)
        }
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).inset(8)
            make.bottom.equalTo(pictureImageView.snp.bottom)
        }
        priceLabel.textAlignment = .right
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 16)
    }
}

// MARK: Public
extension CartTableViewCell {
    // FIXME: interface
    func config(viewModel: CartViewCellViewModel) {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        pictureImageView.kf.setImage(with: viewModel.image, placeholder: UIImage(named: "warning"), options: nil, completionHandler: nil)
        isCheck.onNext(viewModel.isSelected)
    }
    var isCheck: Binder<Bool> {
        return .init(checkBarView) { view, isCheck in
            view.image = isCheck ? .init(named: "check") : .init(named: "uncheck")
        }
    }
}
