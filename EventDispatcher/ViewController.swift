//
//  ViewController.swift
//  EventDispatcher
//
//  Created by Damien on 16/11/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dispatcher = Dispatcher()
        let object1 = Listenner("object1")
        let object2 = Listenner("object2")
        let object3 = Listenner("object3")

        dispatcher.listen(object1, event: .accountExpired)
        dispatcher.listen(object2, event: .beginLogin)
        dispatcher.listen(object3, event: .beginLogin)

        dispatcher.post(event: .beginLogin)
        dispatcher.post(event: .accountExpired)

        dispatcher.stopListening(forEvent: .beginLogin, listener: object2)
        dispatcher.stopListening(forEvent: .accountExpired, listener: object1)
        // Do any additional setup after loading the view.
    }


}

