import Foundation
import SwiftUI

struct BaseView<Content: View> : View {
    var mainContent: Content;
    
    @Binding var mainLoadingStatus: Bool;
    @Binding var hasError: Bool;
    @Binding var errorMessage: String?;
    
    var onAppear: () -> Void;
    
    var body: some View {
        ZStack {
            mainContent
            if mainLoadingStatus {
                LoadingOverlay()
                    .transition(.opacity)
                    .zIndex(1)
            }
            
            if hasError {
                CustomDialogView(
                    isPresented: $hasError, message: errorMessage)
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .onAppear(perform: {
            onAppear();
        })
    }
}
