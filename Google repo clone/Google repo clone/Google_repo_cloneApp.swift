import SwiftUI

@main

struct Google_repo_cloneApp: App {
    @ObservedObject var rootViewModel = RootViewModel();
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $rootViewModel.navPath) {
                ProfileView(viewModel: DependencyInjector.instance.viewModelsDI.profile(navigationCoordinator: rootViewModel))
                        .navigationDestination(for: RootViewModel.Destination.self) { destination in
                            switch destination {
                            case .profile(let vm):
                                ProfileView(viewModel: vm)
                            }
                        }
            
                
            }
        }
    }
}

