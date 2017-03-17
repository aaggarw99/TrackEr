//
//  OnboardingViewController.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/11/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var schoolNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.schoolNameTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewAthleteFormViewController.dismissKeyboard)))
    }
    
    func dismissKeyboard(){ /*this is a void function*/
        nameTextField.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        schoolNameTextField.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func getstarted(_ sender: Any) {
        if nameTextField.text == "" || schoolNameTextField.text == "" {
            showAlert(error: "Please fill in all fields")
        }else {
            // store in defaults
            let defaults = UserDefaults.standard
            defaults.setValue(nameTextField.text, forKey: "coach_name")
            defaults.setValue(schoolNameTextField.text, forKey: "school_name")
            print("Get Started pressed")
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    // shows appropriate alert
    func showAlert(error : String) {
        // creates alert controller with a title, message, and style
        let alertController = UIAlertController(title: "Error!", message:
            error, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        // required to show the alert
        self.present(alertController, animated: true, completion: nil)
    }

}
