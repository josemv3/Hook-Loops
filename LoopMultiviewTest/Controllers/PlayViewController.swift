//
//  PlayViewController.swift
//  LoopMultiviewTest
//
//  Created by Joey Rubin on 2/8/22.
//

import UIKit
import AVFoundation
import CoreData

class PlayViewController: UIViewController,AVAudioPlayerDelegate,AVAudioRecorderDelegate {
    
    @IBOutlet weak var bGImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var playButtonPV: UIButton!
    @IBOutlet weak var recordingSelectedButton: UIButton!
    @IBOutlet weak var genreSongSelectedButton: UIButton!
    @IBOutlet weak var genreLabelPV: UILabel!
    
    var savedFileName = "Start"
    var songSelected = ""
    var genreSelected = ""
    var songArray = ["Heart Shakra", "Song 2", "Song 3"]
    var profileSelectedPV = "Michelle"
    
    //MARK: - Audio Var
    
    var soundURL: String!
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    var audioPlayer2: AVAudioPlayer?
    
    var musicPlayer: AVAudioPlayer!
    var musicPlayer2:AVAudioPlayer!
    
    var timer = Timer()
    var timer2 = Timer()
    var totalTime = 0.0
    var timePassed = 0.0
    var songRepeats = 5 //Dont need?
    
    var timesPlayed = 0
    var timesChecked = 0
    
    var recordingDuration = 0.0
    var soundTimePassed = 0.0
    var loopPlayed = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (profileSelectedPV == "Michelle") {
            profileImage.image = UIImage(named: "prof3")
        } else if (profileSelectedPV == "Marlin"){
            profileImage.image = UIImage(named: "prof1")
        } else {
            profileImage.image = UIImage(named: "prof2")
        }
        
        profileImage.layer.cornerRadius =  15
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor(red: 0.847, green: 0.824, blue: 0.796, alpha: 1.0).cgColor
        
        genreLabelPV.text = genreSelected
        recordingSelectedButton.setTitle(savedFileName, for: .normal)
        genreSongSelectedButton.setTitle(genreSelected, for: .normal)
        
 
        print(soundURL!)
        
    
    } //END viewDidLoad
   
    
    @IBAction func recordingSelectedBtnPressed(_ sender: UIButton) {
        let optionClosure = {(action: UIAction) in
            self.savedFileName = action.title
            print(self.savedFileName)
            
    }

        recordingSelectedButton.menu = UIMenu(children: [
        UIAction(title: "Empty", image: UIImage(systemName: "record.circle"),state: .off, handler: optionClosure),
        UIAction(title: "Empty", image: UIImage(systemName: "record.circle"),state: .off, handler: optionClosure),
        UIAction(title: savedFileName, image: UIImage(systemName: "record.circle"),state: .on , handler: optionClosure)
        ])
    
        recordingSelectedButton.showsMenuAsPrimaryAction = true
        recordingSelectedButton.changesSelectionAsPrimaryAction = true
        
    }
    
    @IBAction func genreSongBtnPressed(_ sender: UIButton) {
        let optionClosure = {(action: UIAction) in
            self.savedFileName = action.title
            print(self.savedFileName)
           
            
    }

        genreSongSelectedButton.menu = UIMenu(children: [
        UIAction(title: "Empty", image: UIImage(systemName: "play.circle"),state: .off, handler: optionClosure),
        UIAction(title: "Empty", image: UIImage(systemName: "play.circle"),state: .off, handler: optionClosure),
        UIAction(title: songArray[0], image: UIImage(systemName: "play.circle"),state: .on , handler: optionClosure)
        ])
    
        genreSongSelectedButton.showsMenuAsPrimaryAction = true
        genreSongSelectedButton.changesSelectionAsPrimaryAction = true
        
    }
   
    
    
    
    
    //MARK: - Audio Brain
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButtonPV.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        recordButton.isEnabled = true
        playButtonPV.setTitle("Play", for: .normal)
    }
  
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        musicPlayer = try! AVAudioPlayer(contentsOf: url!)
        musicPlayer.play()
    }
    
    func playSound2 (soundName: String){
        let url = Bundle.main.url(forAuxiliaryExecutable: soundURL)
        musicPlayer2 = try! AVAudioPlayer(contentsOf: url!)
        musicPlayer2.play()
    }
    
    @IBAction func playPressedPV(_ sender: UIButton) {
//        if let player = audioPlayer {
//            if player.isPlaying {
//                player.stop()
//                playButtonPV.setTitle("Play", for: .normal)
//                playButtonPV.isSelected = false
//            }
//        }
        
        
        if playButtonPV.titleLabel?.text == "Play" {
            playButtonPV.setTitle("Stop", for: .normal)
//            recordButton.isEnabled = false
            musicPlayer2.play()
            //(New)
//            if let recorder = audioRecorder {
//                      if !recorder.isRecording {
//                          audioPlayer = try? AVAudioPlayer(contentsOf: recorder.url)
//                          audioPlayer?.delegate = self
//                          audioPlayer?.play()
//                          audioPlayer?.volume = 0.1
//
//                          recordingDuration = audioPlayer?.duration ?? 0.0
//                          print("recordingDuration\(recordingDuration)")
//
//                          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                              self.audioPlayer?.setVolume(1.0, fadeDuration: 0.5)
//                          }
//                          DispatchQueue.main.asyncAfter(deadline: .now() + recordingDuration - 0.2) {
//                              self.audioPlayer?.setVolume(0.0, fadeDuration: 0.2)
//                          }
//                      }// if !recorder.isRecording END
//            }//if let recorder END
            
        } else {
       
            // Stop the audio player if playing
            if let player = audioPlayer {
                if player.isPlaying {
                    player.stop()
                }
            }
            playButtonPV.setTitle("Play", for: .normal)
//            recordButton.isEnabled = true
        }
    
    
} //End playPressed
            
            
  
    
    

} //END of main class

fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
return input.rawValue
}

// Helper function inserted by Swift migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    
    
}
