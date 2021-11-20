import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        firstTimeLaunch()
        return true
    }
    
    private func firstTimeLaunch() {
        let preloadKey = "preloadData"
        if !UserDefaults.standard.bool(forKey: preloadKey) {
            NotificationService.shared.requestAuthorization()
        }
    }
}
