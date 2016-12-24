//
//  ViewController.swift
//  SQliteLearning
//
//  Created by Shi Feng on 2016/12/7.
//  Copyright © 2016年 Shi Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var db:SQLiteDB!
    
    @IBOutlet weak var textUserName:UITextField!
    @IBOutlet weak var textPhoneNum:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //print("Documents路径为: \(documentsDirectory())")
        
        //获取数据库实例
        db = SQLiteDB.sharedInstance
        //如果表不存在则创建表(其中uid为自增主键)
        let result = db.execute(sql: "create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        print("Result: \(result)")
        //如果有数据就加载
        initUser()
        
    }
    
    @IBAction func saveUserData(_ sender: AnyObject) {
        saveUser()
    }
    
    @IBAction func deleteTheFirstRowInDataBase(_ sender: AnyObject) {
        deleteUser()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //从SQLite加载数据
    func initUser() {
        let data = db.query(sql: "select * from t_user")
        if data.count > 0 {
            //获取最后一行数据
            let user = data[data.count - 1]
            textUserName.text = user["uname"] as? String
            textPhoneNum.text = user["mobile"] as? String
        }
    }

    //保存数据到SQLite
    func saveUser() {
        let uname = self.textUserName.text!
        let mobile = self.textPhoneNum.text!
        //插入数据库
        let sql = "insert into t_user(uname,mobile) values('\(uname)','\(mobile)')"
        print("sql \(sql)")
        let result = db.execute(sql: sql)
        print("Result \(result)")
    }
    
    //删除数据库所有数据但保留表的结构
    func deleteUser() {
        let result = db.execute(sql: "delete from t_user") //删除
        print("删除结果: \(result)")
    }
    
    //测试数据库数据
    @IBAction func debugDataBase(_ sender: AnyObject) {
        let date = db.query(sql: "select uname from t_user where mobile = '13947451986'")
        print(date)
    }
    
    
    /*
    //获取文件路径
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }*/

}

