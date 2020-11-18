//
//  CanvasViewController.swift
//  VectorEditor
//
//  Created by Alexey Kolyadenko on 18.11.2020.
//

import UIKit

class CanvasViewController: UIViewController {
    weak var delegate: CanvasViewControllerDelegate?
    
    var mode: Mode = .viewing
    
    enum Mode {
        case viewing
        case placing(Drawable)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [.init(title: "Rect", style: .plain, target: self, action: #selector(addRect(sender:))), .init(title: "Circle", style: .plain, target: self, action: #selector(addCircle(sender:)))]
        navigationItem.title = delegate?.documentName
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:))))
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        switch mode {
        case .placing(let drawable):
            let location = sender.location(in: view)
            if var circle = drawable as? Circle {
                let circleRadius: CGFloat = 50
                circle.rect = CGRect(x: location.x - circleRadius, y: location.y - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
                delegate?.addDrawable(drawable: circle)
                self.mode = .viewing
            } else if var rect = drawable as? Rectangular {
                if let _ = rect.rect {
                    let origin = rect.rect?.origin ?? .zero
                    rect.rect = CGRect(origin: rect.rect?.origin ?? .zero, size: CGSize(width: location.x - origin.x, height: location.y - origin.y))
                    delegate?.addDrawable(drawable: rect)
                    self.mode = .viewing
                } else {
                    rect.rect = CGRect(origin: location, size: .zero)
                    self.mode = .placing(rect)
                }
            }
        default:
            break
        }
    }
    
    @objc func addRect(sender: UIBarItem) {
        self.mode = .placing(Rectangular())
    }
    
    @objc func addCircle(sender: UIBarItem) {
        self.mode = .placing(Circle())
    }
    
    func redraw() {
        (view as? CanvasView)?.drawInRectBlock = { [weak self] rect in
            guard let items = self?.delegate?.items else { return }
            for item in items {
                item.draw()
            }
        }
        view.setNeedsDisplay()
    }
}

class CanvasView: UIView {
    var drawInRectBlock: ((CGRect) -> Void)?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawInRectBlock?(rect)
    }
}

protocol CanvasViewControllerDelegate: class {
    func addDrawable(drawable: Drawable)
    var documentName: String? { get }
    var items: [Drawable] { get }
}
