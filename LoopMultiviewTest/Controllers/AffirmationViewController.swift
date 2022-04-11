//
//  AffirmationViewController.swift
//  LoopMultiviewTest
//
//  Created by Joey Rubin on 3/12/22.
//

import UIKit
import AudioToolbox

class AffirmationViewController: UIViewController {

    
    @IBOutlet weak var affirmationLabel1: UILabel!
    @IBOutlet weak var affirmationLabel2: UILabel!
    @IBOutlet weak var selectedButton1: UIButton!
    @IBOutlet weak var selectedButton2: UIButton!
    @IBOutlet weak var selectedButton3: UIButton!
    @IBOutlet weak var genreSelectedLabelAVC: UILabel!
    @IBOutlet weak var affirmationOneView: UIView!
    @IBOutlet weak var affirmationTwoView: UIView!
    
    @IBOutlet weak var profileImageACV: UIImageView!
    var affirmationArray = [
        ["Love", "I am attracting romantic love.", "I am attracting true love."],
        ["Depression", "I am strong and grounded.", "My nervous system is healed."],
        ["Anxiety", "I am healed from anxiety.", "My subconscious fear patterns are healed."],
        ["Sickness", "I recieve Gods wholeness into my cells.", "I have wisdom to heal my body."],
        ["Addiction", "I am getting stronger everyday.", "I love myself enough to change."],
        ["Confidence,", "I am unstoppable.", "I will thrive in any situation."],
        ["Money", "I am a money magnet.", "I am totally debt free."],
        ["Weight Loss", "I am motivated to eat healthier.", "I am the master of this vessel."],
        ["Relationships", "Custom Affirmation.", "Custom Affirmation."],
        ["Self Doubt", "Custom Affirmation.", "Custom Affirmation."],
        ["Blank", "Custom Affirmation.", "Custom Affirmation."]
    ]
    
    var genreFromCV = ""
    var profileFromCV = "Marlin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (profileFromCV == "Michelle") {
            profileImageACV.image = UIImage(named: "prof3")
        } else if (profileFromCV == "Marlin"){
            profileImageACV.image = UIImage(named: "marlinPP")
        } else {
            profileImageACV.image = UIImage(named: "prof2")
        }
        genreSelectedLabelAVC.text = genreFromCV
        profileImageACV.roundImage()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "loopLogo2"))
        
        switch genreFromCV {
        case "Love":
            affirmationLabel1.text = affirmationArray[0][1]
            affirmationLabel2.text = affirmationArray[0][2]
        case "Depression":
            affirmationLabel1.text = affirmationArray[1][1]
            affirmationLabel2.text = affirmationArray[1][2]
        case "Anxiety":
            affirmationLabel1.text = affirmationArray[2][1]
            affirmationLabel2.text = affirmationArray[2][2]
        case "Sickness":
            affirmationLabel1.text = affirmationArray[3][1]
            affirmationLabel2.text = affirmationArray[3][2]
        case "Addiction":
            affirmationLabel1.text = affirmationArray[4][1]
            affirmationLabel2.text = affirmationArray[4][2]
        case "Confidence":
            affirmationLabel1.text = affirmationArray[5][1]
            affirmationLabel2.text = affirmationArray[5][2]
        case "Money":
            affirmationLabel1.text = affirmationArray[6][1]
            affirmationLabel2.text = affirmationArray[6][2]
        case "Weight Loss":
            affirmationLabel1.text = affirmationArray[7][1]
            affirmationLabel2.text = affirmationArray[7][2]
        case "Relationships":
            affirmationLabel1.text = affirmationArray[8][1]
            affirmationLabel2.text = affirmationArray[8][2]
        case "Self Doubt":
            affirmationLabel1.text = affirmationArray[9][1]
            affirmationLabel2.text = affirmationArray[9][2]
        case "Blank":
            affirmationLabel1.text = affirmationArray[10][1]
            affirmationLabel2.text = affirmationArray[10][2]
        default:
            print("Fuck shit")
        }
        
        affirmationOneView.layer.cornerRadius =  15
        affirmationOneView.layer.borderWidth = 2
        affirmationOneView.layer.borderColor = UIColor(red: 0.271, green: 0.690, blue: 0.898, alpha: 1.0).cgColor
        
        affirmationTwoView.layer.cornerRadius =  15
        affirmationTwoView.layer.borderWidth = 2
        affirmationTwoView.layer.borderColor = UIColor(red: 0.271, green: 0.690, blue: 0.898, alpha: 1.0).cgColor
        // Do any additional setup after loading the view.
    }//viewDidLoad END
    
 
    @IBAction func selectedButtonPressed(_ sender: UIButton) {
        let systemID3: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemID3)
//        let systemSoundID: SystemSoundID = 1054
//        AudioServicesPlaySystemSound(systemSoundID)
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRecordVC" {
            let destinationCV = segue.destination as! RecordViewController
            destinationCV.genreNow = genreFromCV
            destinationCV.profileSelectedRV = profileFromCV
//            destinationCV.updateUI()
        }
    }

}

