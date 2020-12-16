//
//  ScheduleListViewController.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/08/31.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit
import NCMB
import FSCalendar

class ScheduleListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var scheduleTableView : UITableView!

    //タップした日付を入れる変数(初期値は今日)
       var selectedDate = Date()

    var scheduleArray = [NCMBObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(scheduleArray)
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self

     
        
        let nib = UINib(nibName: "ScheduleTableViewCell", bundle: Bundle.main)
        scheduleTableView.register(nib, forCellReuseIdentifier: "Cell")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scheduleTableView.dequeueReusableCell(withIdentifier: "Cell") as! ScheduleTableViewCell
            cell.textLabel?.text = scheduleArray[indexPath.row].object(forKey: "schedule") as? String
            

            return cell

            
        
        
    }
    
    
    func loadData(){
        let query = NCMBQuery(className: "Schedule")
       
        query?.whereKey("userId", equalTo: UserDefaults.standard.object(forKey: "userId"))
        
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print("error")
                }else{
                print(result)
            
                self.scheduleTableView.reloadData()
            }
        })

    }

}


