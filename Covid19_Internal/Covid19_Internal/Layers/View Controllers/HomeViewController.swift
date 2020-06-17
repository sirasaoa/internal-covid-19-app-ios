//
//  HomeViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private var viewModelHomeTab:HomeTabViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelHomeTab = HomeTabViewModel();
        
        viewModelHomeTab?.getWorldData(completion: { (success) in
            if(success){
                // refresh tableview
                
            }
        })
        
        viewModelHomeTab?.getCountriesData(completion: { (success) in
            if(success){
            // refresh tableview
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
