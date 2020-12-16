//
//  DetailViewController.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/08/31.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit
import NCMB

class DetailViewController: UIViewController {


  @IBOutlet var todoTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func save (){
        let object = NCMBObject(className: "Todo")
        object?.setObject(todoTextField.text, forKey: "text")
        object?.saveInBackground({ (error) in
            if error != nil{
                //エラーが発生したら
                print("error")
            }else{
                //保存に成功した場合
                print("success")
                let alertController = UIAlertController(title: "保存完了", message: "Todoの保存が完了しました。TodoListに戻ります。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:  { (action) in
                    self.navigationController?.popViewController(animated: true)
                     self.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
               
            }
        })
    }
}


