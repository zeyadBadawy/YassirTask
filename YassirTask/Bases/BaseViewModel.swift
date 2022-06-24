//
//  BaseViewModel.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import RxSwift
import RxRelay

class BaseViewModel: DisposeObject {
    var stateRelay = BehaviorRelay<ViewModelState<BaseError>>.init(value: .idle)
    var alertItemRelay = BehaviorRelay<AlertItem?>.init(value: nil)
}
