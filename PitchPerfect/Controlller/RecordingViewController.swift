//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Ammar AlTahhan on 17/10/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController {
    
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingStateLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopRecordingButton.isEnabled = false
        addButtons()
        setTheme(themeStyle)
    }
    
    @objc
    private func switchTheme(_ sender: Any) {
        // TODO: - Use `setThemeStyle` function to update the style in each one of the conditions accordingly
        if themeStyle == .dark {
            UserDefaults.standard.setThemeStyle(.light)
            navigationItem.rightBarButtonItem?.image = UIImage.lightIcon
        } else if themeStyle == .light {
            UserDefaults.standard.setThemeStyle(.dark)
            navigationItem.rightBarButtonItem?.image = UIImage.darkIcon
        }
        setTheme(themeStyle)
    }
    
    @objc
    private func showSaved(_ sender: Any) {
        navigationController?.pushViewController(SavedTableViewController(), animated: true)
    }
    
    // MARK: - IBAction methods
    
    @IBAction
    private func startRecordingTapped(_ sender: UIButton) {
        toggleRecording(true)
        
        let dirPath = (Constants.Files.Directories.first!).absoluteString
        // TODO: - Change file name to something unique. Most common ways of uniquely naming files are by using Date or UUID.
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction
    private func stopRecordingTapped(_ sender: UIButton) {
        toggleRecording(false)
        audioRecorder.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
    
    // MARK: - Private setup functions
    
    private func toggleRecording(_ isOn: Bool) {
        recordingStateLabel.text = isOn ? "Recording in progress" : "Tap to start recording"
        stopRecordingButton.isEnabled = isOn
        startRecordingButton.isEnabled = !isOn
    }
    
    private func addButtons() {
        var buttonImage: UIImage!
        if themeStyle == .dark {
            buttonImage = UIImage.darkIcon
        } else {
            buttonImage = UIImage.lightIcon
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(self.switchTheme(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Saved", style: .plain, target: self, action: #selector(self.showSaved(_:)))
    }
    
    // MARK: - Prepare for segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSegue", let vc = segue.destination as? PlaySoundsViewController {
            vc.recordedAudioURL = sender as? URL
            vc.displayState = .savable
        }
    }
    

}

// MARK: - AVAudioRecorderDelegate

extension RecordingViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        guard flag else { print("Error recording"); return }
        performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
    }
}
