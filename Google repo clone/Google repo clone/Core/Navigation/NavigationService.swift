import Foundation
import SwiftUI

final class RootViewModel: ObservableObject, Identifiable {
    
    public enum Destination: Hashable {
        case profile(vm: ProfileViewModel)
        
        func hash(into hasher: inout Hasher) {
            var index = 0
            switch self {
            case .profile:
                index = 0
            }
            hasher.combine(index)
        }
        
        static func == (
            lhs: Destination,
            rhs: Destination
          ) -> Bool {
            lhs.hashValue == rhs.hashValue
          }
    }
    
    @Published var navPath = NavigationPath()
        
//    func navigate(to destination: Destination) {
//        navPath.append(destination)
//    }
//
//    func navigateBack() {
//        navPath.removeLast()
//    }
//
//    func navigateToRoot() {
//        navPath.removeLast(navPath.count)
//    }
}


extension RootViewModel : NavigationCoordinator {
    func pushAndRemoveLast(_ path: any Hashable) {
        DispatchQueue.main.async { [weak self] in
            self?.navPath.removeLast()
            self?.navPath.append(path)
        }
    }
    
    public func push(_ path: any Hashable) {
           DispatchQueue.main.async { [weak self] in
               self?.navPath.append(path)
           }
       }

       public func popLast() {
           DispatchQueue.main.async { [weak self] in
               self?.navPath.removeLast()
           }
       }
}


public protocol NavigationCoordinator {
    func push(_ path: any Hashable)
    func popLast()
    func pushAndRemoveLast(_ path: any Hashable)
}
