//
//  MainViewSwiftViewController.swift
//  Mi Telcel
//
//  Created Alejandro Jose Ramirez Vergara on 17/04/21.
//
//

import UIKit

class MainViewSwiftPresenter: MainViewSwiftPresenterProtocol {

    weak private var view: MainViewSwiftViewProtocol?
    var interactor: MainViewSwiftInteractorProtocol?
    private let router: MainViewSwiftWireframeProtocol

    init(interface: MainViewSwiftViewProtocol, interactor: MainViewSwiftInteractorProtocol?, router: MainViewSwiftWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    ///Protocol to call service
    func callService(with option: Int) {
        interactor?.callService(with: option)
    }
    ///Protocol to set nit views
    func initView() {
        view?.initRates()
        view?.initView()
    }
    ///Protocol to show graphcs
    func showGrafic(with data: NSMutableDictionary) {
        view?.initRates()
        view?.deleteSubviews()
        view?.showGrafic(with: data)
    }
    ///Protocol to check actual date
    func checkDate() {
        view?.checkDate()
    }
}
