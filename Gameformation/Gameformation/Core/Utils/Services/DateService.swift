import Foundation

class DateService {
    
    static func addDaysToDate(days: Int, date: Date) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = days
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: date)
        return futureDate!
    }
}
