import Foundation

struct Ray {

    let origin: Point3
    let direction: Vec3

    init(origin: Point3, direction: Vec3) {
        self.origin = origin
        self.direction = direction
    }

    init() {
        self.init(origin: .zero, direction: .zero)
    }

    func at(t: Double) -> Point3 {
        return origin + t * direction
    }
    
}
