//
//  NewAthleteFormViewController.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/9/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit

class NewAthleteFormViewController: UIViewController, UITextFieldDelegate {

    
    let ATH_KEY = "athletes_array"

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBOutlet weak var gradeTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.autocorrectionType = .no
        self.nameTextField.delegate = self
        self.bioTextField.delegate = self
        self.gradeTextField.delegate = self
        self.phoneTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewAthleteFormViewController.dismissKeyboard)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard(){ /*this is a void function*/
        nameTextField.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        bioTextField.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        gradeTextField.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        phoneTextField.resignFirstResponder() /*This will dismiss our keyboard on tap*/
    }
    
    @IBAction func submit(_ sender: Any) {
        print("Pressed Submit")
        let defaults = UserDefaults.standard
        var tempAthletes = [Athlete]()
        let newName : String? = nameTextField.text
        var newBio : String? = bioTextField.text
        let newGrade : Int? = Int(gradeTextField.text!)
        var newPhone : Int? = Int(phoneTextField.text!)
        var new_id = 0
        // let name and grade be mandatory for now
        if nameTextField.text != "" && gradeTextField.text != "" {
            if (newBio == nil) {
                newBio = ""
            }
            if newPhone == nil {
                newPhone = 0
            }
            if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
                if myAthletes != [] {
                    new_id = (myAthletes.last?.id)! + 1
                    tempAthletes = myAthletes
                }
            }
            let newAthlete = Athlete(name : newName!, grade : newGrade!, id : new_id, phone : newPhone!, bio : newBio!)
            if tempAthletes.count == 0 {
                tempAthletes = [newAthlete]
                // assigns athlete value initially since count = 0
                let encoded = NSKeyedArchiver.archivedData(withRootObject: tempAthletes)
                defaults.set(encoded, forKey: ATH_KEY)
            }else {
                tempAthletes.append(newAthlete)
                // reassigns athletes value
                defaults.removeObject(forKey: ATH_KEY)
                let encoded = NSKeyedArchiver.archivedData(withRootObject: tempAthletes)
                defaults.set(encoded, forKey: ATH_KEY)

            }
            // dismisses view
            dismiss(animated: true, completion: nil)
            // let description and phone number be optional
        }else {
            sendAlert(error: "Please fill in the required fields!")
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // sends an alert with an appropriate error message
    func sendAlert(error : String) {
        print("Alert Sent")
        // creates alert controller with a title, message, and style
        let alertController = UIAlertController(title: "Error!", message:
            error, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        // required to show the alert
        self.present(alertController, animated: true, completion: nil)
    }
}
