//
//  GetItemPresenter.swift
//  
//
//  Created by Dayton on 28/11/21.
//

import RxSwift
import RxCocoa

public class GetItemPresenter<Request, Response, Interactor: UseCase>: BasePresenter
where Interactor.Request == Request, Interactor.Response == Response {

  private let _useCase: Interactor
  private let item = BehaviorRelay<Response?>(value: nil)

  public var itemObs: Observable<Response?> {
    return self.item.asObservable()
  }

  public init(useCase: Interactor) {
    _useCase = useCase
  }

  public func getItem(request: Request?) {
    self.state.onNext(.loading)

    _useCase.execute(request: request)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] item in
        guard let self = self else { return }
        self.item.accept(item)
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self else { return }
        self.state.onNext(.error)
        self.error.onNext(error.localizedDescription)
      }).disposed(by: disposeBag)
  }
}
