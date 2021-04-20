//
//  MainViewSwiftViewController.swift
//  Mi Telcel
//
//  Created Alejandro Jose Ramirez Vergara on 17/04/21.
//
//

import UIKit

class MainViewSwiftRouter: MainViewSwiftWireframeProtocol {
    
    weak var viewController: UIViewController?
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MainViewSwiftViewController(nibName: nil, bundle: nil) 
        let interactor = MainViewSwiftInteractor()
        let router = MainViewSwiftRouter()
        let presenter = MainViewSwiftPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
