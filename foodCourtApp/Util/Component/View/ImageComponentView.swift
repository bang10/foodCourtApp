//
//  ImageComponentView.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/12/24.
//

import SwiftUI

struct ImageComponentView: View {
    var imageUrl: String? // 외부 이미지 URL (nil일 수 있음)
    var sfSymbolName: String // SF Symbol 이름
    var widthValue: CGFloat // 부모 뷰 대비 너비 비율 (0.0 ~ 1.0)
    var heightValue: CGFloat // 부모 뷰 대비 높이 비율 (0.0 ~ 1.0)
    var imageSize: CGFloat
    
    var body: some View {
        VStack {
            if let imageUrl = imageUrl, let url = URL(string: imageUrl), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                // 외부 이미지를 보여줌
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: widthValue,
                        height: heightValue
                    )
                    .font(.system(size: imageSize))
            } else {
                // SF Symbol을 보여줌
                Image(systemName: sfSymbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: widthValue,
                        height: heightValue
                    )
                    .font(.system(size: imageSize))
            }
        }
    }// View
}

#Preview {
    ImageComponentView(sfSymbolName: "", widthValue: 30, heightValue: 30, imageSize: 10)
}
