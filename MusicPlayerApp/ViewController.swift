//
//  ViewController.swift
//  MusicPlayerApp
//
//  Created by Mila on 08/09/21.
//

import UIKit

class ViewController: UIViewController {
    var networkLayer = NetworkLayer.shared
    var musicList: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkLayer.fetchMusicResults(successHandler: { [weak self] (music) in
            self?.musicList = music.results
        }) { (error) in
            print(error)
        }
    }
    
}

