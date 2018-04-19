//
//  APIManagerTests.swift
//  DemoKKBOXOpenAPITests
//
//  Created by DADA on 2018/4/20.
//  Copyright © 2018年 DADA. All rights reserved.
//

import XCTest
import KKBOXOpenAPISwift

class APIManagerTests: XCTestCase {
    
    func testfetchFeaturedPlaylists() {
        // arrange
        let apiManager = APIManager()
        let expectation = XCTestExpectation(description: "Expects API response containing values and no error.")
        
        // act
        apiManager.fetchFeaturedPlaylists { (playlist, error) in
//            XCTAssertNotNil(playlist)
            self.verifyPlaylistList(playlist!)
            XCTAssertNil(error, error.debugDescription)
            expectation.fulfill()
        }
        
        // assert
        wait(for: [expectation], timeout: 10)
    }
    
    func verifyPlaylistList(_ playlistList: KKPlaylistList) {
        XCTAssertNotNil(playlistList.playlists)
    }
    
}
