import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.post("api", "habitlogs") { req -> Future<HabitLog> in
    return try req.content.decode(HabitLog.self)
        .flatMap(to: HabitLog.self) { habitLog in
            return habitLog.save(on: req)
        }
    }

    router.get("api", "habitlogs") { req -> Future<[HabitLog]> in
        return HabitLog.query(on: req).all()
    }

}
