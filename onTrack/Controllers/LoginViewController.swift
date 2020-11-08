//
//  LoginViewController.swift
//  onTrack
//
//  Created by Elena Sadler on 11/8/20.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let loginEmail = loginEmailField.text
        let loginPasword = loginPasswordField.text
        
        if let unwrappedEmail = loginEmail, let unwrappedPassword = loginPasword {
            performSegue(withIdentifier: "userLoginAttempt", sender: self)
        } else {
            print("Error with username or password.")
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "userLoginAttempt" {
            let destinationVC = segue.destination as! LoggedInViewController
            destinationVC.emailAttempt = loginEmailField.text
            destinationVC.passwordAttempt = loginPasswordField.text
            destinationVC.signUp = false
        }
    }
    
}
