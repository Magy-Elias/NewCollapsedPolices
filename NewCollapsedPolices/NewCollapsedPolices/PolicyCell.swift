//
//  PolicyCell.swift
//  NewCollapsedPolices
//
//  Created by Mickey Goga on 2/22/18.
//  Copyright © 2018 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit

class PolicyCell: UITableViewCell {
    //@IBOutlet weak var inRangeLabel: UILabel?
    @IBOutlet weak var timeFromLabel: UILabel?
    @IBOutlet weak var timeToLabel: UILabel?
//    @IBOutlet weak var validFromLabel: UILabel?
//    @IBOutlet weak var validToLabel: UILabel?
    @IBOutlet weak var validFromDateLabel: UILabel?
    @IBOutlet weak var validFromTimeLabel: UILabel?
    @IBOutlet weak var validToDateLabel: UILabel?
    @IBOutlet weak var validToTimeLabel: UILabel?
    
    var policyItem: ResultItems? {
        didSet {
//            guard let resultItem = policyItem as? PolicyItem else {
//                return
//            }
            
            
//            print("In Range (kilos) : \(policyItem?.range.map { String(describing: $0) } ?? "")")
//
//            if (policyItem?.range.map {  $0 }) != 0 {
//                self.inRangeLabel?.text = "In Range (kilos) : \(self.policyItem?.range.map { String(describing: $0) } ?? "")"    //"In Range (kilos) : \(policyItem?.range ?? 0)"     //?? 0 -> to remove Optional
//            } else {
//                self.inRangeLabel?.isHidden = true
//            }
            
            timeFromLabel?.text = policyItem?.fromTime
//            print("\(String(describing: policyItem?.toTime))")
            timeToLabel?.text = policyItem?.toTime
            validFromDateLabel?.text = policyItem?.startDate
            validFromTimeLabel?.text = policyItem?.startTime
            validToDateLabel?.text = policyItem?.expirationDate
            validToTimeLabel?.text = policyItem?.expirationTime
//            validFromLabel?.text = policyItem?.startDate
//            validToLabel?.text = policyItem?.expirationDate
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
