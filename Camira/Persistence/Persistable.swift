//
//  Persistable.swift
//  Pods
//
//  Created by Marcus Kida on 17/03/2016.
//
//

import Foundation

protocol Persistable {
    func persist() -> String?
    func restore(persisted: String)
}

protocol Mapable {
    func map() -> [String: Any]
}
