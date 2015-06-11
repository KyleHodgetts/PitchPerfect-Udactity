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
    private var player: AVAudioPlayer!
    private var audioFile: AVAudioFile!
    
    var recievedAudio: RecordedAudio!

    
    
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
    }
    
    @IBAction func playSlowSound(sender: UIButton) {
        playSoundWithVariableSpeed(0.5)
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        playSoundWithVariableSpeed(2.0)
    }
    
    @IBAction func playChipmunkSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderSound(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        stopAllAudio()
    }
    
    private func stopAllAudio(){
        //Reset everything to 0
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    private func playAudioWithVariablePitch(pitch: Float){
        stopAllAudio()
        
        //Instantiate audioPlayerNode and attach it to the engine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        //Instantiate the AudioTimeUnitPitch and attach it to the engine
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch     //Set pitch to argument value
        audioEngine.attachNode(changePitchEffect)
        
        var audioSpeed = AVAudioUnitVarispeed()
        audioSpeed.rate = 1.0
        audioEngine.attachNode(audioSpeed)
        
        //connect audioplayer to pitcheffect
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioSpeed, format: nil)
        //Connect pitch effect to output, such as speakers
        audioEngine.connect(audioSpeed, to: audioEngine.outputNode, format: nil)
        
        //Schedule whole file to play as soon as function is called (atTime: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        //play the audioPlayer
        audioPlayerNode.play()
    }
    
    private func playSoundWithVariableSpeed(speed: Float){
        stopAllAudio()
        player.rate = speed
        player.currentTime = 0.0
        player.play()
    }
    

}
