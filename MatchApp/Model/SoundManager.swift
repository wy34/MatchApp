//
//  SoundManager.swift
//  MatchApp
//
//  Created by William Yeung on 3/30/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import Foundation
import AVFoundation



class SoundManager {
    var audioPlayer: AVAudioPlayer?

    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
    }
    
    
    func playSound(effect: SoundEffect) {
        var soundFileName = ""
        
        switch effect {
            case .flip:
                soundFileName = "cardflip"
            case .match:
                soundFileName = "dingcorrect"
            case .nomatch:
                soundFileName = "dingwrong"
            case .shuffle:
                soundFileName = "shuffle"
        }
        
        // get the path to the soundfile
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
        
        // check that it is not nil
        guard let path = bundlePath else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            // create the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            // plays the sound using the audio player
            audioPlayer?.play()
        } catch {
            print("Couldn't create an audio player")
            return
        }
    }
}
