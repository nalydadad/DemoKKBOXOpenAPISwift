//
//  SearchTableViewController.swift
//  DemoKKBOXOpenAPI
//
//  Created by DADA on 2018/4/19.
//  Copyright © 2018年 DADA. All rights reserved.
//

import UIKit
import KKBOXOpenAPISwift

protocol SearchTableViewcontrollerDelegate {
    func searchTableViewController(tableViewController: SearchTableViewController, didSelectPlaylistAt index: Int, playlist: KKPlaylistInfo?)
}

class SearchTableViewController: UITableViewController {
    var playlistList: KKPlaylistList?
    var playlist: [KKPlaylistInfo]?
    var delegate: SearchTableViewcontrollerDelegate?
    private let apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
        super.init(style: .grouped)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.title = "Featured Playlist"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fetchData() {
        self.apiManager.fetchFeaturedPlaylists { [weak self] (list, error) in
            if let _ = error {
                self?.playlist = nil
            }
            else {
                self?.playlistList = list
                self?.playlist = list?.playlists
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func clearData() {
        self.playlist = nil
        self.playlistList = nil
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.playlistList == nil ? 1 : 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 1) ? self.playlist?.count ?? 0 : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Fetch data"
            cell.detailTextLabel?.text = ""
        case 1:
            if let playlist = playlist, let info = playlist.element(at: indexPath.row) {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
                cell.textLabel?.text = info.title
                cell.detailTextLabel?.text = info.owner.name
                cell.detailTextLabel?.textColor = UIColor.gray
            }
        case 2:
            cell.textLabel?.text = "Cache Playlist Info"
            cell.detailTextLabel?.text = ""
        case 3:
            cell.textLabel?.text = "Clear data"
            cell.detailTextLabel?.text = ""
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Use \"KKBOX-OpenAPI\" to fetch"
        case 1:
            return "\(self.playlist?.count ?? 0) playlists"
        case 2:
            return "Encoded data"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)
        
        self.delegate?.searchTableViewController(tableViewController: self, didSelectPlaylistAt: indexPath.item, playlist: self.playlist?.element(at: indexPath.item))
        
        switch indexPath.section {
        case 0:
            fetchData()
        case 1:
            if let playlist = self.playlist?.element(at: indexPath.row) {
                let viewController = PlaylistViewController(info: playlist)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        case 2:
            if let playlistList = self.playlistList {
                let viewController = DebugViewController(info: playlistList)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        case 3:
            clearData()
        default:
            break
        }
    }

}

extension Array {
    func element(at index: Int) -> Element? {
        if index >= self.count {
            return nil
        }
        return self[index]
    }
    
}
