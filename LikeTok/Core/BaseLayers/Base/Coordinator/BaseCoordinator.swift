import Foundation

// Implemntation of base coordinator
// Subclass from this base coordinator for making new flow coordinator
class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    // MARK: Coordinator protocol
    
    func start() {
        start(with: nil)
    }
    
    func start(with deepLinkOption: DeepLinkOption?) { }
    
    func removeAllChilds() {
        guard !childCoordinators.isEmpty else { return }
        
        for coordinator in childCoordinators {
            if let coordinator = coordinator as? BaseCoordinator {
                coordinator.removeAllChilds()
            }
        }
        
        childCoordinators.removeAll()
    }
    
    // MARK: Internal methods
    
    func addDependency(_ coordinator: Coordinator) {
        guard !haveDependency(coordinator) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator = coordinator
        else { return }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    // MARK: Private methods
    
    private func haveDependency(_ coordinator: Coordinator) -> Bool {
        return childCoordinators.contains { $0 === coordinator }
    }
    
}
