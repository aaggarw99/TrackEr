//
//  Athletes.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/6/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit
import AddressBook

class AthletesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // key for athletes array in NSKeyedArchiver
    var ATH_KEY = "athletes_array"

    let defaults = UserDefaults.standard
    // contains all the athletes
    var athletes = [Athlete]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        // get the names of all athletes
        if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
            athletes = myAthletes
        }
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        table.reloadData()
        // navigation styles
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.barTintColor =  .red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns length of athletes array
        return athletes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AthleteTableViewCell
        // fills each cell value
        cell.name.text = (athletes[indexPath.row].name).capitalized
        cell.grade.text = String(athletes[indexPath.row].grade)
        cell.runnerImageView.image = UIImage(named: "runner.png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // makes the table editable
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            // removes corresponding item in the array_of_links
            athletes.remove(at: indexPath.row)
            var tempAthletes : [Athlete] = []
            // process of retrieving stored values
            if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
                tempAthletes = myAthletes
            }
            // removing the corresponding index
            tempAthletes.remove(at: indexPath.row)
            // refreshes the userdefaults || repositions the array
            defaults.removeObject(forKey: ATH_KEY)
            // encodes data
            let encoded = NSKeyedArchiver.archivedData(withRootObject: tempAthletes)
            defaults.set(encoded, forKey: ATH_KEY)
            // physically removes table in view
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // associated with a cell press
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAthleteDetail",
            let destination = segue.destination as? AthleteDetailViewController,
            let detailIndex = table.indexPathForSelectedRow?.row
        {
            if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
                athletes = myAthletes
            }
            // sends destination values
            destination.sentName = self.athletes[detailIndex].name
            destination.sentId = self.athletes[detailIndex].id
            destination.sentBio = self.athletes[detailIndex].bio
            destination.sentPhone = self.athletes[detailIndex].phone
            destination.sentGrade = self.athletes[detailIndex].grade
        }
    }


}

