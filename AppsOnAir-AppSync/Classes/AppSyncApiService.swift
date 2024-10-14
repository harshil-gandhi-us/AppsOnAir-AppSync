import Foundation
import AppsOnAir_Core

struct AppSyncApiService {
    
    static func fetchAppUpdate(_ appID: String, completion: @escaping(NSDictionary) -> ()) {
        let session = URLSession(configuration: .default)
        // Server API URL from EnvironmentConfig
        let url = EnvironmentConfig.serverURL + appID
        let apiURL : URL = URL(string: url)!
        
        let apiTask = session.dataTask(with: apiURL) { data, response, error in
            do {
                Logger.logInternal("URL = \(url)")

                // make sure this JSON is in the format we expect
                // convert data to json
                if(data != nil) {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        // try to read out a dictionary
                        Logger.logInternal("server fetchAppUpdate Response: \(json)")
                        completion(json as NSDictionary)
                    }
                } else {
                    completion([:])
                }
            } catch let error as NSError {
                Logger.logInternal("Failed to load: \(error.localizedDescription)")
            }
        }
        apiTask.resume()
    }
    
    static func cdnRequest(_ appID: String, completion: @escaping(NSDictionary) -> ()) {
        let session = URLSession(configuration: .default)
        
        // CDN API URL from EnvironmentConfig
        let url = "\(EnvironmentConfig.cdnURL)\(appID).json?now=\(Date().timeIntervalSince1970)"
        let apiURL : URL = URL(string: url)!
        
        let apiTask = session.dataTask(with: apiURL) { data, response, error in
            do {
                Logger.logInternal("URL = \(url)")
                // make sure this JSON is in the format we expect
                // convert data to json
                if(data != nil) {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        // try to read out a dictionary
                        Logger.logInternal("CDN Response: \(json)")
                        completion(json as NSDictionary)
                    }
                } else {
                    completion([:])
                }
            } catch let error as NSError {
                Logger.logInternal("Failed to load: \(error.localizedDescription)")
                completion(["error":error.localizedDescription])
            }
        }
        apiTask.resume()
    }
}
