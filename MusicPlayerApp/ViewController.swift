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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkLayer.fetchMusicResults(successHandler: { [weak self] (music) in
            self?.musicList = music.results
            self?.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
        tableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "musicCell")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicTableViewCell
        let music = musicList[indexPath.row]
        cell.setupView(music: music)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
