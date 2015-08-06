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

class Counter{
    var count: Int = 0
    func IncrementBy(amount: Int, times: Int){
        count = amount * times
        println("Counter value: \(count)")
    }
}

//变异方法 可以改变值类型的结构体的 成员
struct Point {
    var x=0.0,y=0.0
    
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

//类型方法
class CounterEx{

   class  func IncrementBy(amount: Int, times: Int){
        println("I am class method")
    }
}

//附属脚本
struct Matrix{
    let rows:Int, columns:Int
    var grid: [Double]
    
    init(rows: Int, columns:Int){
        self.rows = rows
        self.columns = columns
        grid = Array(count:rows*columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool{
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double{
        get{
            assert(indexIsValidForRow(row, column: column), "index out of range")
            return grid[(row*columns) + column]
        }
        set{
            assert(indexIsValidForRow(row, column: column), "index out of range")
            grid[(row*columns) + column] = newValue
        }
    }
}

//继承
class Vehicle{

    var numbersOfwheels: Int;
    var maxPassengers: Int;
    
    init(){
        numbersOfwheels = 0;
        maxPassengers = 1;
    }
    
    func description() -> String{
        return "\(numbersOfwheels) wheels: up to \(maxPassengers) passengers."
    }
    
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numbersOfwheels = 2
    }
}

class Tendem: Bicycle {
    override init() {
        super.init()
        maxPassengers = 2
    }
}

class Car: Vehicle { // 重载
    
    var speed: Int = 0
    
    override init() {
        super.init()
        numbersOfwheels = 4
        maxPassengers = 5
        speed = 50
    }
    
    override func description() -> String {
        return super.description() + ", speed is: \(speed)"
    }
}

class SpeedLimitCar: Car { //重写属性
    override var speed: Int{
        get{
            return super.speed;
        }
        set{
            super.speed = min(newValue, 40)
        }
    }
}

class AutomaticCar: Car {
    var gear: Int = 0
    override var speed: Int{
        didSet{
            gear = min(speed/10 + 1, 6)
        }
    }
    
    override init(){
        super.init()
    }
    
    override func description() -> String {
        return super.description() + " in gear : \(gear)"
    }
}

class ViewController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ClassAndStruct()
        
        PropertyFunc()
        
        subscriptFunc()
        
        inheritFunc()
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
        //只有当初始化完成以及 self 确实存在后,才能访问 lazy 属性。
        
        
        
        
        
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
        
        //方法
        var counter = Counter()
        counter.IncrementBy(5, times: 2)
            
        //Mutating
        var pt = Point()
        pt.moveByX(5, y: 5)
        println("new point: \(pt.x),\(pt.y)")
            
        // error 值类型设成常亮， 不能修改属性
//        var pt = Point()
//        pt.moveByX(5, y: 5)
            
            
            
        //类型方法
        CounterEx.IncrementBy(0, times: 0)
        
    }
    
    func subscriptFunc(){
        
        var matrix = Matrix(rows: 2, columns: 2)
        matrix[0, 1] = 2
        matrix[1, 0] = 5
        
        for n in matrix.grid{
            println("grid value: \(n)")
        }
        
    }
    
    func inheritFunc(){
        var baseVehicle = Vehicle()
        println(baseVehicle.description())
        
        var bicycle = Bicycle()
        println(bicycle.description())
        
        var tendem = Tendem()
        println(tendem.description())
        
        var car = Car()
        println(car.description())
        
        var carLimitSpeed = SpeedLimitCar()
        carLimitSpeed.speed = 100
        println(carLimitSpeed.description())
        
        var automaticCar = AutomaticCar();
        automaticCar.speed = 500
        println(automaticCar.description())
    }

}
