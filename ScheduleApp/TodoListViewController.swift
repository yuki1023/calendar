//
//  TodoViewController.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/09/16.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit
import NCMB

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var todoTableView: UITableView!

     var todoArray = [NCMBObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(todoArray)
               todoTableView.delegate = self
               todoTableView.dataSource = self

               loadData()
        
      let nib = UINib(nibName: "TodoTableViewCell", bundle: Bundle.main)
      todoTableView.register(nib, forCellReuseIdentifier: "tCell")
          }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "tCell") as! TodoTableViewCell
            cell.textLabel?.text = todoArray[indexPath.row].object(forKey: "todo") as? String
            

            return cell

            
        
        
    }
    func loadData(){
        let query = NCMBQuery(className: "Todo")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print("error")
                }else{
                print(result)
                let todoData = result as! [NCMBObject]
                
                
                
                self.todoTableView.reloadData()
            }
        })

    }

}



    


