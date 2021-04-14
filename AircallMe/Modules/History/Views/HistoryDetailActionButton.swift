//
//  HistoryDetailActionButton.swift
//  History
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit

/// Sub class of UIButton to display a specific layout button
final class HistoryDetailActionButton: UIButton {
    
    private var shadowLayer: CAShapeLayer?
    private var cornerRadius: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetUp()
    }
    
    /// Override this method to modify the layout for the title label
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)

        return CGRect(x: 0, y: imageRect.maxY,
                      width: contentRect.width, height: rect.height)
    }

    /// Override this method to modify the layout for the image
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.imageRect(forContentRect: contentRect)
        let titleRect = self.titleRect(forContentRect: contentRect)

        return CGRect(x: contentRect.width/2.0 - rect.width/2.0,
                      y: (contentRect.height - titleRect.height)/2.0 - rect.height/2.0,
                      width: rect.width, height: rect.height)
    }
    
    /// Add shadow effect after the layout update process
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Add shadow effect
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
}

extension HistoryDetailActionButton {
    
    /// Helper to initialize default button attribut
    private func initialSetUp() {
        backgroundColor = .white
        titleLabel?.textAlignment = .center
    }
}
