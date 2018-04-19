//
//  SearchTableViewControllerTests.swift
//  DemoKKBOXOpenAPITests
//
//  Created by DADA on 2018/4/19.
//  Copyright © 2018年 DADA. All rights reserved.
//

import XCTest
import KKBOXOpenAPISwift

class SearchTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testDummyData() {
        let tableViewController = SearchTableViewController(style: .grouped)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}


fileprivate class StubAPIManager: APIManager {
    
    // stub A KKPlaylistList which contains 30 playlistInfo
    override func fetchFeaturedPlaylists(callback: @escaping (KKPlaylistList?, Error?) -> ()) {
        callback(parseDummyData()!, nil)
    }
    
    func parseDummyData() -> KKPlaylistList? {
        let bundle = Bundle(for: SearchTableViewControllerTests.self)
        let url = bundle.url(forResource: "DummySDKStruct", withExtension: "json")!
        let jsonString = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        do {
            return try JSONDecoder().decode(KKPlaylistList.self, from: jsonData!)
        }
        catch {
            print(error)
        }
        return nil
    }
    
}




