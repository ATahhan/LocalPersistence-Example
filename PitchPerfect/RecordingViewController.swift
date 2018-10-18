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
    }
    
    // MARK: - IBAction methods
    
    @IBAction func startRecordingTapped(_ sender: UIButton) {
        toggleRecording(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
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
    
    @IBAction func stopRecordingTapped(_ sender: UIButton) {
        toggleRecording(false)
        audioRecorder.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
    
    // MARK: - Helpers
    
    private func toggleRecording(_ isOn: Bool) {
        recordingStateLabel.text = isOn ? "Recording in progress" : "Tap to start recording"
        stopRecordingButton.isEnabled = isOn
        startRecordingButton.isEnabled = !isOn
    }
    
    // MARK: Prepare for segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSegue", let vc = segue.destination as? PlaySoundsViewController {
            vc.recordedAudioURL = sender as? URL
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
