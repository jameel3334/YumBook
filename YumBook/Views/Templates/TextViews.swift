//
//  TextViews.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct TextViews: View {
    var body: some View {
        Form {
            ScrollView {
                ButtonText(text: "Hello!")
                LabelText(text: "Hello!")
                SubHeaderText(text: "Hello!")
                PriceText(text: "$ 22.0")
                CustomHeaderText(text: "Hello!")
            }
        }
    }
}
struct ButtonText: View {
    var text: String
    var body: some View {
        
        Text (text)
            .font(.body)
            .bold()
            .kerning(2.0)
            .foregroundColor(.black)
            .padding()
    }
}
struct LabelText: View {
    var text: String
    var body: some View {
        
        Text(text)
            .fontWeight(.regular)
            .lineSpacing(20)
            .font(.body)
            .foregroundColor(Color(Constants.Color.textColor))
    }
}
struct SubHeaderText: View {
    var text: String
    var body: some View {
        
        Text(text.uppercased())
            .foregroundColor(Color(Constants.Color.textColor))
            .font(.headline)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color
    var body: some View {
        
        ZStack {
            ZStack {
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}
struct PriceText: View {
    var text: String
    var body: some View {
        
        Text(text)
            .foregroundColor(Color(Constants.Color.textColor))
            .font(.title3)
            .bold()
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
struct CustomHeaderText: View {
    var text: String
    var body: some View {
        
        StrokeText(text: text, width: 0.5, color: .black)
            .font(.custom(Constants.Font.comicText, size: 28, relativeTo: .title))
    }
}
struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        
        TextViews()
        TextViews()
            .previewLayout(.fixed(width: 568, height: 320))
        TextViews()
            .preferredColorScheme (.dark)
        TextViews()
            .preferredColorScheme (.dark)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
