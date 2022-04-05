//
//  ViewController.swift
//  LoopMultiviewTest
//
//  Created by Joey Rubin on 2/8/22.
//

import UIKit
import AudioToolbox

class profileViewController: UIViewController {
    
    @IBOutlet weak var backGImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileButtonImage: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileSelectorButton: UIButton!
//    var profileNames = ["Michelle", "Marlon", "Steph"]
    var profileChosen = "Marlin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpButton()
//        profileButtonImage.layer.cornerRadius =  0.5 * profileButtonImage.bounds.size.width
        profileButtonImage.layer.cornerRadius =  10
        profileButtonImage.layer.borderWidth = 4
        profileButtonImage.layer.borderColor = UIColor(red: 0.271, green: 0.690, blue: 0.898, alpha: 1.0).cgColor
        
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "loopLogo2"))
        
    }


    @IBAction func profileSelectorPressed(_ sender: UIButton) {
        
    }
    
     func setPopUpButton(){
    //        let showProfileNames = profileNames
    
        let optionClosure = {(action: UIAction) in
            self.profileChosen = action.title
            print(self.profileChosen)
            if (self.profileChosen == "Marlin") {
                self.backGImage.image = UIImage(named: "logoIndigo2")
                self.profileButtonImage.image = UIImage(named: "marlinPP")
            } else if (self.profileChosen == "Michelle"){
                self.backGImage.image = UIImage(named: "logoIndigo2")
                self.profileButtonImage.image = UIImage(named: "prof3")
            } else {
                self.backGImage.image = UIImage(named: "view")
                self.profileButtonImage.image = UIImage(named: "prof2")
            }
            
    }

        profileSelectorButton.menu = UIMenu(children: [
        UIAction(title: "Steph", image: UIImage(systemName: "person.crop.circle"),state: .off, handler: optionClosure),
        UIAction(title: "Michelle", image: UIImage(systemName: "person.crop.circle"),state: .off, handler: optionClosure),
        UIAction(title: "Marlin", image: UIImage(systemName: "person.crop.circle"),state: .on , handler: optionClosure)
        ])
    
        profileSelectorButton.showsMenuAsPrimaryAction = true
        profileSelectorButton.changesSelectionAsPrimaryAction = true
         
         
     }
    
    @IBAction func profileButtonPushed(_ sender: UIButton) {
        let systemSoundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemSoundID)
        profileButtonImage.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.profileButtonImage.alpha = 1.0
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCollectionPV" {
            let destinationCV = segue.destination as! CollectionViewController
            destinationCV.profileSelectedCV = profileChosen
        }
    }


}



//let user1 = UIAction(title: "Michelle", image: UIImage(systemName: "person.crop.circle")) { (action) in
//
//    print("Michelle Selected")
////            self.genreSongSelectedButton.setTitle(self.songArray[0], for: .normal)
//  }
//
//  let user2 = UIAction(title: "Marlon", image: UIImage(systemName: "person.crop.circle")) { (action) in
//
//      print("Marlon Selected")
////              self.genreSongSelectedButton.setTitle(self.songArray[1], for: .normal)
//  }
//
//  let user3 = UIAction(title: "Steph", image: UIImage(systemName: "person.crop.circle")) { (action) in
//      print("Steph Selected")
////              self.genreSongSelectedButton.setTitle(self.songArray[2], for: .normal)
//  }
//
//  let menu = UIMenu(title: "User Menu", options: .displayInline, children: [user3 , user2 , user1 ])
//
//profileSelectorButton.menu = menu
//profileSelectorButton.showsMenuAsPrimaryAction = true

