//
//  ContentView.swift
//  DyanmicList
//
//  Created by RaviSingh on 14/02/21.
//

import SwiftUI

struct ListItem: Identifiable {
    var id = UUID()
    let title : String
    
}

class ListViewModel: ObservableObject {
    @Published var list: [ListItem] = [
    ListItem(title: "buy milk"),
        ListItem(title: "buy apple")
    
    ]
}

struct ContentView: View {
    @StateObject var viewModel = ListViewModel()
    @State var text = ""
    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("Add New Item")) {
                    TextField("Add new item",text:$text)
                        .padding()
                    Button(action: {
                        self.addItemList()
                    }, label: {
                        Text("Add")
                            .bold()
                            .frame(width: 250, height: 50, alignment: .center)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                    })
                }
                List {
                    ForEach(viewModel.list) { list in
                        ListRow(title: list.title)
                    }
                   
                    
                }
            }
            .navigationTitle("List")
        }
        
    }
    
    func addItemList() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let newList = ListItem(title: text)
        viewModel.list.append(newList)
        text = ""
        
    }
}

struct ListRow:View {
       
  let title: String
    
    var body: some View {
        
        Label(
            title: { Text(title) },
            icon: { Image(systemName: "42.circle") }
  )
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
