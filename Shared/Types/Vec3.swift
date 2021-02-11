import Foundation

typealias Point3 = Vec3
typealias Color3 = Vec3

struct Vec3 {

    let x: Double
    let y: Double
    let z: Double

    init() {
        self.init(x: 0, y: 0, z: 0)
    }

    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    var length: Double {
        lengthSquared.squareRoot()
    }

    var lengthSquared: Double {
        x * x + y * y + z * z
    }

}

extension Vec3 {

    static func +=(u: Vec3, v: Vec3) -> Vec3 {
        u + v
    }

    static func *=(u: Vec3, v: Vec3) -> Vec3 {
        u * v
    }

    static func +(u: Vec3, v: Vec3) -> Vec3 {
        Vec3(x: u.x + v.x, y: u.y + v.y, z: u.z + v.z)
    }

    static func -(u: Vec3, v: Vec3) -> Vec3 {
        Vec3(x: u.x - v.x, y: u.y - v.y, z: u.z - v.z)
    }

    static func *(u: Vec3, v: Vec3) -> Vec3 {
        Vec3(x: u.x * v.x, y: u.y * v.y, z: u.z * v.z)
    }

    static func *(t: Double, v: Vec3) -> Vec3 {
        Vec3(x: t * v.x, y: t * v.y, z: t * v.z)
    }

    static func /(v: Vec3, t: Double) -> Vec3 {
        (1 / t) * v;
    }

    static func dot(u: Vec3, v: Vec3) -> Double {
        u.x * v.x
            + u.y * v.y
            + u.z * v.z
    }

    static func cross(u: Vec3, v: Vec3) -> Vec3 {
        Vec3(x: u.y * v.z - u.z * v.y,
             y: u.z * v.x - u.x * v.z,
             z: u.x * v.y - u.y * v.x)
    }

    static func unit_vector(v: Vec3) -> Vec3 {
        return v / v.length
    }

}

extension Color3 {
    init(r: Double, g: Double, b: Double) {
        self.init(x: r, y: g, z: b)
    }
    var r: Double {
        x
    }
    var g: Double {
        y
    }
    var b: Double {
        z
    }
}

