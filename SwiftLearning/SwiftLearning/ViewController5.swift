//
//  ViewController5.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/8/1.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

// 构造函数
class Fahrenheit{
    var temperature: Double
    init(){
        temperature = 32.0
    }
}

// 改进， 属性默认值
class FahrenheitEx{
    var temperature = 20.0
}

//构造器参数
class Color{
    let red = 0.0, green = 0.0, blue = 0.0
    
    init(red:Double, green: Double, blue: Double){
        self.red = red
        self.green = green
        self.blue = blue
    }
}

//可选属性类型
class Survey{
    let text: String //常量属性
    var response: String? //可选 默认是空
    
    init(text:String){
        self.text = text  //常量属性的修改,只能在构造的时候修改
        //对类实例来说,它的常量属性只能在定义它的类的构造过程中修改;不能在子类中修改
    }
    
    func Ask() -> String{
        println(text)
        return text
    }
}

// 默认构造器
class ShoppingListItem{
    var name: String? // 默认是空
    var quantity = 2
    var purchased = true
}

//结构体的默认逐一构造器
struct Size{
    var width = 0.0, height = 0.0
}

//指定构造器和便利构造器实战
class Food{
    var name:String
    
    init(name: String){
        self.name = name
    }
    
    convenience init(){
        self.init(name: "unnamed")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int){
        self.quantity = quantity
        super.init(name: name)
    }
    
    convenience override init(name: String){
        self.init(name: name, quantity: 0)
    }
}

class ShoppingItem: RecipeIngredient {
    var purchased: Bool = false
    
    var description: String{
    
        var output: String = "\(quantity) x \(name)"
        output += purchased ? " yes" : " no"
        return output
    }
}

//通过闭包和函数来设置属性的默认值
class blockDefault{

    var someValue: String = {
        
        var v = "hello"
        return v
    }()
}

// deinit
class Player{
    deinit{
       println("deinit invoke")
    }
}

class ViewController5: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        constructFunc();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func constructFunc(){
        var f = Fahrenheit()
        println("F is \(f.temperature)")
        
        var f1 = FahrenheitEx()
        println("F is \(f1.temperature)")
        
        var c = Color(red: 233, green: 123, blue: 212)
        println("Color value: red = \(c.red) green = \(c.green) blue = \(c.blue)")
        
        var s = Survey(text: "do you like cheese ?")
        s.Ask()
        s.response = "YES"
        println(s.response!)
        
        var item = ShoppingListItem();
        println("item : quantity \(item.quantity)")
        
        var size = Size(width: 5, height: 6)
        println("size, width \(size.width)  height \(size.height)")
        
        
        var d = Food(name: "Beaf")
        println("Food name is \(d.name)")
        var d1 = Food()
        println("Food name is \(d1.name)")
        
        /*
        调用顺序
        1 Food －> convenience init()
        2 RecipeIngredient  -> convenience override init(name: String)
        3 RecipeIngredient  -> init(name: String, quantity: Int)
        4 Food －> init(name: String)
        
        "Food name is unnamed  quantity is 0"
        
        */
        var recipe = RecipeIngredient();
        println("Food name is \(recipe.name)  quantity is \(recipe.quantity)")
        
        /*
        调用顺序
     
        1 RecipeIngredient  -> convenience override init(name: String)
        2 RecipeIngredient  -> init(name: String, quantity: Int)
        3 Food －> init(name: String)
        
        "Food name is rice  quantity is 0"
        
        */
        var recipe_1 = RecipeIngredient(name: "rice")
        println("Food name is \(recipe_1.name)  quantity is \(recipe_1.quantity)")
        
        /*
        调用顺序
        
        1 RecipeIngredient  -> init(name: String, quantity: Int)
        2 Food －> init(name: String)
        
        "Food name is apple  quantity is 5"
        
        */
        var recipe_2 = RecipeIngredient(name: "apple", quantity:5)
        println("Food name is \(recipe_2.name)  quantity is \(recipe_2.quantity)")
        
        

        
        var breakfastList = [
            ShoppingItem(),
            ShoppingItem(name: "Bacon"),
            ShoppingItem(name: "Eggs", quantity: 6)
        ]
        for item in breakfastList{
                println(item.description)
        }
        breakfastList[0].name = "origne"
        breakfastList[0].quantity = 6
        breakfastList[0].purchased = true
        println(breakfastList[0].description)
        
        
        var b = blockDefault();
        println(b.someValue)
        
        
        //deinit 
        var p: Player? = Player()
        p = nil // deini invoke
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
