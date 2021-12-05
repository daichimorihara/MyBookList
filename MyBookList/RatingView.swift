//
//  RatingVIew.swift
//  MyBookList
//
//  Created by Daichi Morihara on 2021/12/04.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1..<6, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? Color.gray : Color.yellow)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }

    func image(for number: Int) -> Image{
        return Image(systemName: "star.fill")
    }

}
