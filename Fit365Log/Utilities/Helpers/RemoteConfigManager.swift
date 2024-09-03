import Foundation
import FirebaseRemoteConfig

class RemoteConfigManager: ObservableObject {
    @Published var privacyPolicyURL: URL?
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    init() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        remoteConfig.setDefaults(["policy_url": "" as NSObject])
        
        fetchRemoteConfig()
    }
    
    func fetchRemoteConfig() {
        remoteConfig.fetchAndActivate { [weak self] status, error in
            if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                let urlString = self?.remoteConfig.configValue(forKey: "policy_url").stringValue ?? ""
                if let url = URL(string: urlString) {
                    self?.privacyPolicyURL = url
                } else {
                    print("Invalid URL")
                }
            } else {
                print("Error fetching remote config: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
}
