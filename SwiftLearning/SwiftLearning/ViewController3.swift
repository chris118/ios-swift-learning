//
//  ViewController3.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/7/26.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var numberArr = [1,8,3,6,19,32,45,46,73,23]
        
        //标准写法
        var retArr = sort_numbers(numberArr, compare: {(n1: Int, n2: Int) -> Bool in
            return n1 > n2
        })
        
        //简化 自动推断类型
        retArr = sort_numbers(numberArr, compare: {n1, n2 -> Bool in
            return n1 > n2
        })
        
        //单行可以省略return
        retArr = sort_numbers(numberArr, compare: {n1, n2 -> Bool in n1 > n2
        })
        
        //省略in 使用 $0...$n
        retArr = sort_numbers(numberArr, compare: { $0 > $1
        })
        
        //根据操作符推断
        retArr = sort_numbers(numberArr, compare: > )
        
        //Trailing
        retArr = sort_numbers(numberArr){//如果函数只有一个参数，那么可以把括号()省略掉，后面直接跟着闭包。
            $0 > $1
        }
        
        
        for n in retArr {
            println("\(n)")
        }
        
        
        
        
        // 闭包是引用类型，所以incrementByTen声明为常量也可以修改total
        let incrementByTen = increment(amount: 10)
        var ret = incrementByTen() // return 10,incrementByTen是一个闭包
        println("incrementByTen :\(ret)")
        
        // 这里是没有改变对increment的引用，所以会保存之前的值
        ret = incrementByTen() // return 20
        println("incrementByTen :\(ret)")
        
        ret = incrementByTen() // return 30
        println("incrementByTen :\(ret)")
        
        let incrementByOne = increment(amount: 1)
        ret = incrementByOne() // return 1
        println("incrementByOne :\(ret)")
        ret = incrementByOne() // return 2
        println("incrementByOne :\(ret)")
        ret = incrementByTen() // return 40
        println("incrementByTen :\(ret)")
        ret = incrementByOne() // return 3
        println("incrementByOne :\(ret)")
        
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
    
    func sort_numbers(var numbers: [Int], compare:(n1: Int, n2: Int) -> Bool) -> [Int]{
        
        for var i = 0; i < (numbers.count); i++ {
            for var j = (numbers.count - 1); j > i; j--  {
                let b = compare(n1: numbers[j], n2:numbers[j - 1])
                if(!b){
                    
                    var iTemp = numbers[j-1];
                    
                    numbers[j-1]=numbers[j];
                    
                    numbers[j]=iTemp;
                    
                }else{
                    
                    // do nothing 
                    // only for demo
          
                }
            }
        }

        
        return numbers
    }
    

    func increment(#amount: Int) -> (() -> Int) {
        var total = 0
        func incrementAmount() -> Int {
            total += amount // total是外部函数体内的变量，这里是可以捕获到的
            return total
        }
        return incrementAmount // 返回的是一个嵌套函数（闭包）
    }

}
