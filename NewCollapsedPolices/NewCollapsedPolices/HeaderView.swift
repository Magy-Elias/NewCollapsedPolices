//
//  HeaderView.swift
//  NewCollapsedPolices
//
//  Created by Mickey Goga on 2/25/18.
//  Copyright © 2018 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit

//To notify the TableView
protocol HeaderViewDelegate: class {
    func toggleSection(header: HeaderView, section: Int)
}


class HeaderView: UITableViewHeaderFooterView {
//    var headerTitle: ResultItems? {
//        didSet {
//            titleLabel?.text = headerTitle?.subtitle
//        }
//    }
    
    var resultItem: PolicyViewModelItem? {
        didSet {
            //create the reultItem variable and use the didSet observer to set the title and the initial position of the arrow label
            guard let resultItem = resultItem else {
                return
            }
            
            titleLabel?.text = resultItem.sectionTitle
            setCollapsed(collapsed: (resultItem.isCollapsed))
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var arrowLabel: UILabel?
    
    //We will use the section variable to store the current section index
    var section: Int = 0
    
    //Add a delegate property inside the HeaderView:
    weak var delegate: HeaderViewDelegate?
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //To detect a user interaction we can set a TapGestureRecognizer in our header
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    @objc private func didTapHeader() {
        //Finally, call this delegate method from didTapHeader selector:
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setCollapsed(collapsed: Bool) {
        //When we call this method for collapsed state, it will rotate the arrow to the original position, for expanded state it will rotate the arrow to pi radians
        arrowLabel?.rotate(collapsed ? 0.0 : .pi)
    }
}

//When the user taps on the section, the arrow view should rotate down. We can achieve that with a UIView Extension
extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
}
