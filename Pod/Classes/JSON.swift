//
//  JSON.swift
//  Pods
//
//  Created by Marcus Kida on 17/03/2016.
//
//

import Foundation

struct JSON {
    let game: Mapable
    
    func serialize() -> String? {
        guard let s = serialize(game, mapped: [String: Mapable]()) else {
            print("Serializing went wrong")
            return nil
        }
        guard let si = serialize(s) else { return nil }
        guard let data = try? NSJSONSerialization.dataWithJSONObject(si,
            options: NSJSONWritingOptions(rawValue: 0)) else {
            return nil
        }
        return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
    }
    
    private func serialize(mapables: [String: Mapable]) -> String? {
        fatalError("Not yet implemented")
    }
    
    private func serialize(object: Mapable, mapped: [String: Mapable]) -> [String: Mapable]? {
        
        let mapables = object.map().filter { key, value in
            return value.self is Mapable
        }
        
        for mapable in mapables {
            return serialize(mapable.1 as! Mapable, mapped: mapped)
        }
        
        return mapped
    }
}