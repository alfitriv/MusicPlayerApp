//
//  NetworkLayer.swift
//  NetworkLayer
//
//  Created by Mila on 08/09/21.
//

import Foundation

protocol MusicService {
    func fetchMusicResults(searchText: String, successHandler: @escaping (Result) -> Void, errorHandler: @escaping (Error) -> Void)
}

class NetworkLayer: MusicService {
    static var shared = NetworkLayer()
    private init(){}
    
    func fetchMusicResults(searchText: String, successHandler: @escaping (Result) -> Void, errorHandler: @escaping (Error) -> Void) {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: URL(string: "https://itunes.apple.com/search?term=\(searchText)&media=music")!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
                    guard error == nil else {
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                        return
                    }
                    
                    guard let data = data else {
                        DispatchQueue.main.async {
                            errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                        }
                        return
                    }
                    
                    print(data)
                    
                    do {
                        let musicList = try JSONDecoder().decode(Result.self, from: data)
                        print(musicList)
                        DispatchQueue.main.async {
                            successHandler(musicList)
                        }
                    } catch {
                        fatalError()
                    }
                    
                }.resume()
    }
}
