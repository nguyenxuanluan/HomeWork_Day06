//
//  DataBaseManager.swift
//  HomeWork_Day06
//
//  Created by LuanNX on 1/16/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import Foundation
import UIKit
class DataBaseManager {
    static let destinationPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/pokemon.db"
    func initDatabase() -> FMDatabase?{
        guard let database = FMDatabase(path: DataBaseManager.destinationPath) else {
            print("unable to create database")
            return nil
        }
        
        guard database.open() else {
            print("Unable to open database")
            return nil
        }
        return database
    }
    static func copyDatabase(){
        //create path
        let database = Bundle.main.path(forResource: "pokemon", ofType: "db")
        // create destination path
        let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        let destinationPath = libraryPath + "/pokemon.db"
        //Copy
        if(!FileManager.default.fileExists(atPath: destinationPath)){
            try! FileManager.default.copyItem(atPath: database!, toPath: destinationPath)
            print("Copy successful!")
        }
    }
    func getPokemonById(id: Int) -> (name: String,tag: String, img:String,color:String){
         let database = initDatabase()
        var name:String = ""
        var tag:String = ""
        var img:String = ""
        var color:String = ""
        

            let rs = try! database!.executeQuery("select * from pokemon where id = (?)", values: [id])
            while rs.next() {
                name = rs.string(forColumn: "name")
                tag = rs.string(forColumn: "tag")
                img = rs.string(forColumn: "img")
                color = rs.string(forColumn: "color")
            }
        
        return(name,tag,img,color)
    }
}
