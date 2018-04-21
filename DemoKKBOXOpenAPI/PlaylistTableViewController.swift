//
//  PlaylistTableViewController.swift
//  DemoKKBOXOpenAPI
//
//  Created by DADA on 2018/4/21.
//  Copyright © 2018年 DADA. All rights reserved.
//

import UIKit
import KKBOXOpenAPISwift

class PlaylistViewController: UIViewController {
    
    
    private let info: KKPlaylistInfo!
    
    private let imageView = UIImageView()
    private let headerLabel = UILabel()
    
    init(info: KKPlaylistInfo) {
        self.info = info
        super.init(nibName: nil, bundle: nil)
        self.title = info.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.bounds.width
        
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = UIColor.white
        
        imageView.backgroundColor = UIColor.gray
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        scrollView.addSubview(imageView)
        
        headerLabel.numberOfLines = 0
        headerLabel.text = info.playlistDescription
        headerLabel.frame = CGRect(x: 20, y: imageView.frame.maxY + 20, width: self.view.bounds.width - 40, height: 0)
        headerLabel.sizeToFit()
        scrollView.addSubview(headerLabel)
        
        scrollView.contentSize = CGSize(width: width, height: self.headerLabel.frame.maxY + 20)
        
        view.addSubview(scrollView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let imageURL = self.info.images.first?.url {
            fetchImage(with: imageURL)
        }
    }
    
    func fetchImage(with url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { [weak self] in
                if let data = data {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
    
}
