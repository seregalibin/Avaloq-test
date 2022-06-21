//
//  BeerGaleryPresenter.swift
//  Avaloq-Libin_DevTest
//
//  Created by Sergey Libin on 09.06.2022.
//

import Foundation

protocol BeerGaleryPresenterProtocol: AnyObject {
    func viewLoaded()
    func loadNextPage()
    func reloadData()
}

final class BeerGaleryPresenter {
    private weak var view: BeerGaleryViewControllerProtocol!
    private var coordinator: MainFlowCoordinatorProtocol
    private let provider: ServiceProvider<BeerService>
    
    private let beersNumberPerPage = 20
    private var currentPage = 0
    private var beerModels: [BeerModel] = []
    
    // MARK: Init
    init(view: BeerGaleryViewControllerProtocol, coordinator: MainFlowCoordinatorProtocol, provider: ServiceProvider<BeerService>) {
        self.view = view
        self.coordinator = coordinator
        self.provider = provider
    }
}

private extension BeerGaleryPresenter {
    func getBeers(page: Int) {
        provider.load(service: .beers(page: page, number: beersNumberPerPage), decodeType: [BeerModel].self)
        { [weak self] result in
            switch result {
            case .success(let resp):
                self?.currentPage = page
                self?.update(data: resp)
            case .failure(let error):
                self?.view?.showError(message: error.localizedDescription, completion: { [weak self] in
                    self?.getBeers(page: page)
                })
            case .empty:
                self?.view?.showError(message: "No data", completion: { [weak self] in
                    self?.getBeers(page: page)
                })
            }
        }
    }
    
    func update(data: [BeerModel]) {
        beerModels.append(contentsOf: data)
        view.updateData(data: beerModels)
    }
}

// MARK: - BeerGaleryPresenterProtocol
extension BeerGaleryPresenter: BeerGaleryPresenterProtocol {
    func viewLoaded() {
        getBeers(page: 1)
    }
    
    func loadNextPage() {
        getBeers(page: currentPage + 1)
    }
    
    func reloadData() {
        beerModels = []
        getBeers(page: 1)
    }
}
