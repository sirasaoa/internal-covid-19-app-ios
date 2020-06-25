//
//  DIstrictInfoViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/23/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class DistrictInfoViewController: BaseViewController {
    
    @IBOutlet weak var labelStateName: UILabel!
    @IBOutlet weak var tableViewDistrictData: UITableView!

    
    var stateData: IndiaHistoryModel.DayWiseData.Region?
    var viewModelDistrict: DistrictViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBar()
        viewModelDistrict = DistrictViewModel()
        viewModelDistrict?.getAllDIctrictsData(completion: { (success) in
            if(success){
                DispatchQueue.main.async {
                    self.tableViewDistrictData.reloadData()
                }
            }
        })
        self.labelStateName.text = self.stateData?.loc ?? "--"
    }
    
    func updateNavigationBar(){
        self.navigationItem.title = "State Details"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension DistrictInfoViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       switch indexPath.section {
       case 0:
           if let parentCountCell = tableView.dequeueReusableCell(withIdentifier: "TotalCountTableViewCell", for: indexPath) as? TotalCountTableViewCell{
               if let object = self.stateData {
                parentCountCell.configureCell(objectReceived: object)
               }
               return parentCountCell
           }
           return UITableViewCell()
       case 1:
           if let graphCell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as? GraphTableViewCell{
            if let _stateData = self.stateData{
                graphCell.configureCell(objectReceived: _stateData)

            }
            return graphCell
           }
           return UITableViewCell()
       default:
           if let childCountCell = tableView.dequeueReusableCell(withIdentifier: "ChildCountTableViewCell", for: indexPath) as? ChildCountTableViewCell{
            if let viewModel = self.viewModelDistrict,
                let stateName = self.stateData?.loc,
                let objectReceived = viewModel.getDistrictAtIndex(index: indexPath, forStateName: stateName){
                childCountCell.configureCell(objectReceived: objectReceived, indexPath: indexPath)
               }
               return childCountCell
           }
           return UITableViewCell()
       }
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
       switch section {
       case 0:
           return 1
       case 1:
           return 1
       default:
        if let viewModel = self.viewModelDistrict, let stateName = self.stateData?.loc {
            return   viewModel.getDistrictCount(forState: stateName)
           }
           return 0
       }
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       switch indexPath.section {
       case 0 :
           return 130
       case 1:
          return 250
       default:
          return 120
       }
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
       return 3
   }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       switch section {
       case 0:
           return 20
       case 1:
           return 30
       case 2:
           return 60
       default:
          return 0
       }
   }
   
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       switch section {
       case 0:
           let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
           headerView.backgroundColor = self.view.backgroundColor
           return headerView
       case 1:
           let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
           headerView.backgroundColor = self.view.backgroundColor
           return headerView
       case 2:
       let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
       headerView.backgroundColor = self.view.backgroundColor
       let label = UILabel()
       label.backgroundColor = tableView.backgroundColor
       label.frame = CGRect.init(x: 40, y: 10, width: headerView.frame.width-40, height: headerView.frame.height - 20 )
       label.text = "All Districts"
       label.font = UIFont.systemFont(ofSize: 20, weight: .semibold) // my custom font
       label.textColor = UIColor.white // my custom colour
       headerView.addSubview(label)
       return headerView

       default:
           let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
           headerView.backgroundColor = self.view.backgroundColor
           return headerView
       }
   }
}

extension DistrictInfoViewController: UITableViewDelegate {
    
}
