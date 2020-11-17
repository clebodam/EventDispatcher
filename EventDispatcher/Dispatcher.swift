//
//  Dispatcher.swift
//  EventDispatcher
//
//  Created by Damien on 16/11/2020.
//

import Foundation

enum Event: String {
    case beginRefreshTrips
    case endRefreshTrips
    case beginLogin
    case endLogin
    case accountExpired
    case logOut
    case beginProfileFetched
    case endProfileFetched
    case tabChanged
    case biometryChanged
}

class WeakContainer  {
    weak var _value : AnyObject?

    init (value: AnyObject) {
        _value = value
    }

    func get() -> AnyObject? {
        return _value
    }
}

protocol EventListener: class {

    func didReceivedEvent( _ event: Event)
    func stopListenningEvent( _ event: Event)
}


class Dispatcher {

    private var listeners : [Event : [WeakContainer]] =  [Event: [WeakContainer]]()
    func listen(_ observer: EventListener, event: Event) {
        if self.listeners[event] == nil {
            self.listeners[event] = [WeakContainer]()
        }
        self.listeners[event]?.append(WeakContainer(value: observer))
    }

    func post(event: Event) {
        guard let listenners = self.listeners[event] else {
            return
        }
        for listener in listenners {
            if let listener = listener.get() as? EventListener {
                listener.didReceivedEvent(event)
            }
        }
    }

    func stopListening(forEvent: Event, listener: EventListener) {
        guard let listenners = self.listeners[forEvent] else {
            return
        }
        print (" before listeners for event: \(forEvent) \( listenners.count) ")
        let newlistenners = listenners.filter {
            ($0.get() === listener) == false
        }
        self.listeners[forEvent] = newlistenners
        listener.stopListenningEvent(forEvent)
        print (" after listeners for event: \(forEvent) \( newlistenners.count) ")
    }
}
