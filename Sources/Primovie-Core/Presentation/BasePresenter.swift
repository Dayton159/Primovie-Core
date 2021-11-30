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
  public let disposeBag  = DisposeBag()
  public var state       = PublishSubject<NetworkState>()
  public var error       = PublishSubject<String>()

  public init() {}
}
