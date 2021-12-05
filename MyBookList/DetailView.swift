//
//  DetailView.swift
//  MyBookList
//
//  Created by Daichi Morihara on 2021/12/04.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.wrappedGenre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.wrappedGenre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.7))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.wrappedAuthor)
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.wrappedReview)
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
            HStack {
                Spacer()
                Text("This review is written on ") 
                    .foregroundColor(.secondary)
                +
                Text("\(book.wrappedDate)")
                    .font(.body)
                    .foregroundColor(.primary)
                
            }
            .padding()
            
        }
        .navigationTitle(book.wrappedTitle)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook )
            Button("Cancel", role: .cancel, action: {})
            
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        
    }
    
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }

    
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
