//
//  AudioPlayerViewController.swift
//  AudioPlayerViewController
//
//  Created by Mila on 09/09/21.
//

import UIKit
import AVFAudio
import AVFoundation

class AudioPlayerViewController: UIViewController {
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    var avPlayer: AVPlayer?
    var isPaused: Bool = false
    var music: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playPauseButton.setTitle("Pause", for: .normal)
        setupView(music: music ?? Music(artistName: nil, trackName: nil, previewUrl: nil, collectionName: nil, artworkUrl60: nil, trackViewUrl: nil))

        if #available(iOS 15.0, *) {
            if let presentationController = presentationController as? UISheetPresentationController {
                presentationController.detents = [
                    .medium()
                ]
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func setupView(music: Music) {
        artistTitleLabel.text = music.artistName
        songTitleLabel.text = music.trackName
    }
    
    func togglePlayAndPause() {
        if isPaused == true {
            avPlayer?.pause()
            playPauseButton.setTitle("Play", for: .normal)
        } else {
            avPlayer?.play()
            playPauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        isPaused = !isPaused
        togglePlayAndPause()
    }

}
