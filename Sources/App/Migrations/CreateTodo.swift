import Fluent
import Network

struct CreateTodo {
  private enum Fields: String {
    case title
  }
  
  private let databaseName = "todos"
}

extension CreateTodo: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(databaseName)
      .id()
      .field(.string(Fields.title.rawValue), .string, .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(databaseName).delete()
  }
}
