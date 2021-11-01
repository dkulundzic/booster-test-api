

import Foundation
import FluentKit

struct CreateBoost {
  private enum Fields: String {
    case date
    case deliveryWindow
    case paymentMethod
  }
}

extension CreateBoost: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Boost.schema)
      .id()
      .field(.string(Fields.date.rawValue), .date)
      .field(.string(Fields.deliveryWindow.rawValue), .string)
      .field(.string(Fields.paymentMethod.rawValue), .string)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database
      .schema(Boost.schema)
      .delete()
  }
}
