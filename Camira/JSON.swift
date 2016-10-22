//
//  JSON.swift
//  Pods
//
//  Created by Marcus Kida on 17/03/2016.
//
//

import Foundation

typealias Mapped = [String: Any]

struct JSON {
    let game: Mapable
}

//MARK: Serialization
extension JSON {
    func serialize() -> String? {
        guard let f = finalize(mapped: serialize(parent: nil, object: game)) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: f,
            options: JSONSerialization.WritingOptions(rawValue: 0)) else {
                return nil
        }
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String
    }
    
    private func finalize(mapped: [Mapped]) -> String? {
        print("Mapped -> \(mapped)")
        return NSString(
            data: try! JSONSerialization.data(withJSONObject: mapped, options: JSONSerialization.WritingOptions(rawValue: 0)),
            encoding: String.Encoding.utf8.rawValue
        ) as? String
    }
    
    private func serialize(parent: Mapable?, object: Mapable, mappeds: [Mapped] = [Mapped]()) -> [Mapped] {
        var mutableMappeds = mappeds
        
        var mapped = Mapped()
        mapped["_class"] = "\(object.self)"
        
        if let p = parent {
            mapped["_parent"] = "\(p.map()["uuid"])"
        }
        
        object.map().forEach { key, value in
            if !(value.self is Mapable) {
                mapped[key] = "\(value)"
            }
        }
        
        let mapables = object.map().filter { key, value in
            return value.self is Mapable
        }
        
        mutableMappeds.append(mapped)
        
        mapables.forEach { key, value in
            let s = serialize(parent: object, object: value as! Mapable, mappeds: mappeds)
            print("obj -> \(s)")
            mutableMappeds.append(contentsOf:
                [s.last!]
            )
        }
        
        return mappeds
    }
}
