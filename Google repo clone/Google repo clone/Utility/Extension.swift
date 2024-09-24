import Foundation
import SwiftUI

class DataState<T> {
    let data: T?
    let error: ErrorException?
    
    init(data: T? = nil, error: ErrorException? = nil) {
        self.data = data
        self.error = error
    }
}

class DataSuccess<T>: DataState<T> {
    init(data: T) {
        super.init(data: data)
    }
}

class DataFailed<T>: DataState<T> {
    init(error: ErrorException, data: T? = nil) {
        super.init(data: data, error: error)
    }
}

class ErrorException {
    var errorCode: String?
    var message: String?
    
    init(errorCode: String? = nil, message: String? = nil) {
        self.errorCode = errorCode
        self.message = message
    }
}

extension DataState {
    var isSuccess: Bool {
        return self is DataSuccess<T>
    }
    
    var isError: Bool {
        return self is DataFailed<T>
    }
}

extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
