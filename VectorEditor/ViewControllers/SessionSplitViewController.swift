//
//  SessionSplitViewController.swift
//  VectorEditor
//
//  Created by Alexey Kolyadenko on 18.11.2020.
//

import UIKit

class SessionSplitViewController: UISplitViewController {
    weak var masterViewController: VectorObjectListViewController? {
        didSet {
            masterViewController?.delegate = self
        }
    }
    weak var detailViewController: CanvasViewController? {
        didSet {
            detailViewController?.delegate = self
        }
    }
    
    var session: Session! {
        didSet {
            session.currentDocument?.itemsUpdatedBlock = { [unowned self] in
                self.masterViewController?.tableView?.reloadData()
                self.detailViewController?.redraw()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SessionSplitViewController: CanvasViewControllerDelegate, VectorObjectListViewControllerDelegate {
    var items: [Drawable] { return session.currentDocument?.items ?? [] }

    func addDrawable(drawable: Drawable) {
        session.currentDocument?.items.append(drawable)
    }
    
    func removeItem(at indexPath: IndexPath) {
        session.currentDocument?.items.remove(at: indexPath.row)
    }
    
    var documentName: String? {
        return session.documentName
    }
}
