import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var appName : String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    var appIcons : String? {
        if let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryIcons = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
           let iconFiles = primaryIcons["CFBundleIconFiles"] as? [String],
           let lastIcon = iconFiles.last {
            return lastIcon
        }
        return nil
    }
}
