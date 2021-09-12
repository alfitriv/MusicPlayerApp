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
        setupPauseButton()
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
    
    private func setupPlayButton() {
        playPauseButton.setTitle("Play", for: .normal)
        playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
    }
    
    private func setupPauseButton() {
        playPauseButton.setTitle("Pause", for: .normal)
        playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
    }
    
    private func togglePlayAndPause() {
        if isPaused == true {
            avPlayer?.pause()
            setupPlayButton()
        } else {
            avPlayer?.play()
            setupPauseButton()
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        isPaused = !isPaused
        togglePlayAndPause()
    }

}
