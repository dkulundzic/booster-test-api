//
//  File.swift
//  
//
//  Created by Domagoj Kulundzic on 01.11.2021..
//

import Foundation
import Vapor

struct BoostController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let boosts = routes.grouped("boosts")
    boosts.get(use: get)
    boosts.post(use: create)
    boosts.group(":id") { boost in
      boost.delete(use: delete)
    }
  }
}

extension BoostController {
  func get(request: Request) throws -> EventLoopFuture<[Boost]> {
    Boost.query(on: request.db).all()
  }
  
  func create(request: Request) throws -> EventLoopFuture<Boost> {
    let boost = try request.content.decode(Boost.self)
    return boost.save(on: request.db).map { boost }
  }
  
  func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
    Boost
      .find(request.parameters.get("id"), on: request.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { $0.delete(on: request.db) }
      .transform(to: .ok)
  }
}
