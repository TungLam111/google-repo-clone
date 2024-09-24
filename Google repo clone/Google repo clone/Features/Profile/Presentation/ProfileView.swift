import SwiftUI
import URLImage

struct ProfileView : View {
    @StateObject var viewModel: ProfileViewModel;
    
    var body: some View {
        BaseView(
            mainContent:  {
                ZStack (alignment: .bottom) {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            HStack (alignment: .top) {
                                if let imageUrl = URL(string: viewModel.ggProfile?.avatarURL ?? "") {
                                    URLImage(imageUrl) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                                            )
                                    }
                                }
                                
                                Spacer().frame(width: 20)
                                
                                VStack(alignment: .leading) {
                                    Text(viewModel.ggProfile?.name ?? "")
                                        .padding(.bottom, 10)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    
                                    Text(viewModel.ggProfile?.description ?? "")
                                        .font(.subheadline)
                                        .padding(.bottom, 10)
                                    
                                    HStack {
                                        Image(systemName: "person.2")
                                        Text("\(viewModel.ggProfile?.followers ?? 0) followers")
                                    }
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 10)
                                    
                                    HStack {
                                        Image(systemName: "location")
                                        Text("\(viewModel.ggProfile?.location ?? "")")
                                    }
                                    .padding(.bottom, 10)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    
                                    HStack {
                                        Image(systemName: "link")
                                        Text("\(viewModel.ggProfile?.blog ?? "")")
                                    }
                                    .padding(.bottom, 10)
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                                }
                                
                                Spacer()
                            }
                            .padding(.top, 50)
                            .padding(.horizontal, 20)
                            
                            // Popular Repositories Section
                            Text("Popular repositories")
                                .font(.title2)
                                .fontWeight(.medium)
                                .padding([.leading, .top])
                            
                            
                            ForEach(viewModel.ggRepositoryList!.indices, id: \.self) { index in
                                RepositoryRow(repository: viewModel.ggRepositoryList![index])
                                    .onAppear {
                                        if index == viewModel.ggRepositoryList!.count - 1 {
                                            viewModel.getGoogleRepositoryList()
                                        }
                                    }
                            }
                            
                            // Load indicator
                            HStack {
                                lastRowView
                            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            
                        
                        }
                    }
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .background(ColorConstants.cFFFFFFFF)
                    .navigationBarBackButtonHidden()
                    .ignoresSafeArea()
                }
            }(),
            mainLoadingStatus: $viewModel.mainLoadingStatus,
            hasError: $viewModel.hasError,
            errorMessage: $viewModel.errorMessage,
            onAppear: {
            }
        )
    }
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.loadListState {
            case .loading:
                ProgressView()
            case .empty:
                EmptyView()
            case .error:
                EmptyView()
            case .initial:
                EmptyView()
            case .ok:
                EmptyView()
            }
        }
        .frame(height: 50)
        .onAppear {
        }
    }
}

struct RepositoryRow: View {
    let repository: GgRepositoryEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(repository.name)
                    .font(.headline)
                    .foregroundColor(.blue)
                Spacer()
                
                if !repository.isPrivate {
                    Text(repository.visibility)
                        .font(.caption)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(0.1), lineWidth: 1)
                        )
                }
            }
            
            Text(repository.description ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack (alignment: .top) {
                HStack {
                    Circle()
                        .fill(Color(hex: AppHelper.convertLangColor(lang: repository.language ?? "")))
                        .frame(width: 8, height: 8)
                    Text(repository.language ?? "")
                }
                .font(.footnote)
                
                Spacer().frame(width: 10)
                
                HStack {
                    Image(systemName: "star")
                    Text("\(repository.stargazersCount)")
                }
                .font(.footnote)
                
                Spacer().frame(width: 10)
                
                HStack {
                    Image(systemName: "tuningfork")
                    Text("\(repository.forks)")
                }
                .font(.footnote)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1)
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    ProfileView(
        viewModel: DependencyInjector.instance.viewModelsDI.profile(navigationCoordinator: RootViewModel())
    )
}

