//
//  Model.swift
//  VectorEditor
//
//  Created by Alexey Kolyadenko on 18.11.2020.
//

import UIKit

// MARK: Session
class Session {
    var currentDocument: VectorDocument?
    private(set) var documentName: String
    
    // Can be extended to URI
    init(withDocumentName documentName: String = "Default Vector Document") {
        self.documentName = documentName
        loadDocument()
        if currentDocument == nil {
            let name = "New Document"
            currentDocument = VectorDocument(name: name)
            self.documentName = name
        }
    }
    
    func loadDocument() {
        // TODO: Implement loading from filesystem
    }
    
    func saveDocument() {
        // TODO: Implement saving to filesystem
    }
}

// MARK: Document
class VectorDocument: NSObject {
    var items: [Drawable] = [] {
        didSet {
            itemsUpdatedBlock?()
        }
    }
    var metadata: Metadata
    
    var itemsUpdatedBlock: (() -> Void)?
    
    init(name: String) {
        self.metadata = Metadata(name: name)
    }
}

// MARK: Drawable protocol related
protocol Drawable {
    var metadata: Metadata { get set }
    var rect: CGRect? { get set }
    func draw()
}

struct Metadata {
    var name: String
    var updatedAt: Date = Date()
}

// MARK: Drawable implementation
struct Rect: Drawable {
    var metadata: Metadata
    var rect: CGRect?
    
    init() {
        self.metadata = Metadata(name: "Rect")
    }
    
    func draw() {
        guard let rect = self.rect else { return }
        let path = UIBezierPath(rect: rect)
        path.stroke()
    }
}

struct Circle: Drawable {
    var metadata: Metadata
    var rect: CGRect?

    init() {
        self.metadata = Metadata(name: "Circle")
    }
    
    func draw() {
        guard let rect = self.rect else { return }
        let path = UIBezierPath(ovalIn: rect)
        path.stroke()
    }
}



