//
//  SplashViewController.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/14/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(SplashViewController.showmainmenu), with: nil, afterDelay: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func showmainmenu(){
        
        performSegue(withIdentifier: "showmain", sender: self)
        
    }

}
