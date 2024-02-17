//
//  ViewController.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import Kingfisher

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let relay = PublishRelay<Void>()
        let driver = Driver.just(())
        let v = UIImageView()
        view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.snp.makeConstraints { make in
            
        }
        v.kf.cancelDownloadTask()
    }


}

