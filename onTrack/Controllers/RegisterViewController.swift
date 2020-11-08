//
//  RegisterViewController.swift
//  onTrack
//
//  Created by Elena Sadler on 11/8/20.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerEmailField: UITextField!
    
    @IBOutlet weak var registerPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let registerEmail = registerEmailField.text
        let registerPassword = registerPasswordField.text
        
        if let unwrappedEmail = registerEmail, let unwrappedPassword = registerPassword {
            self.performSegue(withIdentifier: "userRegisterAttempt", sender: self)
        } else {
            print("Error with username or password.")
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "userRegisterAttempt" {
            let destinationVC = segue.destination as! LoggedInViewController
            destinationVC.emailAttempt = registerEmailField.text
            destinationVC.passwordAttempt = registerPasswordField.text
            destinationVC.signUp = true
        }
    }

}
