//
//  CalenderViewController.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/08/31.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit
import NCMB
import FSCalendar
import TransitionButton





class CalenderViewController: UIViewController, FSCalendarDelegate,FSCalendarDataSource,UITableViewDataSource,UITableViewDelegate, ScheduleTableViewCellDelegate {
    
    
    
    
    @IBOutlet var calender: FSCalendar!
    
    @IBOutlet var addbutton: UIButton!
    @IBOutlet var endbutton: UIButton!
    
    
    @IBOutlet var scheduleTableView : UITableView!
    
    var isChecked = false
    var isCheckedArray = [Bool]()
    var objIds = [String]()
    var users = [String]()
    var texts = [String]()
    let addImage = UIImage(named: "icons8-追加-64.png")
    let endImage = UIImage(named: "icons8-申年-48.png")
//    let button = TransitionButton (frame: CGRect(x: 160, y: 590, width: 50, height: 50))
//    (frame: CGRect(x: 160, y: 590, width: 50, height: 50))
//
    
    //タップした日付を入れる変数(初期値は今日)
    var selectedDate = Date()
    
    var scheduleArray = [NCMBObject]()
    //予定が入っている日付を格納する配列
    var scheduledDate = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FSCalendarの関数をViewControllerに委任する
        self.calender.delegate = self
        self.calender.dataSource = self
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
//        addbutton.setImage(addImage, for: .normal)
        endbutton.setImage(endImage, for: .normal)
//        
        let nib = UINib(nibName: "ScheduleTableViewCell", bundle: Bundle.main)
        scheduleTableView.register(nib, forCellReuseIdentifier: "Cell")
        
//        self.view.addSubview(button)
//
//               button.backgroundColor = .systemTeal
//               button.setTitle("!", for: .normal)
//               button.cornerRadius = 20
//               button.spinnerColor = .white
//               button.addTarget(self, action: #selector(endbuttonAction(_:)), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ScheduleTableViewCell
        cell.delegate = self
        cell.tag = indexPath.row
        
        
        //        let user = users[indexPath.row]
        let text = texts[indexPath.row]
        
        cell.scheduleNameLabel.text = text
        
        
        
        // Likeによってハートの表示を変える
        if isCheckedArray[indexPath.row] == true {
            cell.checkbutton.setImage(UIImage(named: "icons8-checkmark.png"), for: .normal)
        } else {
            cell.checkbutton.setImage(UIImage(named: "icons8-checkbox.png"), for: .normal)
        }
        return cell
    }
    
    func didTapcheckButton(tableViewCell: UITableViewCell, button: UIButton) {
        print(isCheckedArray[tableViewCell.tag])
        if isCheckedArray[tableViewCell.tag] == false || isCheckedArray[tableViewCell.tag] == nil {
            let query = NCMBQuery(className: "Schedule")
            query?.getObjectInBackground(withId: objIds[tableViewCell.tag], block: { (post, error) in
                if error != nil {
                    //                           SVProgressHUD.showError(withStatus: error!.localizedDescription)
                    print(error)
                } else {
                    print(self.objIds[tableViewCell.tag])
                    print(post)
                    //                   post?.addUniqueObject(NCMBUser.current().objectId, forKey: "likeUser")
                    post?.setObject(true, forKey: "isChecked")
                    post?.saveEventually({ (error) in
                        if error != nil {
                            print(error)
                        } else {
                            self.loadData()
                        }
                    })
                }
            })
        } else {
            let query = NCMBQuery(className: "scheduleEvent")
            query?.getObjectInBackground(withId: objIds[tableViewCell.tag], block: { (post, error) in
                if error != nil {
                    //                       SVProgressHUD.showError(withStatus: error!.localizedDescription)
                    print(error)
                } else {
                    print(post)
                    
                    post?.setObject(false, forKey: "isChecked")
                    post?.saveEventually({ (error) in
                        if error != nil {
                            print(error)
                        } else {
                            self.loadData()
                        }
                    })
                }
            })
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "toListDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdd"{
            let nextAdd = segue.destination as! AddViewController
            nextAdd.passDate = selectedDate
            
        }
        if segue.identifier == "toEnd"{
            let nextAdd = segue.destination as! EndViewController
            nextAdd.passDate = selectedDate
        }
    }
    
    
    //カレンダーの月が変更した時に呼ばれる関数
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        selectedDate =  calendar.currentPage
        loadData()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {        selectedDate = date
        //tableViewの更新
        loadData()
        
        //表示する形式をformatterで指定
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd(EEE)"
        //date型からstring型へ変換
        let selectedDate = formatter.string(from: date)
        print(selectedDate)
        
    }
    
    
    
    
    //日付の下に点をつける関数
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = dateToString(date: date, format: "yyyy/MM/dd(EEE)")
        if self.scheduledDate.contains(dateString){
            return 1
            
        }
        return 0
        
        
    }
    
    
}
extension CalenderViewController{
    //date型→String型に変換する関数
    func dateToString(date:Date,format:String)->String{
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    //String型→date型に変換する関数
    func StringToDate(string:String,format:String)->Date{
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string)!
        
    }
    
    
    func loadData(){
        let query = NCMBQuery(className: "Schedule")
        let dateString = dateToString(date: selectedDate, format: DateFormatter.dateFormat(fromTemplate: "ydMMM(EEE)", options: 0, locale: Locale(identifier: "ja_JP"))!)
        query?.addAscendingOrder("createDate")
        query?.whereKey("userName", equalTo: UserDefaults.standard.object(forKey: "userName"))
        query?.whereKey("scheduleDate", equalTo: dateString)
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print("error")
            }else{
                print(result)
                
                self.scheduleArray = result as! [NCMBObject]
                let objects = result as! [NCMBObject]
                
                self.users = [String]()
                self.texts = [String]()
                self.objIds = [String]()
                self.isCheckedArray = [Bool]()
                
                
                for object in objects{
                    
                    let text = object.object(forKey: "scheduleEvent")
                    let user = object.object(forKey: "userName")
                    print(user)
                    
                    let objId = object.objectId
                    
                    
                    // likeの状況(自分が過去にLikeしているか？)によってデータを挿入
                    let checkObject = object.object(forKey: "isChecked") as? Bool
                    print(checkObject)
                    if checkObject == true {
                        self.isChecked = true
                    } else {
                        self.isChecked = false
                    }
                    
                    self.users.append(user as! String)
                    self.texts.append(text as! String)
                    self.objIds.append(objId!)
                    self.isCheckedArray.append(self.isChecked)
                    print(self.isChecked)
                    
                }
                print(self.isCheckedArray)
                self.scheduleTableView.reloadData()
                
            }
        })
        
        
        
    }
    
    
    
    
    @IBAction func addButton (){
        self.performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
//   @IBAction func endbuttonAction(_ button: TransitionButton) {
//          button.startAnimation() // 2: Then start the animation when the user tap the button
//          let qualityOfServiceClass = DispatchQoS.QoSClass.background
//          let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
//          backgroundQueue.async(execute: {
//
//              sleep(3) // 3: Do your networking task or background work here.
//
//              DispatchQueue.main.async(execute: { () -> Void in
//                  // 4: Stop the animation, here you have three options for the `animationStyle` property:
//                  // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
//                  // .shake: when you want to reflect to the user that the task did not complete successfly
//                  // .normal
//                  button.stopAnimation(animationStyle: .expand, completion: {
//                      let secondVC = EndViewController()
//                    secondVC.passDate = self.selectedDate
//                      self.present(secondVC, animated: true, completion: nil)
//
//                  })
//              })
//          })
     
  
    }








    
    
    
    








