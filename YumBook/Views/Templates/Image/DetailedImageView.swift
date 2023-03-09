//
//  DetailedImageView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/8/23.
//

import SwiftUI

struct DetailedImageView: View {
    let imageURL: String?
    var body: some View {
        if let imageURL = imageURL {
            CacheAsyncImage(url: URL(string: imageURL) ?? URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!,
                            content: { phase in
                switch phase {
                case .empty :
                    Image(uiImage: UIImage(named: Constants.Image.defaultMenuImage) ?? UIImage())
                        .resizable()
                        .overlay {
                            if URL(string: imageURL) != nil {
                                ProgressView()
                                    .frame(maxWidth: .infinity,
                                           maxHeight: .infinity)
                                    .background(.gray.opacity(0.4))
                            }
                        }
                        .frame(width: Constants.Image.portraitViewImageDimensions, height: Constants.Image.portraitViewImageDimensions)
                        .cornerRadius(Constants.Image.menuTileCornerRadius)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: Constants.Image.portraitViewImageDimensions, height: Constants.Image.portraitViewImageDimensions)
                        .cornerRadius(Constants.Image.menuTileCornerRadius)
                case .failure:
                    Image(uiImage: UIImage(named: Constants.Image.defaultMenuImage) ?? UIImage())
                        .resizable()
                        .frame(width: Constants.Image.portraitViewImageDimensions, height: Constants.Image.portraitViewImageDimensions)
                        .cornerRadius(Constants.Image.menuTileCornerRadius)
                @unknown default:
                    EmptyView()
                }
            }
            )}
    }
}

