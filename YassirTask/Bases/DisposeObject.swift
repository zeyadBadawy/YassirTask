//
//  DisposeObject.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import RxSwift

class DisposeObject {
    var deinitCalled: (() -> Void)?
    var disposeBag: DisposeBag
    
    init() {
        self.disposeBag = DisposeBag()
    }
    
    deinit {
        deinitCalled?()
    }
}
