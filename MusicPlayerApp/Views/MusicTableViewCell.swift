//
//  MusicTableViewCell.swift
//  MusicTableViewCell
//
//  Created by Mila on 09/09/21.
//

import UIKit
import Kingfisher

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumPictureImage: UIImageView!
    
    func setupView(music: Music) {
        artistNameLabel.text = music.artistName
        songNameLabel.text = music.trackName
        albumNameLabel.text = music.collectionName
        
        let url = URL(string: music.artworkUrl60 ?? "")
        imageView?.kf.setImage(with: url)
    }
    
}
