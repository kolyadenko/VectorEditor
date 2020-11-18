//
//  SessionSplitViewController.swift
//  VectorEditor
//
//  Created by Alexey Kolyadenko on 18.11.2020.
//

import UIKit

class SessionSplitViewController: UISplitViewController {
    var session: Session!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadDocument() {
        session.loadDocument()
    }
}
