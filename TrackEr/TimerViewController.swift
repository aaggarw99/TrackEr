//
//  TimerViewController.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/6/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController, UIApplicationDelegate {
    var seconds = 32
    var timer = Timer()
    // alert sound ID
    let systemSoundID: SystemSoundID = 1023
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var startbutton: UIButton!
    
    @IBOutlet weak var stopbutton: UIButton!
    
    // manages slider values in realtime
    @IBAction func slider(_ sender: UISlider) {
        print("Slider Moved")
        seconds = Int(sender.value)
        timeLeftLabel.text = "\(seconds) s"
    }
    
    // starts timer
    @IBAction func start(_ sender: Any) {
        print("Start button pressed")
        // will call counter() every second
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.counter), userInfo: nil, repeats: true)
    }
    
    // deducts 1 second from the seconds property every time it's called
    func counter() {
        seconds -= 1
        timeLeftLabel.text = "\(seconds) s"
        if seconds == 0 {
            // to play sound
            AudioServicesPlaySystemSound (systemSoundID)
            timer.invalidate()
        }
    }
    
    // stops timer
    @IBAction func stop(_ sender: Any) {
        print("Stopped")
        timer.invalidate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // makes the buttons circular
        startbutton.layer.cornerRadius = min(100, 100) / 2.0
        stopbutton.layer.cornerRadius = min(100, 100) / 2.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("terminated")
        timer.invalidate()
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("About to Enter Foreground")
    }
    
}
