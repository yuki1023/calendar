//
//  AddViewController.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/08/31.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit
import NCMB
//import TransitionButton

class AddViewController: UIViewController {
    
    @IBOutlet var scheduleTextField : UITextField!
    
    @IBOutlet var dateTextField : UITextField!
   
    
    
    var passDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        
        dateTextField.text = dateToString(date: passDate, format: DateFormatter.dateFormat(fromTemplate: "ydMMM(EEE)", options: 0, locale: Locale(identifier: "ja_JP"))!)
        
        super.viewDidLoad()

       
        
        
        
        
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
        formatter.calendar = Calendar(identifier: .gregorian);        formatter.dateFormat = format;         return formatter.string(from: date)     }
    
    
    
    @IBAction func save (){
        let query = NCMBQuery(className: "Schedule")
        query?.whereKey("userId", equalTo: UserDefaults.standard.object(forKey: "userId"))
        query?.whereKey("scheduleDate", equalTo: self.dateTextField.text!)
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                //エラー
                print("error")
       

            }else{
                //データがなかった場合
                let object = NCMBObject(className: "Schedule")
                object?.setObject(self.scheduleTextField.text, forKey: "scheduleEvent")
                object?.setObject(self.dateTextField.text, forKey: "scheduleDate")
                object?.setObject(UserDefaults.standard.object(forKey: "userName"), forKey: "userName")
                object?.setObject(false, forKey: "isChecked")
                object?.saveInBackground({ (error) in
                    if error != nil{
                        //エラーが発生したら
                        print("error")
                    }else{
                        //保存に成功した場合
                        print("success")
                        let alertController = UIAlertController(title: "保存完了", message: "予定の保存が完了しました。予定表に戻ります。", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler:  { (action) in
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertController.addAction(action)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                })
                
            }
        })
        
        
        
    }
    func StringToDate(string:String,format:String)->Date{         let formatter = DateFormatter();
        formatter.calendar = Calendar(identifier: .gregorian); formatter.dateFormat = format
        return formatter.date(from: string)!              }
    
    @IBAction func back (){
        self.navigationController?.popViewController(animated: true)
    
    }
    
    
   
    
}



