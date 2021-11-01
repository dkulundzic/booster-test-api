import Foundation
import FluentKit

struct CreateFuelInformation: Migration {
  private enum Fields: String {
    case regularPrice
    case premiumPrice
  }
  
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database
      .schema(FuelPricing.schema)
      .id()
      .field(.string(Fields.regularPrice.rawValue), .float)
      .field(.string(Fields.premiumPrice.rawValue), .float)
      .create()
      .flatMap {
        let placeholderFuelInformation = FuelPricing(regularPrice: 3.55, premiumPrice: 7.11)
        return placeholderFuelInformation.save(on: database)
      }
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database
      .schema(FuelPricing.schema)
      .delete()
  }
}
