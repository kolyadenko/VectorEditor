//
//  Model.swift
//  VectorEditor
//
//  Created by Alexey Kolyadenko on 18.11.2020.
//

import Foundation

// MARK: Session
class Session {
    var currentDocument: VectorDocument?
    private(set) var documentName: String
    
    // Can be extended to URI
    init(withDocumentName documentName: String = "Default Vector Document") {
        self.documentName = documentName
    }
    
    func loadDocument() {
        // TODO: Implement loading from filesystem
    }
    
    func saveDocument() {
        // TODO: Implement saving to filesystem
    }
}

// MARK: Document
class VectorDocument {
    var items: [Drawable] = []
    var metadata: Metadata
    
    init(name: String) {
        self.metadata = Metadata(name: name)
    }
}

// MARK: Drawable protocol related
protocol Drawable {
    var metadata: Metadata { get set }
}

struct Metadata {
    var name: String
    var updatedAt: Date = Date()
}

// MARK: Drawable implementation
struct Reet: Drawable {
    var metadata: Metadata
    
    init() {
        self.metadata = Metadata(name: "Reet")
    }
}

struct Circle: Drawable {
    var metadata: Metadata
    
    init() {
        self.metadata = Metadata(name: "Circle")
    }
}



