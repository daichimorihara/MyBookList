//
//  AddBookView.swift
//  MyBookList
//
//  Created by Daichi Morihara on 2021/12/04.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var showingAlert = false
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
   
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
            }
            .navigationTitle("Add Book")
            .alert("Some information isn't filled out", isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text("You must fill out every information about this book")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        
                        if title.isEmpty || author.isEmpty || genre.isEmpty {
                             showingAlert = true
                        } else {
                            let newBook = Book(context: moc)
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author
                            newBook.rating = Int16(rating)
                            newBook.review = review
                            newBook.genre = genre
                            try? moc.save()
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

//struct AddBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddBookView()
//    }
//}
