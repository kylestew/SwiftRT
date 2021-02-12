import Foundation
import AppKit

class ImageOut {

    let size: CGSize
    var nsImage: NSImage?

    private var srgbArray: [UInt32]

    init(size: CGSize) {
        self.size = size
        self.srgbArray = [UInt32](repeating: 0xFFFFFFFF, count: Int(size.width * size.height))

        // image
        let aspectRatio = Double(size.width / size.height)
        let imageWidth = Double(size.width)
        let imageHeight = Double(size.height)

        // viewport & camera
        let camPosition = Point3.zero
        let focalLength = 1.0

        // viewport (screen)
        let viewportHeight = 2.0
        let viewportWidth = aspectRatio * viewportHeight
        let horizontal = Vec3(x: viewportWidth, y: 0, z: 0)
        let vertical = Vec3(x: 0, y: viewportHeight, z: 0)
        let lowerLeftCorner = camPosition - horizontal / 2 - vertical / 2 - Vec3(x: 0, y: 0, z: focalLength)

        // throw some rays!
        for j in 0..<Int(imageHeight) {
            for i in 0..<Int(imageWidth ) {
                let u = Double(i) / (imageWidth - 1)
                let v = Double(j) / (imageHeight - 1)
                let dir = lowerLeftCorner + u * horizontal + v * vertical - camPosition
                let ray = Ray(origin: camPosition, direction: dir)
                let pixelColor = color(for: ray)
                write(color: pixelColor, x: i, y: j)
            }
        }
    }

    private func color(for ray: Ray) -> Color3 {
        let unitDirection = ray.direction.unit
        let t = 0.5 * unitDirection.y + 1.0
        return (1.0 - t) * Color3(r: 1, g: 1, b: 1) + t * Color3(r: 0.5, g: 0.7, b: 1)
    }

    private func write(color: Color3, x: Int, y: Int) {
        let s = UInt32(0xFF000000)
        let ir = UInt32(255.999 * color.r) << 16
        let ig = UInt32(255.999 * color.g) << 8
        let ib = UInt32(255.999 * color.b)
        srgbArray[y * Int(size.width) + x] = s + ir + ig + ib
    }

    func rasterize() -> NSImage {
        let cgImage = srgbArray.withUnsafeMutableBytes { ptr -> CGImage in
            let ctx = CGContext(
                data: ptr.baseAddress,
                width: Int(size.width),
                height: Int(size.height),
                bitsPerComponent: 8,
                bytesPerRow: 4 * Int(size.width),
                space: CGColorSpace(name: CGColorSpace.sRGB)!,
                bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue + CGImageAlphaInfo.premultipliedFirst.rawValue
            )!
            return ctx.makeImage()!
        }

        return NSImage.init(cgImage: cgImage, size: size)
    }

}
