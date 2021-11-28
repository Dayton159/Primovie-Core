//
//  LocaleDataSource.swift
//  
//
//  Created by Dayton on 28/11/21.
//

import RxSwift

public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> Single<Response>
}
