//
//  ViewController4.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/7/26.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

struct FixLengthRange {
    var firstValue: Int
    let length: Int
}

class DataImporter {
    var filename = "data.txt"
}

class DataManager{
    //延迟加载
    lazy var importer = DataImporter();
    var data = [String]()
}

//计算属性
class CalProperty{
    
    var mWidth: Int = 0

    var width: Int{
    
        get{
            return mWidth
        }
        set{
            mWidth = newValue
        }
    }
}

//计算属性
class ReadOnlyCalProperty{
    
    var mWidth: Int = 0
    
    var width: Int{
        
        get{
            return mWidth
        }
    }
}

class SpyProperty{
    var count: Int = 0{
        willSet{
            println("will step invoke and value is: \(newValue)")
        }
        didSet{
            println("did step invoke and value is: \(oldValue)")
        }
    }
}

//类型属性
var value = 0;
class ClassProperty{
    class var counter: Int{
        set{
            println("ClassProperty set")
            value = newValue
        }
        get{
            println("ClassProperty get")
            return value
        }
    }
}

class ViewController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ClassAndStruct();
        
        PropertyFunc();
        
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
    
    func ClassAndStruct(){
        //struct 和基本类型一样 是值类型， 枚举也是值类型
        let hd = Resolution(width:1920, height:1080)
        var four_k = hd
        four_k.width = 3840
        
        println("cinema width:  \(hd.width)")
        println("cinema_copy width:  \(four_k.width)")
        
        
        // 类是 引用类型
        let hd_vm = VideoMode();
        hd_vm.frameRate = 25
        
        let hd_vm_copy = hd_vm
        hd_vm_copy.frameRate = 30
        
        println("hd_vm frameRate:  \(hd_vm.frameRate)")
        println("hd_vm_copy frameRate:  \(hd_vm_copy.frameRate)")
        
        // === 是否引用同一个实例
        if hd_vm === hd_vm_copy {
            println("hd_vm === hd_vm_copy")
        }
        
        
        // 字典的值拷贝
        var dict = ["Peter": 23, "Ketty": 18]
        var dict_copy = dict
        dict_copy["Peter"] = 55
        
        println(dict["Peter"]!)
        println(dict_copy["Peter"])
        
        var a=[1,2,3]
        var b = a
        var c = a
        
        println(a[0])
        println(b[0])
        println(c[0])
        println("---------")
        
        a[0] = 25
        
        println(a[0])
        println(b[0])
        println(c[0])
        println("---------")
    }
    
    func PropertyFunc(){
        
        //存储属性
        var structVar = FixLengthRange(firstValue: 10, length: 5)
        structVar.firstValue = 15
        //structVar.length = 3 // error
        
        let structConst = FixLengthRange(firstValue: 10, length: 5)
        structVar.firstValue = 15
        //structVar.length = 3 // error
        
        // lazy 演示
        var manager = DataManager()
        manager.data += ["hello"]
        manager.data += ["world"]
        for s in manager.data{
            println("\(s)")
        }
        // 这个时候importer还没有加载，只有当使用这个属性的时候才开始加载
        
        
        
        
        
        //计算属性 带有get set的属性
        var calObj = CalProperty();
        calObj.width = 1;
        println("calculate property value: \(calObj.width)")
        
        //只读计算属性
        var readonlyP = ReadOnlyCalProperty();
        //readonlyP.width = 20   // error
        println("read only property value: \(readonlyP.width)")
        
        
        
        
        //监视器属性
        //注意:不需要为无法重载的计算属性添加属性监视器,因为可以通过 setter 直接监控和响 应值的变化。
        var spyPropertyObj = SpyProperty();
        
        spyPropertyObj.count = 0
         spyPropertyObj.count = 10
        /*

        will step invoke and value is: 0
        did step invoke and value is: 0
        will step invoke and value is: 10
        did step invoke and value is: 0
        */
        
        
        
        //类型属性
        ClassProperty.counter = 10
        println("ClassProperty Value: \(ClassProperty.counter)")
        
    }

}
