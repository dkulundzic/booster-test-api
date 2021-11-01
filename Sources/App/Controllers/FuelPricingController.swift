import Foundation
import Vapor

struct FuelPricingController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let fuelPricing = routes.grouped("fuel-pricing")
    fuelPricing.get(use: get)
  }
  
  func get(request: Request) throws -> EventLoopFuture<FuelPricing> {
    FuelPricing.query(on: request.db).first().unwrap(or: Abort(.notFound))
  }
}
