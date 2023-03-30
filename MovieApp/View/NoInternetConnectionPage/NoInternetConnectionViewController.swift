//
//  NoInternetConnectionViewController.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 2.03.2023.
//

import UIKit
import Alamofire

class NoInternetConnectionViewController: UIViewController {
    
    @IBOutlet weak var tryAgainActivityIndicator: UIActivityIndicatorView!
    @IBAction func tryAgain(_ sender: Any) {
        tryAgainActivityIndicator.startAnimating();
        self.tryAgainActivityIndicator.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tryAgainActivityIndicator.isHidden = true
        }
        
        
        if(ConnectivityControl.isConnectedToInternet == true){
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.tryAgainActivityIndicator.isHidden = true
    }
}

public struct ConnectivityControl {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
