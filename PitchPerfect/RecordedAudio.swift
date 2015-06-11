//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Kyle Hodgetts on 11/06/2015.
//  Copyright (c) 2015 Kyle Hodgetts. All rights reserved.
//

import Foundation

//NSObject is where most objects inherit from
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(aFilePathUrl: NSURL, aTitle: String){
        filePathUrl = aFilePathUrl
        title = aTitle
    }
    
    
}
