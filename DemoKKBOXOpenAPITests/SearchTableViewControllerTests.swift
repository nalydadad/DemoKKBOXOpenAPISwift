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
    
    // MARK: Test Return Value
    
    
    // MARK: Test State
    func testTableViewTitle() {
        // arrange
        let tableViewController = SearchTableViewController()
        
        // act
        let _ = tableViewController.view
        
        // assert
        XCTAssert(tableViewController.title! == "Featured Playlist")
    }
    
    func testTableViewIsNotEditingAfterViewDidLoad() {
        // arrange
        let tableViewController = SearchTableViewController()
        
        // act
        let _ = tableViewController.view
        
        // assert
        XCTAssert(tableViewController.tableView.isEditing == false)
    }

    
    // MARK: Stub API Test
    
    func testNumberOfRowInSectionOneWithHasDataStubAPI() {
        // arrange
        let tableViewController = SearchTableViewController(apiManager: HasDataStubAPIManager())
        
        // act
        tableViewController.fetchData()
        
        // assert
        XCTAssert(tableViewController.tableView.numberOfRows(inSection: 1) == 30)
    }
    
    func testNumberOfPlaylistsWithHasDataStubAPI() {
        // arrange
        let tableViewController = SearchTableViewController(apiManager: HasDataStubAPIManager())
        
        // act
        tableViewController.fetchData()
        
        // assert
        XCTAssert(tableViewController.playlist!.count == 30)
    }
    
    func testNumberOfRowInSectionOneWithErrorStubAPI() {
        // arrange
        let tableViewController = SearchTableViewController(apiManager: ErrorStubAPIManager())
        
        // act
        tableViewController.fetchData()
        
        // assert
        XCTAssert(tableViewController.tableView.numberOfRows(inSection: 1) == 0)
    }
    
    func testPlaylistsIsNilWithErrorStubAPI() {
        // arrange
        let tableViewController = SearchTableViewController(apiManager: ErrorStubAPIManager())
        
        // act
        tableViewController.fetchData()
        
        // assert
        XCTAssert(tableViewController.playlist == nil)
    }
    
    
    // MARK: Mock Test
    
    func testDidSelectPlaylistDelegate() {
        // arrange
        let mockDelegate = MockSearchTableViewControllerDelegate()
        let tableViewController = SearchTableViewController()
        tableViewController.delegate = mockDelegate
        
        // act
        tableViewController.tableView(tableViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // assert
        XCTAssertTrue(mockDelegate.didRecieveDelegateSignal)
    }

}


private class HasDataStubAPIManager: APIManager {
    /**
     * Stub
     * A KKPlaylistList which contains 30 playlistInfo
     */
    override func fetchFeaturedPlaylists(callback: @escaping (KKPlaylistList?, Error?) -> ()) {
        callback(parseDummyData()!, nil)
    }
    
    private func parseDummyData() -> KKPlaylistList? {
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

private class MockSearchTableViewControllerDelegate: SearchTableViewcontrollerDelegate {
    var didRecieveDelegateSignal = false
    
    func searchTableViewController(tableViewController: SearchTableViewController, didSelectPlaylistAt index: Int, playlist: KKPlaylistInfo?) {
        self.didRecieveDelegateSignal = true
    }
    
}


private class ErrorStubAPIManager: APIManager {
    override func fetchFeaturedPlaylists(callback: @escaping (KKPlaylistList?, Error?) -> ()) {
        callback(nil, MyError.NoData)
    }
}

private enum MyError: Error {
    case NoData
}


