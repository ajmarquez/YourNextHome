//
//  ListViewController.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation
import UIKit
import Combine

protocol ListViewDelegate {
    func didSelectItem()
    func reloadListData()
}


class ListViewController: UIViewController {
    
    @Published private(set) var item: [RealState] = []
    private var cancellables: Set<AnyCancellable> = Set()
    var listDelegate: ListViewDelegate!
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
        requestList()
    }
    
    func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //TODO: Approach not working as it should. find the right way to integrate Combine
    func requestList() {
        let api = HomegateAPI()
        api.loadRealStates()
            .replaceError(with: RealStateResponse.default)
            .sink(receiveValue: { result in
                print(result)
            })
            .store(in: &cancellables)
    }
//
//    func requestList() {
//        URLSession.shared.dataTask(with: URLRequest(url: URL(string: Endpoint.realStateList.url.absoluteString)!)) {
//            data, response, error in
//
//            if let data = data {
//                let jsonDecoder = JSONDecoder()
//                do {
//                    let parsedJson = try jsonDecoder.decode(NetworkResponse<[RealState]>.self, from: data)
//                    print(parsedJson.items)
//                } catch {
//                    print(error)
//
//
//                }
//            }
//        }.resume()
//    }
    
}
