//
//  Action.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation
import Gloss

public class Action: Glossy {

    let nextScene: Scene

    public let text: String
    public var selected = false

    public init(text: String, nextScene: Scene) {
        self.text = text
        self.nextScene = nextScene;
    }
    
    public required init?(json: JSON) {
        guard let nextScene: Scene = "nextScene" <~~ json else { return nil}
        guard let text: String = "text" <~~ json else { return nil }
        self.nextScene = nextScene
        self.text = text
        if let selected: Bool = "selected" <~~ json {
            self.selected = selected
        }
    }
    
    public func toJSON() -> JSON? {
        return jsonify([
            "text" ~~> text,
            "selected" ~~> selected
        ])
    }
}
