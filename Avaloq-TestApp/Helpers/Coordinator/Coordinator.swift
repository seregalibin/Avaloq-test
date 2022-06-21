//
//  MainCoordinator.swift
//  Avaloq-Libin_DevTest
//
//  Created by Sergey Libin on 09.06.2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
