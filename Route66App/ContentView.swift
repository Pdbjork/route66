import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Route66MapView()
                .navigationTitle("Route 66")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
