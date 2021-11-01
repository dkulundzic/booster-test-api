import Foundation
import FluentKit
import Vapor

public final class Boost: Model, Content {
  public static var schema = "boosts"
  
  public enum DeliveryWindow: String, CaseIterable, Codable {
    case morning
    case afternoon
  }
  
  public enum PaymentMethod: String, CaseIterable, Codable {
    case cash
    case creditCard = "credit_card"
  }
  
  @ID(key: .id) public var id: UUID?
  @Field(key: .date) public var date: Date
  @Enum(key: .deliveryWindow) public var deliveryWindow: DeliveryWindow
  @Enum(key: .paymentMethod) public var paymentMethod: PaymentMethod
  
  public init() { }
  
  public init(
    date: Date,
    deliveryWindow: Boost.DeliveryWindow,
    paymentMethod: Boost.PaymentMethod
  ) {
    self.date = date
    self.deliveryWindow = deliveryWindow
    self.paymentMethod = paymentMethod
  }
}

extension Boost: Equatable {
  public static func == (lhs: Boost, rhs: Boost) -> Bool {
    lhs.id == rhs.id
  }
}

private extension FieldKey {
  static let date = FieldKey.string("date")
  static let deliveryWindow = FieldKey.string("deliveryWindow")
  static let paymentMethod = FieldKey.string("paymentMethod")
}
