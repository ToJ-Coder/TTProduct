//
//  TTChildrenViewController.swift
//  TTProduct-macOS
//
//  Created by Toj on 1/21/21.
//

import Cocoa
import TTCOM_macOS

class TTChildrenViewController: TTViewController {

    override func loadView() {
         view = TTDraggedView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tt_backgroundColor = .red
    }
}
