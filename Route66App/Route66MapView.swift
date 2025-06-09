import SwiftUI
import MapKit

struct Route66MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.0, longitude: -98.0),
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    )
    @State private var route: MKRoute?

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: samplePOIs) { poi in
            MapAnnotation(coordinate: poi.coordinate) {
                VStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text(poi.name)
                        .font(.caption)
                }
            }
        }
        .onAppear(perform: loadRoute)
        .overlay(routePolyline)
    }

    private var routePolyline: some View {
        Group {
            if let polyline = route?.polyline {
                MapPolyline(polyline)
                    .stroke(Color.blue, lineWidth: 4)
            }
        }
    }

    private func loadRoute() {
        let start = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)) // Chicago
        let end = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 34.0100, longitude: -118.4962)) // Santa Monica

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: start)
        request.destination = MKMapItem(placemark: end)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
                self.region = MKCoordinateRegion(route.polyline.boundingMapRect)
            }
        }
    }
}

struct Route66MapView_Previews: PreviewProvider {
    static var previews: some View {
        Route66MapView()
    }
}
