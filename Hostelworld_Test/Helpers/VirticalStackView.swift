//
//  VirticalStackView.swift

import UIKit

class VirticalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0, distribution: Distribution = .fill ) {
        super.init(frame: .zero)
        self.spacing = spacing
        self.axis = .vertical
        self.distribution = distribution
        arrangedSubviews.forEach { (view) in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
