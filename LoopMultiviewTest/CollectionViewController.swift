//
//  CollectionViewController.swift
//  LoopMultiviewTest
//
//  Created by Joey Rubin on 2/8/22.
//

import UIKit
import AudioToolbox

class CollectionViewController: UIViewController {
    @IBOutlet weak var bGImage: UIImageView!
    @IBOutlet weak var profileButtonImage: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthImage: UIImageView!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthImage: UIImageView!
    @IBOutlet weak var fifthButton: UIButton!
    
    @IBOutlet weak var sixthImage: UIImageView!
    @IBOutlet weak var sixthButton: UIButton!
    @IBOutlet weak var seventhImage: UIImageView!
    @IBOutlet weak var seventhButton: UIButton!
    @IBOutlet weak var eighthImage: UIImageView!
    @IBOutlet weak var eighthButton: UIButton!
    @IBOutlet weak var ninethImage: UIImageView!
    @IBOutlet weak var ninethButton: UIButton!
    @IBOutlet weak var tenthImage: UIImageView!
    @IBOutlet weak var tenthButton: UIButton!
    
    var genreSelected = ""
    var profileSelectedCV = "Marlin"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (profileSelectedCV == "Michelle") {
            profileButtonImage.image = UIImage(named: "prof3")
        } else if (profileSelectedCV == "Marlin"){
            profileButtonImage.image = UIImage(named: "marlinPP")
        } else {
            profileButtonImage.image = UIImage(named: "prof2")
        }
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "loopLogo2"))
        
        profileButtonImage.roundImage()
        firstImage.roundImage()
        secondImage.roundImage()
        thirdImage.roundImage()
        fourthImage.roundImage()
        fifthImage.roundImage()
        sixthImage.roundImage()
        seventhImage.roundImage()
        eighthImage.roundImage()
        ninethImage.roundImage()
        tenthImage.roundImage()
        firstButton.setTitle("Love", for: .normal)
        secondButton.setTitle("Confidence", for: .normal)
        thirdButton.setTitle("Money", for: .normal)
        fourthButton.setTitle("Weight Loss", for: .normal)
        fifthButton.setTitle("Blank", for: .normal)
        sixthButton.setTitle("Anxiety", for: .normal)
        seventhButton.setTitle("Depression", for: .normal)
        eighthButton.setTitle("Sickness", for: .normal)
        ninethButton.setTitle("Addiction", for: .normal)
        tenthButton.setTitle("Blank", for: .normal)
            
    }//viewDidLoad END
    
    @IBAction func genreButtonPressed(_ sender: UIButton) {
        genreSelected = sender.currentTitle!
        switch genreSelected {
        case "Love":
            firstImage.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.firstImage.alpha = 1.0}
        case "Depression":
            seventhImage.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.seventhImage.alpha = 1.0}
        case "Anxiety":
            sixthImage.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.sixthImage.alpha = 1.0}
        case "Sickness":
            eighthImage.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.eighthImage.alpha = 1.0}
        case "Addiction":
            ninethImage.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.ninethImage.alpha = 1.0}
        case "Confidence":
            secondImage.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.secondImage.alpha = 1.0}
        case "Money":
                thirdImage.alpha = 0.5
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.thirdImage.alpha = 1.0}
        case "Weight Loss":
            fourthImage.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.fourthImage.alpha = 1.0}
        
        default:
            print("Error genreButton switch stmnt")
        }
        print(genreSelected)
        
        let systemSoundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRecordVC" {
            let destinationCV = segue.destination as! RecordViewController
            destinationCV.genreNow = genreSelected
            destinationCV.profileSelectedRV = profileSelectedCV
        } else if segue.identifier == "goToAffirmationVC"{
            let destinationACV = segue.destination as! AffirmationViewController
            destinationACV.genreFromCV = genreSelected
            destinationACV.profileFromCV = profileSelectedCV
            
        }
    }
    
   
}

extension UIImageView {
    func roundImage(){
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 0.271, green: 0.690, blue: 0.898, alpha: 1.0).cgColor
//        self.layer.borderColor = UIColor(red: 0.502, green: 0.424, blue: 0.616, alpha: 1.0).cgColor
    }
}
