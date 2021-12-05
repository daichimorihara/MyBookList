//
//  ContentView.swift
//  MyBookList
//
//  Created by Daichi Morihara on 2021/12/03.

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title), SortDescriptor(\.author)]) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            ZStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.yellow)
                                    .opacity(0.7)
                                Text("\(book.rating)")
                            }
                            .padding(.trailing, 3)
                            
                            
                            VStack(alignment: .leading) {
                                Text(book.wrappedTitle)
                                    .font(.headline)
                                Text(book.wrappedAuthor)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("MyBookList")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen = true
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        if moc.hasChanges {
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//import SwiftUI
//
//struct ContentView: View {
//    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
//    @Environment(\.managedObjectContext) var moc
//
//    var body: some View {
//        VStack {
//            List(students) { student in
//                Text(student.name ?? "Unknown")
//            }
//
//            Button {
//                let firstNames = ["Steve", "Mark", "Jeff", "Elon", "Bill"]
//                let lastNames = ["Jobs", "Zuckerberg", "Bezos", "Must", "Gates"]
//
//                let chosenFirstName = firstNames.randomElement()!
//                let chosenLastName = lastNames.randomElement()!
//
//                let student = Student(context: moc)
//                student.id = UUID()
//                student.name = "\(chosenFirstName) \(chosenLastName)"
//                try? moc.save()
//            } label: {
//                Text("Add")
//                    .foregroundColor(.white)
//                    .frame(width: 50, height: 50)
//                    .background(.blue.opacity(0.7))
//                    .clipShape(Capsule())
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
