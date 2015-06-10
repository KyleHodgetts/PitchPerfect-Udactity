//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Kyle Hodgetts on 10/06/2015.
//  Copyright (c) 2015 Kyle Hodgetts. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblRecording: UILabel!
    @IBOutlet weak var btnStop: UIButton!
    
    var recorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        btnStop.hidden = true
        lblRecording.hidden = true
        btnRecord.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //IBAction: InterfaceBuilderAction
    //sender: UIButton --> sender is a UIButton
    @IBAction func recordAudio(sender: UIButton) {
        println("in record audio")
        btnRecord.enabled = false
        lblRecording.hidden = false
        btnStop.hidden = false
        
        //true -> expand tilde
        //As String and NOT :AnyObject
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        //Set name of file
        let recordingName = "my_audio.wav"
        
        let pathArray = [dirPath, recordingName]
        
        //Accepts an array where the first element is a directory and the second is a file name
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        //Define audio session
        var session = AVAudioSession.sharedInstance()
        
        //Audio Session Category: Play and Record
        //-->Record input and play
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //Instantiate the recorder
        recorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        recorder.delegate = self
        recorder.meteringEnabled = true
        recorder.prepareToRecord()
        recorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
    }

    @IBAction func stopButtonPressed(sender: UIButton) {
        recorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        btnRecord.enabled = true
        lblRecording.hidden = true
        btnStop.hidden = true
    }
}

