//
//  ViewController.swift
//  TableViewWithMultipleCellTypes
//
//  Created by Stanislav Ostrovskiy on 4/25/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?

    fileprivate let viewModel = PolicyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel.alwaysOpenFlag == true {
            tableView?.isHidden = true
        } else {
            //In ViewController we to use this callback to reload the tableView sections:
            viewModel.reloadSections = { [weak self] (section: Int) in
                self?.tableView?.beginUpdates()
                self?.tableView?.reloadSections([section], with: .fade)
                self?.tableView?.endUpdates()
            }
            
            tableView?.estimatedRowHeight = 100
            tableView?.rowHeight = UITableViewAutomaticDimension
            tableView?.sectionHeaderHeight = 70
            tableView?.separatorStyle = .none
            
            tableView?.dataSource = viewModel
            tableView?.delegate = viewModel
            
            //For dequeueReusableHeaderFooterView to work, don’t forget to register headerView for the tableView
            tableView?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
            tableView?.register(PolicyCell.nib, forCellReuseIdentifier: PolicyCell.identifier)
        }
        
        
//        tableView?.register(AboutCell.nib, forCellReuseIdentifier: AboutCell.identifier)
//        tableView?.register(NamePictureCell.nib, forCellReuseIdentifier: NamePictureCell.identifier)
//        tableView?.register(FriendCell.nib, forCellReuseIdentifier: FriendCell.identifier)
//        tableView?.register(AttributeCell.nib, forCellReuseIdentifier: AttributeCell.identifier)
//        tableView?.register(EmailCell.nib, forCellReuseIdentifier: EmailCell.identifier)
    }
}
