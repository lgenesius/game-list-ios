import Foundation
import UserNotifications

enum NotificationStatus {
    case granted
    case notRequested
    case rejected
}

class NotificationService {
    static let shared = NotificationService()
    static let NOTIFACTIVEID = "notificationActiveIdentifier"
    
    private var notificationCenter: UNUserNotificationCenter
    
    init() {
        notificationCenter = UNUserNotificationCenter.current()
    }
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
        }
    }
    
    private func isAuthorized(completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                let authorized = settings.authorizationStatus == .authorized
                completion(authorized)
            }
        }
    }
    
    func removeAllScheduledNotifications() {
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func scheduleActiveNotification() {
        isAuthorized { [weak self] status in
            guard let self = self else { return }
            if status {
                
                let dayAfterTommorow = DateService.addDaysToDate(days: 2, date: Date())
                self.addNotification(date: dayAfterTommorow)
            }
        }
    }
    
    private func addNotification(date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Check Your Favorite Game"
        content.body = "Don't forget to check your new favorite game in Gameformation!"
        
        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
        let request = UNNotificationRequest(identifier: NotificationService.NOTIFACTIVEID, content: content, trigger: trigger)
        
        self.notificationCenter.add(request, withCompletionHandler: nil)
    }
}
