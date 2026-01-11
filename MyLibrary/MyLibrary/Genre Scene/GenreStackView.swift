//
//  GenreStackView.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 11/01/2026.
//

import SwiftUI

struct GenreStackView: View {
      var genres: [GenreModel]
    var body: some View {
        HStack(spacing: 10) {
            ForEach(genres.sorted(using:KeyPathComparator(\GenreModel.name))  ) { genre in
                Text(genre.name)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).fill(genre.hexColor))
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
  //  GenreStackView()
}
