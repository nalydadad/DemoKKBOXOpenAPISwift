//
//  DebugViewController.swift
//  DemoKKBOXOpenAPI
//
//  Created by DADA on 2018/4/21.
//  Copyright © 2018年 DADA. All rights reserved.
//

import UIKit
import KKBOXOpenAPISwift

class DebugViewController: UIViewController {

    private let info: KKPlaylistList
    
    init(info: KKPlaylistList) {
        self.info = info
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textView = UITextView(frame: self.view.bounds)
        textView.backgroundColor = UIColor.white
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self.info)
            textView.text = String(data: data, encoding: String.Encoding.utf8)
        }
        catch {
            textView.text = error.localizedDescription
        }
        
        self.view.addSubview(textView)
    }

    

}
