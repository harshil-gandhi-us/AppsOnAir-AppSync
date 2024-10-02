import Foundation
import UIKit
import AVFoundation
import AppsOnAir_Core


public class AppSyncService : NSObject {
    
    //MARK: - Declarations
    private var window: UIWindow?
    
    /// help to provide AppId from AppsOnAir-core SDK and use for Force-Update
    private var appId: String = ""
    
    /// provide flags for internet connectivity
    private var isNetworkConnected: Bool? = nil
    
    /// once force Update verify this flag set to true
    private var isCheckFetchUpdate:Bool = false
    
    /// help to set the native UI
    private var showNativeUI: Bool?
    
    /// help to initialize core service class
    let appsOnAirCoreServices = AppsOnAirCoreServices()
    
    /// display message while forgot to set showNativeUI in project
    private var errorMessage:String = "AppsOnAir showNativeUI is Not initialized for more details: \n https://documentation.appsonair.com" // !!!: Developer Guideline URL
    
    //MARK: - Methods
    
    /// network status change handler
    private func networkStateChange(_ completion: @escaping (NSDictionary) -> () = { _ in }) {
       
        appsOnAirCoreServices.networkStatusListenerHandler { isConnected in
            //check force-update is not verify and network is connected
            if ((!(self.isCheckFetchUpdate)) && isConnected) {
                //for Force Update Alert
                AppSyncApiService.cdnRequest(self.appId) { cdnData in
                    
                    var appUpdateInfo: NSDictionary = NSDictionary()
                    // set CDN data
                    appUpdateInfo = cdnData
                    // check get app data from API if CDN data is empty or getting error
                    if(appUpdateInfo.count == 0 || appUpdateInfo["error"] != nil) {
                        AppSyncApiService.fetchAppUpdate(self.appId) { (appUpdateData) in
                            appUpdateInfo = appUpdateData
                            self.handleAlert(completion: completion, appUpdateInfo: appUpdateInfo)
                        }
                    } else {
                        self.handleAlert(completion: completion, appUpdateInfo: appUpdateInfo)
                    }
                }
            }
        }
    }
    
    ///handle the  alert 
    private func handleAlert(completion: @escaping (NSDictionary) -> () = { _ in },appUpdateInfo: NSDictionary) {
        //(appUpdateInfo.count > 0 || appUpdateInfo["error"] != nil) is for check force update data is not
        if((appUpdateInfo.count > 0 || appUpdateInfo["error"] != nil)){
            // (self.showNativeUI ?? false) is for check nativeUi
            if (self.showNativeUI ?? false) {
                // Force update alert for native UI
                self.presentAppUpdate(appUpdateInfo: appUpdateInfo)
            }
            // Pass App Update data to the user for custom UI handling
            completion(appUpdateInfo)
            //set flag is true for force-update is verified
            self.isCheckFetchUpdate = true
        }
       
    }
    
    /// help to sync and network status change handler when NativeUi set to false. by default showNativeUI value is true
    @objc public func sync(directory: NSDictionary = ["showNativeUI": true],completion: @escaping (NSDictionary) -> () = { _ in }) {
        // To initialize the network services delegate and set AppId from AppsOnAir-core SDK and set Native UI
        appsOnAirCoreServices.initialize()
        self.appId = appsOnAirCoreServices.appId
        self.showNativeUI = directory["showNativeUI"] as? Bool
        // display message while forgot to set showNativeUI in project
        if self.appId != "" {
            // Method to set the network status change handler when NativeUi set to false
            networkStateChange { appUpdateData in
                completion(appUpdateData)
            }
        }
    }
    
    ///help to present App Update Alert
    func presentAppUpdate(appUpdateInfo: NSDictionary) {
        if (appUpdateInfo.count > 0) {
            DispatchQueue.main.sync {
                let bundle = Bundle(for: type(of: self))
                let storyboard = UIStoryboard(name: "AppUpdate", bundle: bundle)
                let modalVc = storyboard.instantiateViewController(withIdentifier: "MaintenanceViewController") as! MaintenanceViewController
                modalVc.updateDataDictionary = appUpdateInfo
                
                if let topController = UIApplication.topMostViewController(), !(topController is MaintenanceViewController) {
                    let navController = UINavigationController(rootViewController: modalVc)
                    navController.modalPresentationStyle = .overCurrentContext
                    let topController = UIApplication.topMostViewController()
                    topController?.present(navController, animated: true) {
                        // This code snippet is for fixing one UI accessability related bug for our other cross platform plugin
                        NotificationCenter.default.post(name: NSNotification.Name("visibilityChanges"), object: nil, userInfo: ["isPresented": true])
                    }
                }
            }
        }
    
    }
}
