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
    
    router.get("api", "habitlogs", HabitLog.parameter) { req -> Future<HabitLog> in
        return try req.parameters.next(HabitLog.self)
    }
    
    router.put("api", "habitlogs", HabitLog.parameter) { req -> Future<HabitLog> in
        return try flatMap(to: HabitLog.self,
                           req.parameters.next(HabitLog.self),
                           req.content.decode(HabitLog.self)) { habitLog, updatedHabitLog in
            habitLog.date = updatedHabitLog.date
            habitLog.done = updatedHabitLog.done
            return habitLog.save(on: req)
        }
    }
    
    router.delete("api", "habitlogs", HabitLog.parameter) { req -> Future<HTTPStatus> in
        return try req.parameters.next(HabitLog.self)
            .delete(on: req)
            .transform(to: HTTPStatus.noContent)
    }
    
}
