//
//  Home.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/6/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    // these are two stored values with the coaches name and school name
    let coach_name = UserDefaults.standard.value(forKey: "coach_name")
    let school_name = UserDefaults.standard.value(forKey: "school_name")
    
    @IBOutlet weak var school_name_label: UILabel!
    
    @IBOutlet weak var coach_name_label: UILabel!
    
    @IBOutlet weak var running_image_view: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let weather = WeatherRetriever()
        weather.getWeather(city: "Chicago")

        running_image_view.image = #imageLiteral(resourceName: "runningman.gif")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // if this is true, then don't popup view
        if let _ = UserDefaults.standard.value(forKey: "fla") {
        }else {
            // manages the onboarding screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ob")
            UserDefaults.standard.setValue("hasLaunched", forKey: "fla")
            self.present(controller, animated: true, completion: nil)
        }
        // displays the school and coach name values capitalized
        school_name_label.text = (school_name as! String?)?.capitalized
        coach_name_label.text = (coach_name as! String?)?.capitalized
    }


}

