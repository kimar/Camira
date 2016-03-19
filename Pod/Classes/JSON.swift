//
//  JSON.swift
//  Pods
//
//  Created by Marcus Kida on 17/03/2016.
//
//

import Foundation

typealias Mapped = [String: AnyObject]

struct JSON {
    let game: Mapable
}

//MARK: Serialization
extension JSON {
    func serialize() -> String? {
        guard let f = finalize(serialize(nil, object: game)) else { return nil }
        guard let data = try? NSJSONSerialization.dataWithJSONObject(f,
            options: NSJSONWritingOptions(rawValue: 0)) else {
                return nil
        }
        return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
    }
    
    private func finalize(mapped: [Mapped]) -> String? {
        print("Mapped -> \(mapped)")
        return NSString(
            data: try! NSJSONSerialization.dataWithJSONObject(mapped, options: NSJSONWritingOptions(rawValue: 0)),
            encoding: NSUTF8StringEncoding
        ) as? String
    }
    
    private func serialize(parent: Mapable?, object: Mapable, var mappeds: [Mapped] = [Mapped]()) -> [Mapped] {
    
        var mapped = Mapped()
        mapped["_class"] = String(object.dynamicType)
        
        if let p = parent {
            mapped["_parent"] = String(p.map()["uuid"])
        }
        
        object.map().forEach { key, value in
            if !(value.self is Mapable) {
                mapped[key] = String(value)
            }
        }
        
        let mapables = object.map().filter { key, value in
            return value.self is Mapable
        }
        
        mappeds.append(mapped)
        
        mapables.forEach { key, value in
            let s = serialize(object, object: value as! Mapable, mappeds: mappeds)
            print("obj -> \(s)")
            mappeds.appendContentsOf(
                [s.last!]
            )
        }
        
        return mappeds
    }
}