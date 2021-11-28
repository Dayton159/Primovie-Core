//
//  Interactor.swift
//  
//
//  Created by Dayton on 28/11/21.
//

import RxSwift

public struct Interactor<Request, Response, R: Repository>: UseCase
where R.Request == Request, R.Response == Response {

  private let _repository: R

  public init(repository: R) {
    self._repository = repository
  }

  public func execute(request: Request?) -> Single<Response> {
    self._repository.execute(request: request)
  }
}
