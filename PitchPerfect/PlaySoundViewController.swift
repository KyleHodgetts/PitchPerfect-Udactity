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
    
    private var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Returns the file's location URL from the NSBundle (Project resources bundled)
        //Path for resource, from the main bundle look for the file name with the given type
        if var fileLoc = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            //Convert string fileLoc to URLPath
            var filePathURL = NSURL.fileURLWithPath(fileLoc)
            
            //Instantiate the player with the contents of the filePathURL.
            player = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
            
            //Enable rate so we can change the speed at which the sound is played
            player.enableRate = true
        }
        else {
            println("File does not exist!")
        }
    }
    
    @IBAction func playSlowSound(sender: UIButton) {
        playSound(0.5)
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        playSound(2.0)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        player.stop()
    }
    
    private func playSound(speed: Float){
        player.stop()
        player.rate = speed
        player.currentTime = 0.0
        player.play()
    }
    

}
