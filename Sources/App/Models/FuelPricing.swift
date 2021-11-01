import Foundation
import Vapor
import FluentKit

public final class FuelPricing: Model, Content {
  public static var schema: String = "fuel_pricing"

  @ID(key: .id) public var id: UUID?
  @Field(key: .regularPrice) public var regularPrice: Float
  @Field(key: .premiumPrice) public var premiumPrice: Float
  
  public init() { }
  
  public init(
    regularPrice: Float,
    premiumPrice: Float
  ) {
    self.regularPrice = regularPrice
    self.premiumPrice = premiumPrice
  }
}

private extension FieldKey {
  static let regularPrice = FieldKey.string("regularPrice")
  static let premiumPrice = FieldKey.string("premiumPrice")
}
