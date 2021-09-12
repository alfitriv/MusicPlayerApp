//
//  MusicListViewControllerTests.swift
//  MusicListViewControllerTests
//
//  Created by Mila on 12/09/21.
//

import XCTest
import UIKit
@testable import MusicPlayerApp

class MusicListViewControllerTests: XCTestCase {
    var sut: MusicListViewController!
    var mockMusicService: MockMusicService!
    
    override func setUp() {
        super.setUp()
        mockMusicService = MockMusicService()
        sut = MusicListViewController(musicService: mockMusicService)
    }
    
    func testFetchMusicIsInvokedInViewDidLoad() {
        _ = sut.view
        XCTAssertFalse(mockMusicService.isFetchMusicListInvoked)
    }
}
