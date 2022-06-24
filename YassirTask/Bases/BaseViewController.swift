//
//  BaseViewController.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import UIKit
import RxSwift
class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    deinit {
        print("deinit ", self.self)
    }

}
