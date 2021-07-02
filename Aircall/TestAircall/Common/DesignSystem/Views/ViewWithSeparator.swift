//
//  SeparatorView.swift
//  TestAircall
//
//  Created by Delphine Garcia on 02/07/2021.
//

import UIKit

class ViewWithSeparator: UIView {
    
    @UsesAutoLayout var separator: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.shimmering
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCustomViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewWithSeparator {

    private func addCustomViews() {
        addSubview(separator)
        let height = Charter.Element.separator.height
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -height),
            separator.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
