import Foundation

class BaseViewModel : ObservableObject {
    @Published var mainLoadingStatus = false
    @Published var hasError = false
    @Published var errorMessage: String? = nil
}
