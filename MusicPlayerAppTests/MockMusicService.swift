//
//  MockMusicService.swift
//  MockMusicService
//
//  Created by Mila on 12/09/21.
//

import Foundation
@testable import MusicPlayerApp

class MockMusicService: MusicService {
    var isFetchMusicListInvoked = false
    
    func fetchMusicResults(searchText: String, successHandler: @escaping (Result) -> Void, errorHandler: @escaping (Error) -> Void) {
        isFetchMusicListInvoked = true
        
    }
    
    
}
