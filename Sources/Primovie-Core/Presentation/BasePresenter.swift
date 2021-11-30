//
//  File.swift
//  
//
//  Created by Dayton on 28/11/21.
//

import RxSwift

public enum NetworkState {
  case loading
  case finish
  case error
}

open class BasePresenter {
  let disposeBag  = DisposeBag()
  var state       = PublishSubject<NetworkState>()
  var error       = PublishSubject<String>()
}
