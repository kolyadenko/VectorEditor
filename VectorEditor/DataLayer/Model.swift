//
//  Model.swift
//  VectorEditor
//
//  Created by Alexey Kolyadenko on 18.11.2020.
//

import Foundation

// MARK: Document
class VectorDocument {
    var items: [Drawable] = []
}

// MARK: Drawable protocol related
protocol Drawable {
    var metadata: Metadata { get set }
}

struct Metadata {
    var name: String
    var dateUpdated: Date = Date()
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




