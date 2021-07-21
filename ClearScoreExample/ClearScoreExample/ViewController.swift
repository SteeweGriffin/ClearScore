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
        
        let baseURL = URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com")!
        let path = "/prod/mockcredit/values"
        let endpoint = Endpoint(baseURL: baseURL, path: path, parameters: nil, method: .get)
        
        subscriptions.forEach { $0.cancel() }
        NetworkClient().request(endPoint: endpoint)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { response in
                let mapper = UserMapper()
                let user = mapper.map(body: response.payload)
                print(user)
            }.store(in: &subscriptions)

    }


}

