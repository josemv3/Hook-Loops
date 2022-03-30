//
//  RecordViewController.swift
//  LoopMultiviewTest
//
//  Created by Joey Rubin on 2/8/22.
//

import UIKit
import AVFoundation
import CoreData

class RecordViewController: UIViewController,UITextFieldDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate {

    @IBOutlet weak var bGimage: UIImageView!
    @IBOutlet weak var fileNameText: UITextField!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var recordingSelectedButton: UIButton!
    @IBOutlet weak var songSelectedButton: UIButton!
    @IBOutlet weak var playButtonPV: UIButton!
    
    
    var recordingName = "Recording"
    var genreNow = ""
    var profileSelectedRV = "Marlin"
    
    var songArray = ["Heart Chakra", "Sacral Chakra", "Native Flute"]
    var songSelected = "Heart Chakra"
    
    //MARK: - Recording Variables
    
    var soundURL: String!
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?

    var musicPlayer: AVAudioPlayer?
    var timer = Timer()
    var timer2 = Timer()
    var totalTime = 0.0
    var timePassed = 0.0
    var songRepeats = 5
    
    var timesPlayed = 0
    var timesChecked = 0
    
    
    var recordingDuration = 0.0 
    var soundTimePassed = 0.0
    var loopPlayed = 0 //NOT USED
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "loopLogo1"))
        
//        if (profileSelectedRV == "Michelle") {
//            profileImage.image = UIImage(named: "prof3")
//        } else if (profileSelectedRV == "Marlin"){
//            profileImage.image = UIImage(named: "prof1")
//        } else {
//            profileImage.image = UIImage(named: "prof2")
//        }
   
        songSelectedPopup()
        recordingSelectedPopup()
        
        
        fileNameText.delegate = self
        
//        profileImage.roundImage()
        recordButton.layer.cornerRadius =  0.5 * recordButton.bounds.size.width
        playButton.layer.cornerRadius =  0.5 * playButton.bounds.size.width
        saveButton.layer.cornerRadius =  10
        playButtonPV.layer.cornerRadius =  0.5 * playButtonPV.bounds.size.width
        
        playButton.isEnabled = false
        saveButton.isEnabled = false
        playButtonPV.isEnabled = false
        recordingSelectedButton.isEnabled = false
        songSelectedButton.isEnabled = false
        
        
        
        //All NEW
        checkMicrophoneAccess()
              
        // Set the audio file
              let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
                  FileManager.SearchPathDomainMask.userDomainMask).first
              
              let audioFileName = UUID().uuidString + ".m4a"
              let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
              soundURL = audioFileName       // Sound URL to be stored in CoreData
              
              // Setup audio session
              let audioSession = AVAudioSession.sharedInstance()
              do {
                  try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
//HUGE = Gotta allow bluetooth and speaker default!
              } catch _ {
              }
        // Define the recorder setting
          let recorderSetting = [AVFormatIDKey: kAudioFormatAppleLossless,
                                AVSampleRateKey: 44100.0,
                                AVEncoderBitRateKey: 320000,
                                AVNumberOfChannelsKey: 2,
                                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue] as [String : Any]
            
            audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
        //END all new
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
                audioPlayer2?.stop()
                audioPlayer?.stop()
                timer.invalidate()
                musicPlayer?.stop()
                print("Stop!!!")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        updateUI()
//    }
//    func updateUI(){
//
//        audioPlayer2?.stop()
//        audioPlayer?.stop()
//        timer.invalidate()
//        musicPlayer?.stop()
//        print("Stop!!!")
//
//    }
    
    //MARK: - UITextFieldManager

    @IBAction func saveButtonPressed(_ sender: UIButton) {

        if fileNameText.text != "" {
            recordingName = fileNameText.text!
            print(recordingName)
//            recordingSelectedButton.setTitle(recordingName, for: .normal)
            recordingSelectedPopup()
            
//            self.performSegue(withIdentifier: "goToPlayVC", sender: self)
            fileNameText.endEditing(true)
            
        } else {
            fileNameText.placeholder = "Name Your Loop!"
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField.text != "" {
            recordingName = fileNameText.text!
            recordingSelectedButton.isEnabled = true
//            recordingSelectedButton.setTitle(recordingName, for: .normal)
            recordingSelectedPopup()
            songSelectedButton.isEnabled = true
            playButtonPV.isEnabled = true
//            songSelectedButton.setTitle("song", for: .normal)
            
            print(recordingName)
//            self.performSegue(withIdentifier: "goToPlayVC", sender: self)
            fileNameText.endEditing(true)
            return true
        } else {
            textField.placeholder = "Name Your Loop!"
            return false
        }
        
    }
     
    func textFieldDidEndEditing(_ textField: UITextField) {
        fileNameText.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Name Your Loop!"
            return false
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlayVC" {
            let destinationCV = segue.destination as! PlayViewController
            destinationCV.savedFileName = recordingName
            destinationCV.profileSelectedPV = profileSelectedRV
            destinationCV.genreSelected = genreNow
            destinationCV.soundURL = soundURL //savd file but didnt play
            print(soundURL!)
            destinationCV.recordingDuration = recordingDuration
            
        }
    
    }
    

    //MARK: - PopUp Buttons
    
    @IBAction func recordingSelectedPressed(_ sender: UIButton) {
        
    }
    
    func recordingSelectedPopup()  {
        let optionClosure = {(action: UIAction) in
            self.recordingName = action.title
            print(self.recordingName)
            
    }

        recordingSelectedButton.menu = UIMenu(children: [
        UIAction(title: "Empty", image: UIImage(systemName: "record.circle"),state: .off, handler: optionClosure),
        UIAction(title: "Empty", image: UIImage(systemName: "record.circle"),state: .off, handler: optionClosure),
        UIAction(title: recordingName, image: UIImage(systemName: "record.circle"),state: .on , handler: optionClosure)
        ])
    
        recordingSelectedButton.showsMenuAsPrimaryAction = true
        recordingSelectedButton.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func songSelectedPressed(_ sender: UIButton) {
    }
    
    func songSelectedPopup(){
    let songArrayInside = songArray
    let optionClosure = {(action: UIAction) in
//            self.recordingName = action.title
//            print(self.recordingName)
        print(action.title)
        self.songSelected = action.title
    }

    songSelectedButton.menu = UIMenu(children: [
    UIAction(title: songArrayInside[2], image: UIImage(systemName: "play.circle"),state: .off, handler: optionClosure),
    UIAction(title: songArrayInside[1], image: UIImage(systemName: "play.circle"),state: .off, handler: optionClosure),
    UIAction(title: songArrayInside[0], image: UIImage(systemName: "play.circle"),state: .on , handler: optionClosure)
    ])

    songSelectedButton.showsMenuAsPrimaryAction = true
    songSelectedButton.changesSelectionAsPrimaryAction = true
    
    } //func to trigger button outside Pressed IBO works better!
    
    
    
    
    
//MARK: - Recording Brain
    
   
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        playButton.setTitle("Play", for: .normal)
        
    
        
    }
    
    @IBAction func recordPressed(_ sender: UIButton) {
  //      if recordButton.titleLabel?.text == "Record" {

            if let recorder = audioRecorder {
                if !recorder.isRecording {
                    let audioSession = AVAudioSession.sharedInstance()
                    
                    do {
                        try audioSession.setActive(true)
                    } catch _ {
                    }
                    
                    // Start recording
                    recorder.record()
                    recordButton.setTitle("Stop", for: .normal)
                    playButton.isEnabled = false
                    saveButton.isEnabled = true
        } else {
            
            if let recorder = audioRecorder {
                if recorder.isRecording {
                    audioRecorder?.stop()
                    let audioSession = AVAudioSession.sharedInstance()
                    do {
                        try audioSession.setActive(false)
                    } catch _ {
                    }
                }
            }
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = false
        }
    }
 //   }
}
    
    @IBAction func playPressed(_ sender: UIButton) {
//        if let player = audioPlayer {
//            if player.isPlaying {
//                player.stop()
//                playButton.setTitle("Play", for: .normal)
//                playButton.isSelected = false
//            }
//        }
        
        
        if playButton.titleLabel?.text == "Play" {
            playButton.setTitle("Stop", for: .normal)
            recordButton.isEnabled = false
    
            //(New)
            if let recorder = audioRecorder {
                      if !recorder.isRecording {
                          audioPlayer = try? AVAudioPlayer(contentsOf: recorder.url)
                          audioPlayer?.delegate = self
                          audioPlayer?.play()
                          audioPlayer?.volume = 0.1
//
                          recordingDuration = audioPlayer?.duration ?? 0.0
                          print("recordingDuration\(recordingDuration)")
                          
                          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                              self.audioPlayer?.setVolume(1.0, fadeDuration: 0.5)
                          }
                          DispatchQueue.main.asyncAfter(deadline: .now() + recordingDuration - 0.2) {
                              self.audioPlayer?.setVolume(0.0, fadeDuration: 0.2)
                          }
                      }
            }
            
        } else {
       
            // Stop the audio player if playing
            if let player = audioPlayer {
                if player.isPlaying {
                    player.stop()
                }
            }
            playButton.setTitle("Play", for: .normal)
            recordButton.isEnabled = true
        }
    
} //End playPressed
    
    //MARK: - PlayPVPressed (Play With Music)
    
    @IBAction func playPVPressed(_ sender: UIButton) {
                loopPlayed = 0
      
                if playButtonPV.titleLabel?.text == "Play" {
                    playButtonPV.setTitle("Stop", for: .normal)
//                    playButtonPV.configuration?.subtitle = "Shit"
                    recordButton.isEnabled = false
                
                    soundTimePassed = timePassed
                    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                    //(New)
                    if let recorder = audioRecorder {
                              if !recorder.isRecording {
                                  audioPlayer = try? AVAudioPlayer(contentsOf: recorder.url)
                                  audioPlayer?.delegate = self
                                  audioPlayer?.play()
                                  audioPlayer?.volume = 0.1
                                  recordingDuration = audioPlayer?.duration ?? 0.0
                                  print("recordingDuration\(recordingDuration)")
                                  
                                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                      self.audioPlayer?.setVolume(1.0, fadeDuration: 0.5)
                                  }
                                  DispatchQueue.main.asyncAfter(deadline: .now() + recordingDuration - 0.2) {
                                      self.audioPlayer?.setVolume(0.0, fadeDuration: 0.2)
                                  }
                                  loopPlayed += 1
                              }
                    }
                    playSound(soundName: songSelected)
                    musicPlayer!.volume = 0.5
                    totalTime = musicPlayer!.duration
                } else {
                    // Stop the audio player if playing
                    if let player = audioPlayer {
                        if player.isPlaying {
                            player.stop()
                        }
                    }
                    audioPlayer2?.stop()
                    audioPlayer?.stop()
                    timer.invalidate()
//                    musicPlayer.stop()
                    if let player3 = musicPlayer {
                        if player3.isPlaying {
                            player3.stop()
                        }
                    }
                    //(old)
                    playButtonPV.setTitle("Play", for: .normal)
                    recordButton.isEnabled = true
                    }
    }//playPVPressed END
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: url!)
        musicPlayer!.play()
    }
    
    func playAudioAtDurration() {
        let result = recordingDuration - 0.29
//        Oeginaly at .30, can go to .28 for faster but that seems as far as you can go without stepping on         the other vocal playback.
        if soundTimePassed >= result {
            if (loopPlayed % 2 == 0) {
                if let recorder = audioRecorder {
                          if !recorder.isRecording {
                              audioPlayer = try? AVAudioPlayer(contentsOf: recorder.url)
                              audioPlayer?.delegate = self
                              audioPlayer?.play()
    //                          recordingDuration = audioPlayer?.duration ?? 0.0
    //                          print(recordingDuration)
                              audioPlayer?.volume = 0.1
                              DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                  self.audioPlayer?.setVolume(1.4, fadeDuration: 1.0)
                              }
                              DispatchQueue.main.asyncAfter(deadline: .now() + recordingDuration - 0.2) {
                                  self.audioPlayer?.setVolume(0.0, fadeDuration: 0.2)
                              }
                          }
                }
                loopPlayed += 1
                soundTimePassed = 0.0
                print("even")
                print(audioPlayer?.volume ?? 0.0)
            
            } else {
                if let recorder = audioRecorder {
                          if !recorder.isRecording {
                              audioPlayer2 = try? AVAudioPlayer(contentsOf: recorder.url)
                              audioPlayer2?.delegate = self
                              audioPlayer2?.play()
                              audioPlayer2?.volume = 0.3
                          }
                }
                loopPlayed += 1
                soundTimePassed = 0.0
                print(audioPlayer2?.volume ?? 0.0)
                print("odd")
            }
        } else {
            timesChecked += 1
        }
    }// playAudioDurration END
    
    @objc func updateTimer(){
        if soundTimePassed < recordingDuration {
            soundTimePassed += 0.01
            print("soundTime\(soundTimePassed)")
            playAudioAtDurration()
//            progressThrough()
        } else {
            timer.invalidate()
        }
    }
    
    
//MARK: - Recorder Brain Extra (Check Mic etc)
    func checkMicrophoneAccess() {
                    // Check Microphone Authorization
                    switch AVAudioSession.sharedInstance().recordPermission {
                        
                    case AVAudioSession.RecordPermission.granted:
                        print(#function, " Microphone Permission Granted")
                        break
                        
                    case AVAudioSession.RecordPermission.denied:
                        // Dismiss Keyboard (on UIView level, without reference to a specific text field)
                        UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
                        
                        
                    case AVAudioSession.RecordPermission.undetermined:
                        print("Request permission here")
                        // Dismiss Keyboard (on UIView level, without reference to a specific text field)
                        UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
                        
                        AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                            // Handle granted
                            if granted {
                                print(#function, " Now Granted")
                            } else {
                                print("Pemission Not Granted")
                                
                            } // end else
                        })
                    @unknown default:
                        print("ERROR! Unknown Default. Check!")
                    } // end switch
    } //checkMicrophone END
    
    
} // end of main ViewController

fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
return input.rawValue
}

// Helper function inserted by Swift migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    
    
}
