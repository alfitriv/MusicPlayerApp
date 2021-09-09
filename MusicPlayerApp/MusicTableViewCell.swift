//
//  MusicTableViewCell.swift
//  MusicTableViewCell
//
//  Created by Mila on 09/09/21.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumPictureImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(music: Music) {
        artistNameLabel.text = music.artistName
        songNameLabel.text = music.trackName
        albumNameLabel.text = music.collectionName
    }
    
}
