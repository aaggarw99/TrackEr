//
//  StopwatchViewController.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/6/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isRunning : Bool = false
    
    
    let LAPS_KEY = "laps_array"
    let CURRENT_SW_KEY = "current_stop_watch"
    
    // duel functioning button
    @IBOutlet weak var startstopbutton: UIButton!
    
    // duel functioning button
    @IBOutlet weak var lapreset: UIButton!
    
    var laps : [String] = []
    
    var stopwatchstring : String = ""
    
    var startStopWatch: Bool = true
    
    var timer = Timer()
    var minutes = 0
    var seconds = 0
    var fraction = 0
    
    var addLap = false
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        stopwatchstring = "00:00:00"
        timeLabel.text = stopwatchstring
        table.reloadData()
        // makes laps global
        UserDefaults.standard.setValue(laps, forKey: LAPS_KEY)
        UserDefaults.standard.setValue(stopwatchstring, forKey: CURRENT_SW_KEY)
        // makes the buttons circular
        startstopbutton.layer.cornerRadius = min(100, 100) / 2.0
        lapreset.layer.cornerRadius = min(100, 100) / 2.0
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // gets lenght of laps array
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapcell") as! LapTableViewCell
        cell.lapnumber.text = String(laps.count - indexPath.row)
        cell.duration.text = laps[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func startstop(_ sender: Any) {
        print("Start/Stop")
        // if the button is "Start"
        if startStopWatch == true {
            if isRunning == false {
                isRunning = true
                // starts timer
                timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(StopwatchViewController.updateTime), userInfo: nil, repeats: true)
                // adjusts property
                startStopWatch = false
                // renames button
                startstopbutton.setTitle("Stop", for: .normal)
                // changes Lap button
                lapreset.setTitle("Lap", for: .normal)
                // alters addLap property
                addLap = true

            }
        }else { // if the button is "Stop"
            if isRunning == true {
                isRunning = false
                // stops timer
                timer.invalidate()
                // adjusts property
                startStopWatch = true
                // changes to "Start"
                startstopbutton.setTitle("Start", for: .normal)
                // changes to "reset"
                lapreset.setTitle("Reset", for: .normal)
                addLap = false
            }
        }
    }
    
    // manages the reset/lap button
    @IBAction func lapreset(_ sender: Any) {
        print("Lap/Reset")
        if addLap == true {
            // appends the laps[] array, then reloads
            laps.insert(stopwatchstring, at: 0)
            UserDefaults.standard.setValue(laps, forKey: LAPS_KEY)
            table.reloadData()
        }else {
            // resets all data
            addLap = false
            lapreset.setTitle("Lap", for: .normal)
            fraction = 0
            seconds = 0
            minutes = 0
            stopwatchstring = "00:00:00"
            laps.removeAll()
            table.reloadData()
            timeLabel.text = stopwatchstring
            
        }
    }
    
    // used for the timer. Called very millisecond.
    func updateTime() {
        // adds 1 to fraction
        fraction += 1
        // checks if we've reached 100 fractions
        if fraction == 100 {
            // add one to seconds
            seconds += 1
            // put fraction back at 0
            fraction = 0
        }
        // checks if seconds are 60
        if seconds == 60 {
            // adds 1 to minutes
            minutes += 1
            // resets seconds
            seconds = 0
        }
        
        // forms corresponding strings for each value
        let fractionsString = fraction > 9 ? "\(fraction)" : "0\(fraction)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        // concatenates
        let totalString = "\(minutesString):\(secondsString):\(fractionsString)"
        stopwatchstring = totalString
        // displays
        timeLabel.text = stopwatchstring
        UserDefaults.standard.setValue(stopwatchstring, forKey: CURRENT_SW_KEY)
    }

}
