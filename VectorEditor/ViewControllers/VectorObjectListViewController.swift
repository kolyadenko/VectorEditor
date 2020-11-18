//
//  ViewController.swift
//  VectorEditor
//
//  Created by Alexey Kolyadenko on 18.11.2020.
//

import UIKit

class VectorObjectListViewController: UIViewController {
    // MARK: Props
    weak var delegate: VectorObjectListViewControllerDelegate?
    
    var items: [Drawable] {
        return delegate?.items ?? []
    }
    
    // MARK: Private props
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:m:s dd/MM/YYYY"
        return formatter
    }()
    
    // MARK:  Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.allowsSelection = false
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

protocol VectorObjectListViewControllerDelegate: class {
    var items: [Drawable] { get }
    func removeItem(at indexPath: IndexPath)
}

extension VectorObjectListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.metadata.name
        cell.detailTextLabel?.text = dateFormatter.string(from: item.metadata.updatedAt)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            delegate?.removeItem(at: indexPath)
        }
    }
}
