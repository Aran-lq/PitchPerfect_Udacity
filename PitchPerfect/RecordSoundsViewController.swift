//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by 李棋 on 2017/5/18.
//  Copyright © 2017年 Aran. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!  //give this ViewController the ability to use AVFoundation's function    -- lq

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("please listen to me!")
    }


    @IBAction func recordAudio(_ sender: Any) {
        print("be tame! you hurt me!")
        recordingLabel.text = "recording in Progress"
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
//        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self       //set this viewcontroller as a delegate of AVAudioRecorder
        
        
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(_ sender: Any) {
        print("be tough! I can't feel it !!!")
        recordingLabel.text = "Tap to record"
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance
        try! audioSession().setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("finished recording")
        }
    }
}

