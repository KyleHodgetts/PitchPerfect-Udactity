//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Kyle Hodgetts on 10/06/2015.
//  Copyright (c) 2015 Kyle Hodgetts. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    private var audioEngine: AVAudioEngine!
    private var audioFile: AVAudioFile!
    var recievedAudio: RecordedAudio!

    
    private var playerNode: AVAudioPlayerNode!
    private var auTimePitch: AVAudioUnitTimePitch!
    
    private var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Instantiate AudioEngine
        audioEngine = AVAudioEngine()
        
        //Instantiate Audiofile to read the recieved audio via its fileUrl
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        
        //Instantiate the player with the contents of the filePathURL.
        player = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        
        //Enable rate so we can change the speed at which the sound is played
        player.enableRate = true
        
        
        
        /* LEGACY CODE */
        //Returns the file's location URL from the NSBundle (Project resources bundled)
        //Path for resource, from the main bundle look for the file name with the given type
        //        if var fileLoc = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
        //            //Convert string fileLoc to URLPath
        //            var filePathURL = NSURL.fileURLWithPath(fileLoc)
        //
        //        }
        //        else {
        //            println("File does not exist!")
        //        }
    }
    
    @IBAction func playSlowSound(sender: UIButton) {
        playSound(0.5)
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        playSound(2.0)
    }
    
    @IBAction func playChipmunkSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        player.stop()
    }
    
    private func playAudioWithVariablePitch(pitch: Float){
        //Reset everything to 0
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        //Instantiate audioPlayerNode and attach it to the engine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        //Instantiate the AudioTimeUnitPitch and attach it to the engine
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch     //Set pitch to argument value
        audioEngine.attachNode(changePitchEffect)
        
        //connect audioplayer to pitcheffect
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        //Connect pitch effect to output, such as speakers
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        //Schedule whole file to play as soon as function is called (atTime: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        //play the audioPlayer
        audioPlayerNode.play()
    }
    
    private func playSound(speed: Float){
        player.stop()
        player.rate = speed
        player.currentTime = 0.0
        player.play()
    }
    

}
