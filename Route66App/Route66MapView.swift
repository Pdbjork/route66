import SwiftUI
import MapKit
import CoreLocation

struct Route66MapView: View {
    @State private var position: MapCameraPosition = .automatic
    @State private var route: MKRoute?
    
    private let startCoordinate = CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298) // Chicago
    private let endCoordinate = CLLocationCoordinate2D(latitude: 34.0100, longitude: -118.4962) // Santa Monica

    var body: some View {
        Map(position: $position) {
            // Add route polyline if available
            if let route = route {
                MapPolyline(route.polyline)
                    .stroke(Color.blue, lineWidth: 4)
            }
            
            // Add annotations for points of interest
            ForEach(samplePOIs) { poi in
                Annotation(poi.name, coordinate: poi.coordinate) {
                    VStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                            .font(.title3)
                        Text(poi.name)
                            .font(.caption2)
                            .lineLimit(1)
                    }
                    .padding(4)
                }
            }
        }
        .mapStyle(.standard)
        .onAppear(perform: loadRoute)
    }

    private func loadRoute() {
        let start = MKPlacemark(coordinate: startCoordinate)
        let end = MKPlacemark(coordinate: endCoordinate)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: start)
        request.destination = MKMapItem(placemark: end)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
                // Update map position to show the entire route
                self.position = .rect(route.polyline.boundingMapRect)
            } else if let error = error {
                print("Error calculating route: \(error.localizedDescription)")
            }
        }
    }
}

struct Route66MapView_Previews: PreviewProvider {
    static var previews: some View {
        Route66MapView()
    }
}
