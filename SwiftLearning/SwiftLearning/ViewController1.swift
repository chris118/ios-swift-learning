//
//  ViewController1.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/7/22.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.LetAndVar();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func LetAndVar(){
        let maximum = 10
        //maximum = 5; //error
        var counter = 0
        var x = 0, y = 0, z = 0
        var str: String
        str = "hello"
        str = "bonjour!"
        
        println(str)
        println("demo how to print value:   \(str)")
        
        /* 这是第一个多行注释的开头
        /* 这是第二个被嵌套的多行注释 */ 
           这是第一个多行注释的结尾 */
        let cat = "????"; println(cat) // 两条语句放一行 要有分号
        
    
        let n = 32
        let h = 1.234 // h 默认成double 而不是float
        let n1 = 1_000_000 // 用下划线增加可读性
        
        println(n1)
        
//        let cannotBeNegative: UInt8 = -1 //error 不能是负数
//        let tooBig: UInt8 = UInt8.max + 1 // 超过最大值
        
        let twoThousand: UInt16 = 2000
        let one: UInt8 = 200
        let newValue = twoThousand + UInt16(one) //必须做显示转换
        
        let three = 3
        let pointOne = 0.1234
        let pi = Double(three) + pointOne  //必须做显示转换
        
        let integerPi = Int(pi)
         println(integerPi)
        
        //类型别名
        typealias AudioSample = UInt16
        var maxAmp = AudioSample.max
        
        var bDemo = true
        if bDemo{
            println("I am Boolean and is true")
        }else{
            println("I am Boolean and is false")
        }
        
        //元组 (tuples)
        let http404Error = (404, "Not Found")
        
        let (status, info) = http404Error
        
        println("status is \(status)") // 分解元组
        println("info is \(info)")
        
        let (sta, _) = http404Error
        println("sta is \(status)")
        
        println("sta is \(http404Error.0)") //下标访问
        
        let http200Status = (status: 200, description: "OK")
        println("status is \(http200Status.status)")
        
        
        // optional
        let possibleNumber = "123"
        let convertNumber = possibleNumber.toInt()
        println(convertNumber) // optional(123)
        
        
        if (convertNumber != nil){//用!来获取一个不存在的可选值会导致运行时错误。使用!来强制解析值之前,一 定要确定可选包含一个非 nil 的值。
         println("\(convertNumber) has an integer value of \(convertNumber!)") // converNumber! 取值
        }else{
         println("is not integer")
        }
        
        var optionalValue: Int? = 404
        println(optionalValue)
        optionalValue = nil
        
        let assumeString: String! = "An implicitly unwrapped optional string"
        println(assumeString) // 不需要用!
        
        if assumeString != nil{  // 用法和普通可选一样用
            println("i am implicitly optional string")
        }
        
        //断言
        let t = -3
        //assert(t >= 0, "here is error")
        
//        运算符
//        if x =y {} // error 赋值运算不返回任何值
        
        let fQiuyu = 8 % 2.5
        println(fQiuyu)
        
        for index in 1...5 {
            println(index)
        }
        
        //字符串
        var emptyString = ""
        var emptyStringEx = String()
        
        if emptyStringEx.isEmpty {
            println("string is null")
        }
        
        let str1 = "some thing here"
        println("character count is \(countElements(str1))")
        
        let normal_str = "Hello"
        let big = normal_str.uppercaseString
        let small = normal_str.lowercaseString
        println(big)
        println(small)
        
        //数组
        var stringArray: [String] = ["aaa", "bbb"]
        var simpleArr = ["aaa", "bbb"]
        println("array count is \(simpleArr.count)")
        
        simpleArr.append("cccc");
        println("array count is \(simpleArr.count)")
        
        simpleArr += ["ddd", "eeee"]
        
        println("array count is \(simpleArr.count)")
        
        for s in simpleArr{
            println(s)
        }
        
        simpleArr[2...4] = ["111", "222", "333"]
        
        for s in simpleArr{
            println(s)
        }
        
        simpleArr.insert("000", atIndex: 1)
        for s in simpleArr{
            println(s)
        }
        
        for (index, value) in enumerate(simpleArr){
            println("index : \(index), value : \(value)")
        }
        
        //空数组
        var emptyArr = [Int]()
        emptyArr.append(2);
        println("count: \(emptyArr.count)")
        
        var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
        for s in threeDoubles{
            println(s)
        }
        
        var simpleThreeDouble = Array(count: 3, repeatedValue: 0.0)
        
        
        //字典
        var person: Dictionary<String, String> = ["firstname": "dehua", "lastname":"liu"]
        var simplePerson = ["firstname": "dehua", "lastname":"liu"]
         println("count: \(simplePerson.count)")
        
        simplePerson["sex"] = "man"
        println("count: \(simplePerson.count)")
        
        simplePerson["sex"] = "woman" // not very good
        if let oldvalue = simplePerson.updateValue("animal", forKey: "sex"){ // good
            println("success to update")
        }
        
        if let p = simplePerson["firstname"]{
            println("the firstname of person is \(p)")
        }
        
        simplePerson["sex"] = nil // 移除
        println("count: \(simplePerson.count)")
        
        if let ret = simplePerson.removeValueForKey("sex"){
            println("success remove: \(ret)")
        }else{
            println("failed to remove")
        }
        
        
        for(key, value) in simplePerson{
            println("key = \(key), value = \(value)")
        }
        
        let personArray = simplePerson.keys
        for key in personArray{
            println("key = \(key)")
        }
        
        var emptyDict = Dictionary<Int, String>() //空字典声明
        emptyDict = [:] // 字典置空
        
    }

}
