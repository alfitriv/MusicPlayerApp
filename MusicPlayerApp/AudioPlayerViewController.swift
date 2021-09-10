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
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var audioPlayer: AVAudioPlayer?
    var avPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
            if let presentationController = presentationController as? UISheetPresentationController {
                presentationController.detents = [
                    .medium()
                ]
            }
        } else {
            // Fallback on earlier versions
        }
        
        playerProgress()
    }
    
    func setupView(music: Music) {
        artistLabel.text = music.artistName
        songLabel.text = music.trackName
    }
    
    func playerProgress() {
        var progress = Float(0)
        if let audioPlayer = audioPlayer {
            progress = ((audioPlayer.duration > 0)
                ? Float(audioPlayer.currentTime/audioPlayer.duration)
                : 0)
        }
        progressView.setProgress(progress, animated: true)
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        avPlayer?.pause()
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
