//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Kyle Hodgetts on 10/06/2015.
//  Copyright (c) 2015 Kyle Hodgetts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lblRecording: UILabel!
    @IBOutlet weak var btnStop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //IBAction: InterfaceBuilderAction
    //sender: UIButton --> sender is a UIButton
    @IBAction func recordAudio(sender: UIButton) {
        println("in record audio")
        lblRecording.hidden = false
        btnStop.hidden = false
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        lblRecording.hidden = true
        btnStop.hidden = true
    }
}

