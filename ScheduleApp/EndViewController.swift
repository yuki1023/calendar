//
//  EndViewController.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/10/02.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit
import NCMB
//import TransitionButton

class EndViewController: UIViewController   {
    
    
    @IBOutlet var dateTextField : UITextField!
    @IBOutlet var percentageLabel: UILabel!
    @IBOutlet var saruView: UIImageView!
    @IBOutlet var commentLabel: UILabel!
//    @IBOutlet var shadow3Button: UIButton!
//    @IBOutlet var shadow4Button: UIButton!
    @IBOutlet var backgroundTableView: UITableView!
    
    var passDate = Date()
    var isChecked = false
    var isCheckedArray = [Bool]()
    var scheduleArray = [NCMBObject]()
    var trueScheduleArray = [NCMBObject]()
    var human1Image = UIImage(named: "IMG_3261.JPG")
    var human2Image = UIImage(named: "IMG_3260.JPG")
    var human3Image = UIImage(named: "IMG_3259.JPG")
    var human4Image = UIImage(named: "IMG_3258.JPG")
    var human5Image = UIImage(named: "IMG_3257.JPG")
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateTextField.text = dateToString(date: passDate, format: DateFormatter.dateFormat(fromTemplate: "ydMMM(EEE)", options: 0, locale: Locale(identifier: "ja_JP"))!)
        
        loadData()
        
        super.viewDidLoad()
        
        // make UIImageView instance
        var imageView = UIImageView(frame: CGRect (x: 0, y: 0, width: self.backgroundTableView.frame.width,height: self.backgroundTableView.frame.height))
        // read image
        let image = UIImage(named: "forest.jpg")
        // set image to ImageView
        imageView.image = image
        // set alpha value of imageView
        imageView.alpha = 0.5
        // set imageView to backgroundView of TableView
        self.backgroundTableView.backgroundView = imageView
        
      backgroundTableView.tableFooterView = UIView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 色
        let greenColor = UIColor(red: 24.0/255.0, green: 225.0/255.0, blue: 144.0/255.0, alpha:1)
        let whiteColor = UIColor(red: 236.0/255.0, green: 254.0/255.0, blue: 234.0/255.0, alpha:1)
        let redColor = UIColor.red
        
        // ① ナビゲーションバーの背景色
        self.navigationController?.navigationBar.barTintColor = greenColor
        
        // ② ナビゲーションバーのタイトルの色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: whiteColor]
        
        // ③ ナビゲーションバー上のアイテムの色
        self.navigationController?.navigationBar.tintColor = redColor
    }
    
    
    
    
    func dateToString(date:Date,format:String)->String{
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian);        formatter.dateFormat = format;         return formatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isCheckedArray.count
    }
    
    
    
    
    func loadData(){
        let query = NCMBQuery(className: "Schedule")
        let dateString = dateToString(date: passDate, format: DateFormatter.dateFormat(fromTemplate: "ydMMM(EEE)", options: 0, locale: Locale(identifier: "ja_JP"))!)
        print(dateString)
        
        query?.addAscendingOrder("createDate")
        query?.whereKey("userName", equalTo: UserDefaults.standard.object(forKey: "userName"))
        query?.whereKey("scheduleDate", equalTo: dateString)
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print("error")
            }else{
                print(result)
                
                let schedule = result as! [NCMBObject]
                
                for i in schedule{
                    
                    if i.object(forKey: "isChecked") as! Bool == true{
                        
                        self.trueScheduleArray.append(i)
                        
                    }
                    
                    self.scheduleArray.append(i)
                    
                    
                    print(self.scheduleArray.count)
                    print(self.trueScheduleArray.count)
                    
                }
                
                
            }
        })
        
        
    }
    
    @IBAction func back (){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func calculate(){
        let scheduleCount = scheduleArray.count
        let trueScheduleCount = trueScheduleArray.count
        
        if scheduleCount != 0{
            
            let percent = trueScheduleCount * 100
            print(percent)
            let percent2 = percent/scheduleCount
            print(percent2)
            var str = String(percent2)
            percentageLabel.text = str
            
            
            
            if percent2 >= 80 {
                saruView.image = human1Image
                commentLabel.text = "人間！めっちゃ頑張ったね！！"
            } else if percent2 >= 60{
                saruView.image = human2Image
                commentLabel.text = "もう少しで人間だったね。"
            } else if percent2 >= 40{
                saruView.image = human3Image
                commentLabel.text = "お話しできるようになろ！！"
            } else if percent2 >= 20{
                saruView.image = human4Image
                commentLabel.text = "明日は服着たいよね。"
            }else   {
                saruView.image = human5Image
                commentLabel.text = "狩りに出よ？？"
            }
            
        }else{
           
          
            
            let alertController = UIAlertController(title: "猿以下です。", message: "やることぐらい決めよう！！", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:  { (action) in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
        
        
        
        
        
    }
    
    
    
}









