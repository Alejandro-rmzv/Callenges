//
//  MainViewSwiftViewController.swift
//  Mi Telcel
//
//  Created Alejandro Jose Ramirez Vergara on 17/04/21.
//
//

import Foundation

//MARK: Wireframe -
protocol MainViewSwiftWireframeProtocol: class {
        
}
//MARK: Presenter -
protocol MainViewSwiftPresenterProtocol: class {
    func callService(with option: Int)
    func initView()
    func showGrafic(with data: NSMutableDictionary)
    func checkDate()
}

//MARK: Interactor -
protocol MainViewSwiftInteractorProtocol: class {
    var presenter: MainViewSwiftPresenterProtocol?  { get set }
    func callService(with option: Int)
}

//MARK: View -
protocol MainViewSwiftViewProtocol: class {
    var presenter: MainViewSwiftPresenterProtocol?  { get set }
    func initView()
    func showGrafic(with data: NSMutableDictionary)
    func deleteSubviews()
    func initRates()
    func checkDate()
}
