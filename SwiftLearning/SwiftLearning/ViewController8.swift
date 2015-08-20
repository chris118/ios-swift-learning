//
//  ViewController8.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/8/5.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

class MediaItem{
    var name: String
    init(name: String){
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
    self.director = director
    super.init(name: name)
    }
}
class Song: MediaItem {
        var artist: String
        init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
        }
}

class ViewController8: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    
        basicFunc()
        
        AnyAnyObjectFunc()
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
    
    
    func basicFunc(){
    
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        
        //检查类型 is
        var movieCount = 0
        var songCount = 0
        
        for item in library {
            
            println("\(item)")
            
            if item is Movie {
                ++movieCount
            } else if item is Song{
                ++songCount
            }
        }
        
        println("Media library contains \(movieCount) movies and \(songCount) songs")
        
        
        //向下转型 as
        for item in library {
            //可选绑定是这样写的“if let movie = item as? Movie”,可以这样解读:
            //“尝试将 item 转为 Movie 类型。若成功,设置一个新的临时常量 movie 来存储返回的 optional Movie”
            if let movie = item as? Movie {
                println("Movie: '\(movie.name)', dir. \(movie.director)")
            } else if let song = item as? Song {
                println("Song: '\(song.name)', by \(song.artist)")
            }
        }
    }
    
    //Any 和 AnyObject 的转换
    func AnyAnyObjectFunc(){
        var someObjects: [AnyObject] = [
        
            Movie(name: "1", director: "Mike"),
            Movie(name: "2", director: "Jack"),
            Movie(name: "3", director: "Jone")
        ]
        
        for obj in someObjects{
            //可以使用强制形式的类型转换(as)来下转在数组中的每一项到比 AnyObject 更明确的类型,不需要可选解包(optional unwrapping)。
            let movie = obj as Movie
            println("name  \(movie.name),  director  \(movie.director)")
        }
        
        // 更简单的写法
        for obj in someObjects as [Movie]{
            println("name  \(obj.name),  director  \(obj.director)")
        }
        
        
        //Any
        
        var things = [Any]()
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        
        for thing in things {
            switch thing {
            case 0 as Int:
                println("zero as an Int")
            case 0 as Double:
                    println("zero as a Double")
            case let someInt as Int:
                println("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                println("a positive double value of \(someDouble)")
            case is Double:
                println("some other double value that I don't want to print")
            case let someString as String:
                println("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                println("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                println("a movie called '\(movie.name)', dir. \(movie.director )")
            default:
                println("something else")
            }
        }
    }
    
   
}
