//
//  File.swift
//  
//
//  Created by nasrin niazi on 2023-02-25.
//

import Foundation
import UIKit
import Alamofire
//import Theme


public class NetworkReachability {
    public static let shared = NetworkReachability()
    let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    let offlineAlertController: UIAlertController = {
        UIAlertController(title: "No Network", message: "Please connect to network and try again", preferredStyle: .alert )
    }()
    
    public  func startNetworkMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.showOfflineAlert()
            case .reachable(.cellular):
                self.dismissOfflineAlert()
            case .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
                print("Unknown network state")
            }
        }
    }
    
    public  func showOfflineAlert() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {return}
//             MessageDisplay.displaySimpleMessage(titleStr: "No Network", txtMessage: "Please connect to network and try again", owner: rootViewController)
        offlineAlertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        rootViewController.present(offlineAlertController, animated: true, completion: nil)
    }
    
    public  func dismissOfflineAlert() {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
