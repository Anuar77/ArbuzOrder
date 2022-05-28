//
//  ContentView.swift
//  ArbuzOrder
//
//  Created by Anuar Aitkali on 28.05.2022.
//


import SwiftUI







struct ContentView: View {
    
    //Varaibles to keep track of the user input
    @State private var address = ""
    @State private var phoneNumber = ""
    @State private var deliveryDate = Date.now
    @State private var cutToSlices = false
    @State private var numberOfWatermelons = 1
    @State var selection : String = "1A"
    let placeOptions: [String] = [
        "1A - Ripe - 7kg", "1B - Ripe - 8kg", "1c - Ripe - 10kg",
        "2A - Unripe - 4kg", "2B - Unripe - 6kg", "2C - Unripe - 2kg",
        "3A - Taken", "3B - Taken", "3C - Taken"
    ]
    
    var body: some View {
        NavigationView {
            //Form type structure rather than a vertical stack
            Form {
                //Main action and the purpose of the application
                Section(header: Text("Pick a watermelon")) {
                    //Selecting a type of watermelon and the locatins it comes from
                    Picker(
                        selection: $selection,
                        label:
                            VStack {
                                Text("Place and type: ")
                                Text(selection)
                            },
                        content: {
                            ForEach(placeOptions, id: \.self) { option in
                                Text(option)
                                    .tag(option)
                            }
                        }
                    )
                    
                    //Other methods
                    //Functino that checks if the user wants the watermelon to be sliced
                    Toggle("Cut to slices", isOn: $cutToSlices)
                    
                    //If user wants to get more, max:3
                    Stepper("Number of watermelons", value: $numberOfWatermelons, in: 1...3)
                    Text("You picked \(numberOfWatermelons) watermelon(s)")
                    
                }
                
                //Personal information for delivery
                Section(header: Text("Delivery information")) {
                    TextField("Address", text:$address)
                    TextField("Phone Number", text:$phoneNumber)
                    DatePicker("Date", selection: $deliveryDate, in: Date.now...Date.now.addingTimeInterval(777600))
                }
                
                Section() {
                    Link("Terms of service", destination: URL(string: "https://anuar.tech")!)
                }
                
                
            }
            .navigationTitle("Watermelon Order")
            .toolbar { //To not have problems with the keyboard
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    
                    Button("Order", action: placeOrder) //Final button, when everything is done
                }
            }
        }
        
    }
    
    func placeOrder() {
        print("Order is placed")
    }
        
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if canImport(UIKit) //methid to hide the keyboard when done
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
