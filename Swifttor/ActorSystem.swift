//
//  ActorSystem.swift
//  Swifttor
//
//  Created by Alcala, Jose Luis on 11/17/17.
//  Copyright © 2017 Alcala, Jose Luis. All rights reserved.
//

import Foundation

public struct ActorSystem {

    fileprivate static var actors:[String:Any] = [:]

    static public func actorOfInstance<T:Actor>(_ actor:T) -> ActorRef<T> {
        return ActorRef(actor: actor)
    }

    static public func actorOf<T:Actor>(actorType:T.Type) -> ActorRef<T> {
        let key = "\(actorType)"
        let act = actorType.init()
        let actorRef:ActorRef<T>

        if let instance = actors[key] as? ActorRef<T> {
            actorRef = instance
        } else {
            let instance = ActorRef(actor: act)
            actors[key] = instance
            actorRef = instance
        }
        return actorRef
    }

}

infix operator  !:AdditionPrecedence
infix operator  !!:AdditionPrecedence

public func !<T:ActorTell>(left:ActorRef<T>, right:T.MessageType) {
    left.tell(right)
}

public func !!<T:ActorAsk>(left:ActorRef<T>, right:T.MessageType) -> Future<T.ResultType> {
    return left.ask(right)
}
