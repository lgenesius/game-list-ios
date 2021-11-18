import SwiftUI

@main
struct GameformationApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                    NotificationService.shared.removeAllScheduledNotifications()
                    NotificationService.shared.scheduleActiveNotification()
                })
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
                    NotificationService.shared.removeAllScheduledNotifications()
                })
                .environment(\.colorScheme, .dark)
        }
    }
}
