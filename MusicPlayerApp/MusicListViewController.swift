//
//  MusicListViewController.swift
//  MusicListViewController
//
//  Created by Mila on 12/09/21.
//

import UIKit
import AVFoundation

class MusicListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var musicList: [Music] = []
    var avPlayer: AVPlayer?
    private let musicService: MusicService
    let searchController = UISearchController(searchResultsController: nil)
    
    init(musicService: MusicService) {
        self.musicService = musicService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Music"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        tableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "musicCell")
    }

}

extension MusicListViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioPlayerVC = AudioPlayerViewController()
        let music = musicList[indexPath.row]
        audioPlayerVC.music = music
    
        do {
            let musicURL = URL(string: music.previewUrl!)
            let playerItem: AVPlayerItem = AVPlayerItem(url: musicURL!)
            avPlayer = AVPlayer(playerItem: playerItem)
            avPlayer?.playImmediately(atRate: 1.0)
            audioPlayerVC.avPlayer = avPlayer
            } catch {
                
            }
        self.present(audioPlayerVC, animated: true, completion: nil)
    }
}

extension MusicListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.count ?? 0 > 3 {
            musicService.fetchMusicResults(searchText: searchController.searchBar.text ?? "", successHandler: { [weak self] (music) in
                self?.musicList = music.results
                self?.tableView.reloadData()
            }) { (error) in
                print(error)
            }
        }
    }
}
