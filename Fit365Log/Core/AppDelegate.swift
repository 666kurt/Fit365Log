import AppMetricaCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if let configuration = AppMetricaConfiguration(apiKey: "23158605-d7c3-41b5-94cb-c54cf54211b5") {
            configuration.locationTracking = false
            AppMetrica.activate(with: configuration)
        }
        
        return true
    }
}
