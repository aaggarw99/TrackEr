//
//  InfoViewController.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/13/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    // retrieves app version from pList
    let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "v\(appVersionString)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
