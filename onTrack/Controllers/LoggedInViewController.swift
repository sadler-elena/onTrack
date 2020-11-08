//
//  LoggedInViewController.swift
//  onTrack
//
//  Created by Elena Sadler on 11/8/20.
//

import UIKit
import Firebase
import FirebaseFirestore



class LoggedInViewController: UIViewController {
    var signUp = false
    var emailAttempt: String?
    var passwordAttempt: String?
    var userStructure: UserStateModel?
    var trackModel: TrackModel?
    let decoder = JSONDecoder()
    var timeInMinutes = 0
 
    
    //Views:
    
    
    @IBOutlet weak var homeView: UIView!
    
    @IBOutlet weak var timerView: UIView!
    
    @IBOutlet weak var tracksView: UIView!
    
    @IBOutlet weak var settingsView: UIView!
    
    
    //Labels
    
    @IBOutlet weak var taskLabel1: UILabel!
    @IBOutlet weak var taskLabel2: UILabel!
    @IBOutlet weak var taskLabel3: UILabel!
    
    @IBOutlet weak var timeLabel1: UILabel!
    @IBOutlet weak var timeLabel2: UILabel!
    @IBOutlet weak var timeLabel3: UILabel!
    
    //Timer outlets
    
    @IBOutlet weak var timerBarView: UIView!
    @IBOutlet weak var timerBarValueLabel: UILabel!
    @IBOutlet weak var timerProgressBar: UIProgressView!
    @IBOutlet weak var timerCompleteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
        userAuthentication(email: emailAttempt!, password: passwordAttempt!, signUp: signUp)
        let user = Auth.auth().currentUser
        if let user = user {
            let userUID = user.uid
            guard let userEmail = user.email else { return }
            userStructure = UserStateModel(uid: userUID, email: userEmail, userTrackArray: ["empty"])
            
        }
        if signUp == true {
            db.collection("Users").document(userStructure!.uid).setData((userStructure!.dictionary), merge: true)
        }
        if signUp == false {
            
        

            let docRef = db.collection("Users").document(userStructure!.uid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataTable = document.data()!["tasks"]

                    
                } else {
                    print("Document does not exist")
                }
            }


        }
        

        // Do any additional setup after loading the view.
    }
    //MARK: - Navigation Buttons
    
    @IBAction func startTimerButton(_ sender: UIButton) {
        timerBarView.isHidden = false
        timeTracker(timeInMinutes: timeInMinutes, itemName: timerBarValueLabel)

    }
    
    @IBAction func timeAmountSlider(_ sender: UISlider) {
        timerBarValueLabel.text =
            String(Int(sender.value.rounded())) + "mins"
        timeInMinutes = Int(sender.value.rounded())
    }
    
    @IBAction func timerSliderBar(_ sender: UISlider) {
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        oneViewSelected(selectedView: homeView)
    }
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
        oneViewSelected(selectedView: timerView)
    }
    
    @IBAction func trackButtonPressed(_ sender: UIButton) {
        oneViewSelected(selectedView: tracksView)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        oneViewSelected(selectedView: settingsView)
    }
    
    func userAuthentication(email: String?, password: String?, signUp: Bool ) {
        if (signUp == true) {
            Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
              // ...
            }
            
        }
        if (signUp == false) {
            Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              // ...
            }
        }
    }
    
    //For ensuring only one view open.
    //Four views. 0 - Home, 1 - Timer, 2 - Tracks, 3 - Settings
    func oneViewSelected(selectedView: UIView) {
        let viewArray = [homeView, timerView, tracksView, settingsView]
        for view in viewArray {
            if view!.tag == selectedView.tag {
                view!.isHidden = false
            } else {
                view!.isHidden = true
            }
        }

        
    }
    func timeTracker(timeInMinutes: Int, itemName: UILabel) {
        let timeInSeconds = timeInMinutes * 60
        var secondsRemaining = timeInSeconds
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if secondsRemaining > 0 {
                itemName.text = String(secondsRemaining) + " seconds"
                let secondsPassed = timeInSeconds - secondsRemaining
                let progressCompleted = Float(secondsPassed) / Float(timeInSeconds)
                print(progressCompleted)
                self.timerProgressBar.setProgress(progressCompleted, animated: true)
                secondsRemaining -= 1
            } else {
                Timer.invalidate()
                self.timerCompleteLabel.isHidden = false
            }
        }
    }
    
}
