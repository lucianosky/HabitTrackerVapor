import Vapor
import Fluent

struct HabitLogsController: RouteCollection {
    
    func boot(router: Router) throws {
        let habitLogsRoutes = router.grouped("api", "habitlogs")
        habitLogsRoutes.get(use: getAllHandler)
        habitLogsRoutes.post(HabitLog.self, use: createHandler)
        habitLogsRoutes.get(HabitLog.parameter, use: getHandler)
        habitLogsRoutes.put(HabitLog.parameter, use: updateHandler)
        habitLogsRoutes.delete(HabitLog.parameter, use: deleteHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[HabitLog]> {
        return HabitLog.query(on: req).all()
    }

    func createHandler(_ req: Request, habitLog: HabitLog) throws -> Future<HabitLog> {
        return habitLog.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<HabitLog> {
        return try req.parameters.next(HabitLog.self)
    }
    
    func updateHandler(_ req: Request) throws -> Future<HabitLog> {
        return try flatMap(to: HabitLog.self,
                           req.parameters.next(HabitLog.self),
                           req.content.decode(HabitLog.self)) { habitLog, updatedHabitLog in
            habitLog.date = updatedHabitLog.date
            habitLog.done = updatedHabitLog.done
            return habitLog.save(on: req)
        }
    }
    
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(HabitLog.self).delete(on: req).transform(to: HTTPStatus.noContent)
    }

}
