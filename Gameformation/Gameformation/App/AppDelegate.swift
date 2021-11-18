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
            
            let myBackground = "Saya adalah mahasiswa Universitas Bina Nusantara yang mengambil jurusan Teknik Informatika."
            let myPurpose = "Memiliki tujuan untuk menjadi seorang iOS Developer yang handal."
            let myPassion = "Saya memiliki passion untuk mengembangkan aplikasi karena"
            let myReason = "dapat menghasilkan sebuah produk yang bisa memberikan manfaat bagi banyak orang."
            
            UserDefaults.standard.setValue("Luis Genesius", forKey: "profileName")
            UserDefaults.standard.setValue("Singkawang, Kalimantan Barat", forKey: "profileOrigin")
            UserDefaults.standard.setValue(myBackground + " " + myPurpose + " " + myPassion + " " + myReason, forKey: "profileDescription")
            UserDefaults.standard.setValue(true, forKey: preloadKey)
        }
    }
}
