//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by english on 2024-04-03.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut() //Firebase signout
        } catch {
            print("Error")
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    
}
