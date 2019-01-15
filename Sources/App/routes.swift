import Vapor

public func routes(_ router: Router) throws {
    let habitLogsController = HabitLogsController()
    try router.register(collection: habitLogsController)
    
}
