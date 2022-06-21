//
//  MainFlowCoordinator.swift
//  Avaloq-Libin_DevTest
//
//  Created by Sergey Libin on 09.06.2022.
//

import UIKit

protocol MainFlowCoordinatorProtocol {
    
}

class MainFlowCoordinator: Coordinator, MainFlowCoordinatorProtocol {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BeerGaleryViewController()
        let provider = ServiceProvider<BeerService>()
        let presenter =  BeerGaleryPresenter(view: vc, coordinator: self, provider: provider)
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: false)
    }
}
