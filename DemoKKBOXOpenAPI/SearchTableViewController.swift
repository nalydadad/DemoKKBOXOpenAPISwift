//
//  SearchTableViewController.swift
//  DemoKKBOXOpenAPI
//
//  Created by DADA on 2018/4/19.
//  Copyright © 2018年 DADA. All rights reserved.
//

import UIKit
import KKBOXOpenAPISwift

class SearchTableViewController: UITableViewController {
    var playlist: [KKPlaylistInfo]?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
    }

    func refreshData() {
        APIManager.shared.fetchFeaturedPlaylists { [unowned self] (list, error) in
            if let _ = error {
                self.playlist = nil
            }
            else {
                self.playlist = list?.playlists
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : self.playlist?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "fetch"
            cell.detailTextLabel?.text = ""
        case 1:
            if let playlist = playlist, let info = playlist.element(at: indexPath.row) {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
                cell.textLabel?.text = info.title
                cell.detailTextLabel?.text = info.owner.name
                cell.detailTextLabel?.textColor = UIColor.gray
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)
        
        switch indexPath.section {
        case 0:
            refreshData()
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
