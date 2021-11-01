import Fluent
import Vapor

func routes(_ app: Application) throws {  
  try app.register(collection: BoostController())
  try app.register(collection: FuelPricingController())
}
