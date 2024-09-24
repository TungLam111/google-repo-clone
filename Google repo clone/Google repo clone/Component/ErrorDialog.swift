import Foundation
import SwiftUI

struct CustomDialogView: View {
    @Binding var isPresented: Bool
    var message: String?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background to handle tap to close
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                
                VStack(spacing: 20) {
                    Text("Something went wrong")
                    
                    Divider()
                    if (message != nil) {
                        Text(message!)
                            .font(.title2)
                            .frame(alignment: .center)
                    }
                }
                .padding()
                .background(Color.white) // Set your desired background color here
                .cornerRadius(20)
                .shadow(radius: 10)
                .frame(width: geometry.size.width * 0.8)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            }
        }
    }
}
