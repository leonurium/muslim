// 
//  MainRouter.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit
import FloatingPanel

class MainRouter: MainPresenterToRouter {
    var presenter: MainRouterToPresenter?
    private static var mediator: AppLifecycleMediator?
    
    static func createMainModule() -> UIViewController {
        let view: UIViewController & MainPresenterToView & AppLifecycleListener = MainView()
        let presenter: MainViewToPresenter & MainInteractorToPresenter & MainRouterToPresenter = MainPresenter()
        let interactor: MainPresenterToInteractor = MainInteractor()
        let router: MainPresenterToRouter = MainRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.presenter = presenter
        
        let mediator = AppLifecycleMediator(listeners: [view])
        MainRouter.mediator = mediator
        return view
    }
    
    func navigateToInfo(from: MainPresenterToView?) {
        if let vc = from as? UIViewController {
            let nav = UINavigationController(rootViewController: AboutRouter.createAboutModule())
            vc.present(nav, animated: true, completion: nil)
        }
    }
    
    func navigateToQuran(from: MainPresenterToView?) {
        if let vc = from as? UIViewController {
            let destination = QuranRouter.createQuranModule()
            vc.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func navigateToQibla(from: MainPresenterToView?) {
        if let vc = from as? UIViewController {
            if let destination = QiblaRouter.createQiblaModule() as? QiblaView {
                let fpc = FloatingPanelController()
                fpc.delegate = self
                fpc.set(contentViewController: destination)
                fpc.track(scrollView: destination.tableView)
                fpc.isRemovalInteractionEnabled = true
                vc.present(fpc, animated: true, completion: presenter?.didShowFloatingPanel)
            }
        }
    }
    
    func navigateToPraytime(from: MainPresenterToView?) {
        if let vc = from as? UIViewController {
            if let destination = PrayerTimeTableRouter.createPrayerTimeTableModule() as? PrayerTimeTableView {
                let fpc = FloatingPanelController()
                fpc.delegate = self
                fpc.set(contentViewController: destination)
                fpc.track(scrollView: destination.tableView)
                fpc.isRemovalInteractionEnabled = true
                vc.present(fpc, animated: true, completion: presenter?.didShowFloatingPanel)
            }
        }
    }
}

extension MainRouter: FloatingPanelControllerDelegate {
    func floatingPanelDidRemove(_ fpc: FloatingPanelController) {
        presenter?.didRemoveFloatingPanel()
    }
}
