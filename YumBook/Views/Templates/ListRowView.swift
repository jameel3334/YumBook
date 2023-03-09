//
//  ListRowView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct ListRowView: View {
    let imageURL: String
    let title: String
    var body: some View {
        HStack {
            ListRowImageView(imageURL: imageURL)
                .frame(width: Constants.Image.menuTileHeightWidth, height: Constants.Image.menuTileHeightWidth)
                .cornerRadius(Constants.Image.menuTileCornerRadius)
                .padding(.vertical, Constants.General.constraintsTopBottom)
            SubHeaderText(text: title.uppercased())
                .padding( Constants.General.constraintsTopBottom)
        }
    }
}

