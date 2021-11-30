//
//  GetListPresenter.swift
//  
//
//  Created by Dayton on 28/11/21.
//

import RxSwift
import RxCocoa
import Foundation

public class GetListPresenter<Request, Response, Interactor: UseCase>: BasePresenter
where Interactor.Request == Request, Interactor.Response == [Response] {

  private let _useCase: Interactor
  private let list = BehaviorRelay<[Response]>(value: [])

  public var listObs: Observable<[Response]> {
    return self.list.asObservable()
  }

  public init(useCase: Interactor) {
    _useCase = useCase
  }

  public var getNumberOfItems: Int {
    return list.value.count
  }

  public func getItemAt(_ index: IndexPath) -> Response {
    return self.list.value[indexPath.row]
  }

  public func getList(request: Request?) {
    self.state.onNext(.loading)

    _useCase.execute(request: request)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] list in
        guard let self = self else { return }
        self.list.accept(list)
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self else { return }
        self.state.onNext(.error)
        self.error.onNext(error.localizedDescription)
      }).disposed(by: disposeBag)
  }
}
