//
//  Mapper.swift
//  
//
//  Created by Dayton on 28/11/21.
//

public protocol Mapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain

  func transformResponseToEntity(response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
  func transformDomainToEntity(domain: Domain) -> Entity
}
