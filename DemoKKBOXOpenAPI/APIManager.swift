//
//  APIManager.swift
//  DemoKKBOXOpenAPI
//
//  Created by DADA on 2018/4/19.
//  Copyright © 2018年 DADA. All rights reserved.
//

import UIKit
import KKBOXOpenAPISwift

let clientID = "78a1c0cd373907ae5e1dd5a8245effae"
let clientSecret = "b9202c7e7b1d995b18fd2674410474b5"

class APIManager: NSObject {
    
    static let shared = APIManager()
    private (set) var API = KKBOXOpenAPI(clientID: clientID, secret: clientSecret)
    
    internal func doAPICallWithAccessToken(callback: @escaping (Error?) -> ()) {
        if let _ = self.API.accessToken {
            callback(nil)
            return
        }
        _ = try? self.API.fetchAccessTokenByClientCredential { result in
            switch result {
            case .error(let error):
                callback(error)
            case .success(_):
                break
            }
        }
    }
    
    func fetchFeaturedPlaylists(callback: @escaping (KKPlaylistList?, Error?) -> ()) {
        callAPI { (error) in
            if let _ = error {
                callback(nil, error)
                return
            }
            
            _ = try? self.API.fetchFeaturedPlaylists(callback: {
                result in
                switch result {
                case .error(let error):
                    callback(nil, error)
                case .success(let playlist):
                    callback(playlist, nil)
                }
            })
        }
    }
    
    private func callAPI(callback: @escaping (Error?) -> ()) {
        doAPICallWithAccessToken { (error) in
            if let _ = error {
                callback(error)
            }
            else {
                callback(nil)
            }
        }
    }
}
