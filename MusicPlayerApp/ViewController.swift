//
//  ViewController.swift
//  MusicPlayerApp
//
//  Created by Mila on 08/09/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var networkLayer = NetworkLayer.shared
    var musicList: [Music] = []
    var filteredMusic: [Music] = []
    var audioPlayer: AVAudioPlayer?
    var avPlayer: AVPlayer?
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        networkLayer.fetchMusicResults(successHandler: { [weak self] (music) in
//            self?.musicList = music.results
//            self?.tableView.reloadData()
//        }) { (error) in
//            print(error)
//        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Music"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "musicCell")
    }
    
//    func filterContentForSearchText(_ searchText: String,
//                                    category: Candy.Category? = nil) {
//      filteredCandies = candies.filter { (candy: Candy) -> Bool in
//        return candy.name.lowercased().contains(searchText.lowercased())
//      }
//
//      tableView.reloadData()
//    }
    
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

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.count ?? 0 > 3 {
            networkLayer.fetchMusicResults(searchText: searchController.searchBar.text ?? "", successHandler: { [weak self] (music) in
                self?.musicList = music.results
                self?.tableView.reloadData()
            }) { (error) in
                print(error)
            }
        }
    }
}
