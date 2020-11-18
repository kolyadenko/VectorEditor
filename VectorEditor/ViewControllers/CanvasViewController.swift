//
//  CanvasViewController.swift
//  VectorEditor
//
//  Created by Alexey Kolyadenko on 18.11.2020.
//

import UIKit

class CanvasViewController: UIViewController {
    weak var delegate: CanvasViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [.init(title: "Reet", style: .plain, target: self, action: #selector(addReet(sender:))), .init(title: "Circle", style: .plain, target: self, action: #selector(addCircle(sender:)))]
        navigationItem.title = delegate?.documentName
    }
    
    @objc func addReet(sender: UIBarItem) {
        delegate?.addDrawable(drawable: Reet())
    }
    
    @objc func addCircle(sender: UIBarItem) {
        delegate?.addDrawable(drawable: Circle())
    }
    
    func redraw() {
        
    }
}

protocol CanvasViewControllerDelegate: class {
    func addDrawable(drawable: Drawable)
    var documentName: String? { get }
}
