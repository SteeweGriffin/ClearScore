//
//  ViewController.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import UIKit
import Network
import Combine

class ViewController: UIViewController {

    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background.uiColor
        title = "Dashboard"

        subscriptions.forEach { $0.cancel() }
        UserRepository().fetchUser()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { value in
                print(value)
            }.store(in: &subscriptions)

    }


}

