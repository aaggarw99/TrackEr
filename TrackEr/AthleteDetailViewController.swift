//
//  AthleteDetailViewController.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/9/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit
import MessageUI

class AthleteDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var bioTextField: UITextView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    var sentName : String = ""
    var sentGrade : Int = 0
    var sentBio : String = ""
    var sentPhone : Int = 0
    var sentId : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        // sets the labels corresponding to the sent information and capitlizes them if need be
        nameLabel.text = sentName
        schoolLabel.text = (UserDefaults.standard.value(forKey: "school_name") as! String?)?.capitalized
        gradeLabel.text = String(sentGrade)
        bioTextField.text = sentBio
        phoneLabel.text = "#: \(sentPhone)"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // creates the right navigation button with the new-message button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"new-message.png"), style: .plain, target: self, action: #selector(AthleteDetailViewController.sendtext))
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // sends a text to the corresponding athlete
    func sendtext() {
        print("Tapped the Send Text button")
        // initializes MFMessageComposeViewController
        let messageVC = MFMessageComposeViewController()
        // sets the body of the text
        messageVC.body = "Hello!";
        // sets recipients
        messageVC.recipients = [String(sentPhone)]
        // delegate requirements
        messageVC.messageComposeDelegate = self;
        // checks to see if the device can send a text
        if MFMessageComposeViewController.canSendText() {
            present(messageVC, animated: false, completion: nil)
        }
    }
    // required method from Delegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // looks at all the results
        switch (result) {
        case MessageComposeResult.cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed:
            print("Message failed to send")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
