//
//  ViewController7.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/8/4.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

class Car1{
    
    var wheels: Wheel?
}

class Wheel{
    var numbersOfWheel = 4
}

class Person_1 {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int{
        return rooms.count
    }
    
    subscript(i: Int) -> Room{
        return rooms[i]
    }
    
    func printNumbersOfRooms(){
        println("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    var name: String
    init(name: String){
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    

    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if (buildingNumber != nil) {
            return buildingNumber
        } else {
            return nil
        }
    }
}

class ViewController7: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SimpleFunc()
        
        ComplexFun()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SimpleFunc(){
    
        var car = Car1()
        
        //将导致运行时错误
        //unexpectedly found nil while unwrapping an Optional value
        //var count = car.wheels!.numbersOfWheel
        
        var count1 = car.wheels?.numbersOfWheel //自判断 不会崩溃
        println("\(count1)")  // print "nil"
        
        
        var wheels = Wheel()
        car.wheels = wheels
        
        var count2 = car.wheels?.numbersOfWheel //自判断 不会崩溃
        //自判断链接会返回 Int?类型值, 或者称作“自判断 Int”
        println("\(count2)")
    }
    
    func ComplexFun(){
        var john = Person_1()
        
        //＊＊＊＊＊以下是调用失败的演示＊＊＊＊＊＊＊
        
        //￼由于 john.residence 是空,所以这个自判断链接和之前一样失败了,但是没有运
        var count = john.residence?.numberOfRooms //int?
        println("\(count)")

        //通过自判断链接调用方法
        var retFunc: ()? = john.residence?.printNumbersOfRooms()  //()?
        println("\(retFunc)") // print nil

        //使用自判断链接调用子脚本
        var room = john.residence?[0] // room?
        var roomName = john.residence?[0].name // String?
        println("\(room)") // print nil
        println("\(roomName)") // print nil
        
        //连接多层链接 自判断
        var addr = john.residence?.address?.street  // String?
         println("\(addr)") // print nil
            
            
       //＊＊＊＊＊以下是调用成功的演示＊＊＊＊＊＊＊
        
        let johnsHouse = Residence()
        johnsHouse.rooms.append(Room(name: "Living Room"))
        johnsHouse.rooms.append(Room(name: "Kitchen"))
        john.residence = johnsHouse
        
        let johnsAddress = Address()
        johnsAddress.buildingName = "The Larches"
        johnsAddress.street = "Laurel Street"
        /*
        “!”符的在定义 address 实例时的使用(john.residence.address)。 john.residence 属性是一个自判断类型,因此你需要在它获取 address 属性之前使用!拆包
        以获得它的实际值。
            */
        john.residence!.address = johnsAddress
        
        
        
        
        count = john.residence?.numberOfRooms //int?
        println("\(count)") //Optional(2)
        
        //通过自判断链接调用方法
        retFunc = john.residence?.printNumbersOfRooms()  //()?
        println("\(retFunc)") // Optional(())

        //使用自判断链接调用子脚本
        room = john.residence?[0] // room?
        roomName = john.residence?[0].name // String?
        println("\(room)") // Optional(SwiftLearning.Room)
        println("\(roomName)") // Optional("Living Room")


        //连接多层链接 自判断
        addr = john.residence?.address?.street  // String?
        println("\(addr)") // Optional("Laurel Street")
        
        
        let buildingIdentifier = john.residence?.address?.buildingIdentifier() //String?
        println("\(buildingIdentifier)") //Optional("The Larches")

        let upper = john.residence?.address?.buildingIdentifier()?.uppercaseString // String?
        println("\(upper)") //Optional("THE LARCHES")
    }




}
