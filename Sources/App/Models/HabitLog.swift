import Vapor
import FluentSQLite

final class HabitLog: Codable {
    var id: Int?
    var date: String
    var done: Bool
    
    init(date: String, done: Bool) {
        self.date = date
        self.done = done
    }
}

extension HabitLog: SQLiteModel {}

extension HabitLog: Migration {}

extension HabitLog: Content {}

extension HabitLog: Parameter {}

