//
//  PolicyViewModel.swift
//  NewCollapsedPolices
//
//  Created by Mickey Goga on 2/22/18.
//  Copyright © 2018 Stanislav Ostrovskiy. All rights reserved.
//

import Foundation
import UIKit

protocol PolicyViewModelItem {
    var sectionTitle: String { get }
    var rowCount: Int { get }
    
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

extension PolicyViewModelItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        return true
    }
}

class PolicyViewModel: NSObject {
    var alwaysOpenFlag: Bool = false
    
    var policyItems = [PolicyViewModelItem]()
    
    // callback to reload tableViewSections, so we can us the callback:
    var reloadSections: ((_ section: Int) -> Void)?
    
//    var results = [Result]()
    
    override init() {
        super.init()
        
//        DataService.shared.getData{
//            (data) in
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else {
//                    return
//                }
//                let json_base = JSON_Base(json: json)
//                print(json_base)
//
//                guard let results = json_base?.results else {
//                    return
//                }
////                print(results)
//                self.results = results
//            } catch {
//                print(error)
//            }
//        }
        
//        if !self.results.isEmpty {
//            let resultItem = PolicyItem(results: results)
//            policyItems.append(resultItem)
//        }
        
        
        
        guard let data = dataFromFile("ServerData"), let policies = Policies(data: data) else {
            return
        }
        let resultItems = policies.resultItems
        if !resultItems.isEmpty {
            for resultTemp in resultItems
            {
                let resultItems = PolicyItem(resultItems: resultTemp)
                if resultTemp.isAnyTime == true {
                    alwaysOpenFlag = true
                } else {
                    if resultTemp.on != nil {
                        if resultTemp.repeatInterval?.caseInsensitiveCompare("weekDays") == ComparisonResult.orderedSame {
                            resultItems.sectionTitle = "Days ("
                            for item in resultTemp.on! {
                                resultItems.sectionTitle += " \(getDays(on: item))"        //"\(resultTemp.on ?? [""])"     //\(resultTemp.on!)"
//                                print("index of item = \((resultTemp.on?.index(of: item) )!)")
//                                print ("\((resultTemp.on?.endIndex)!)")
                                if ((resultTemp.on?.endIndex)! - 1) != resultTemp.on?.index(of: item) {
                                     resultItems.sectionTitle += ", "
                                }
                            }
                             resultItems.sectionTitle += " )"
                        } else if resultTemp.repeatInterval?.caseInsensitiveCompare("monthDays") == ComparisonResult.orderedSame {
                            resultItems.sectionTitle = "Monthly ("
                            for item in resultTemp.on! {
                                resultItems.sectionTitle += " \(item)"        //"\(resultTemp.on ?? [""])"     //\(resultTemp.on!)"
//                                print("index of item = \((resultTemp.on?.index(of: item) )!)")
//                                print ("\((resultTemp.on?.endIndex)!)")
                                if ((resultTemp.on?.endIndex)! - 1) != resultTemp.on?.index(of: item) {
                                    resultItems.sectionTitle += ", "
                                }
                            }
                            resultItems.sectionTitle += " )"
                        }
                    } else {
                        if resultTemp.repeatInterval?.caseInsensitiveCompare("everyDay") == ComparisonResult.orderedSame {
                            resultItems.sectionTitle = "Daily"
                        }
                    }
                }
                print("subtitle= \(resultItems.sectionTitle)")
                policyItems.append(resultItems)
            }
            print("\(policyItems.count)")
        }
    }
    
    func getDays (on: String?) -> String {
        switch on! {
        case "sunday":
            return "Sun"
        case "monday":
            return "Mon"
        case "tuesday":
            return "Tues"
        case "wednesday":
            return "Wed"
        case "thursday":
            return "Thurs"
        case "friday":
            return "Fri"
        case "saturday":
            return "Sat"
        default:
            return ""
        }
    }
}

extension PolicyViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return policyItems.count
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let resultItem = viewModel.policyItems[section]
//        if resultItem.isCollapsible && resultItem.isCollapsed {
//            return 0
//        }
//        return resultItem.rowCount
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let resultItem = policyItems[section]
        guard resultItem.isCollapsible else {
            //When it is expanded, we will use the default rowCount for this section
            return resultItem.rowCount
        }
        if resultItem.isCollapsed {
            //when the section is collapsed, we will set its row count to zero
            return 0
        } else {
            //When it is expanded, we will use the default rowCount for this section
            return resultItem.rowCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let policyItem = policyItems[indexPath.section]
        
        if let policyItem = policyItem as? PolicyItem, let cell = tableView.dequeueReusableCell(withIdentifier: PolicyCell.identifier, for: indexPath) as? PolicyCell {
            //let result = policyItem.results[indexPath.row]
            cell.policyItem = policyItem.resultItems[indexPath.row]//policyItem.results[indexPath.row]
            return cell
        }
        return UITableViewCell()
        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//        cell.textLabel?.text = results.first?.repeatInterval
//        var count = 0
//        for item in results[indexPath.row].on {
//            if count > 0 {
//                cell.detailTextLabel?.text = "\(String(describing: cell.detailTextLabel?.text))," + "\(String(describing: item))"
//            } else {
//                cell.detailTextLabel?.text = item
//            }
//            count += 1
//        }
//        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return policyItems[section].sectionTitle
//        let policyItem = policyItems[section]
//        if let policyItem = policyItem as? PolicyItem {
//            policyItem.sectionTitle = policyItem.resultItems[section].subtitle
//        }
//        return policyItem.sectionTitle
//    }
}

//To connect HeaderView to our ViewController
extension PolicyViewModel: UITableViewDelegate {
    //Since we use a custom header, we will set a title another way
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView {
            let resultItem = policyItems[section]
            
            headerView.resultItem = resultItem
//            headerView.titleLabel?.text = resultItem.sectionTitle
            headerView.section = section
            headerView.delegate = self
            return headerView
        }
        return UIView()
    }
}

extension PolicyViewModel: HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int) {
        var resultItem = policyItems[section]
        
        if resultItem.isCollapsible {
            
            //Toggle collapse
            let collapsed = !resultItem.isCollapsed
            resultItem.isCollapsed = collapsed
            header.setCollapsed(collapsed: collapsed)
            
            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }
}

class PolicyItem: PolicyViewModelItem {
    var sectionTitle = ""
    
    var isCollapsed = true
//     sectionTitle = "Main"

    var rowCount: Int {
        return resultItems.count
    }

    var resultItems: [ResultItems]=[]

    init(resultItems: ResultItems) {
        
        self.resultItems.append (resultItems)
    }
}
