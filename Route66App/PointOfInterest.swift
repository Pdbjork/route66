import CoreLocation

struct PointOfInterest: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let description: String
}

let samplePOIs: [PointOfInterest] = [
    PointOfInterest(
        name: "Route 66 Museum",
        coordinate: CLLocationCoordinate2D(latitude: 35.4970, longitude: -97.5085),
        description: "Explore the history of the Mother Road in Oklahoma City."),
    PointOfInterest(
        name: "Cadillac Ranch",
        coordinate: CLLocationCoordinate2D(latitude: 35.1871, longitude: -101.8662),
        description: "Iconic public art installation in Amarillo, TX."),
    PointOfInterest(
        name: "Santa Monica Pier",
        coordinate: CLLocationCoordinate2D(latitude: 34.0100, longitude: -118.4962),
        description: "Official end of Route 66 in California.")
]
