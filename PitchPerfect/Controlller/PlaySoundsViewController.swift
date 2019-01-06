//
//  RecordAgentViewController.swift
//  PitchPerfect
//
//  Created by Ammar AlTahhan on 17/10/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import AVFoundation

/// This is used to distinguish between first time recordings that is savable and previously saved files
enum DisplayState { case savable, notSavable }

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var displayState: DisplayState!
    var isSaved: Bool = false
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
        setTheme(themeStyle)
        setupDisplayState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !isSaved {
            removeCurrentFile()
        }
    }
    
    // MARK: - IBAction methods
    
    @IBAction
    private func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction
    private func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    @IBAction
    private func saveFile(_ sender: UIBarButtonItem) {
        isSaved = true
        sender.isEnabled = false
        let alert = UIAlertController(title: "Saved", message: "File saved successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private setup functions
    
    /// Called in viewWillDisappear
    private func removeCurrentFile() {
        // TODO: - Delete current file by passing `recordedAudioURL` to FileManager's `removeItem(at:)` function
        do {
            try FileManager.default.removeItem(at: recordedAudioURL)
        } catch {
            print("Couldn't delete file. \(error)")
        }
    }
    
    private func setupDisplayState() {
        switch displayState! {
        case .savable:
            isSaved = false
            saveBarButtonItem.isEnabled = true
        case .notSavable:
            isSaved = true
            saveBarButtonItem.isEnabled = false
        }
    }

}

extension PlaySoundsViewController {
    static func instantiateFromStoryboard() -> PlaySoundsViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlaySoundsViewController") as! PlaySoundsViewController
    }
}
