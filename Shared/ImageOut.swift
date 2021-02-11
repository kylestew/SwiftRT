import Foundation
import AppKit

class ImageOut {

    let size: Int
    var nsImage: NSImage?

    private var srgbArray: [UInt32]

    init(size: Int) {
        self.size = size
        self.srgbArray = [UInt32](repeating: 0xFFFFFFFF, count: size * size)

        for j in 0..<size {
            for i in 0..<size {
                let color = Color3(r: Double(i) / Double(size - 1),
                                   g: Double(j) / Double(size - 1),
                                   b: 0.25)
                write(color: color, x: j, y: i)
            }
        }
    }

    private func write(color: Color3, x: Int, y: Int) {
        let s = UInt32(0xFF000000)
        let ir = UInt32(255.999 * color.r) << 16
        let ig = UInt32(255.999 * color.g) << 8
        let ib = UInt32(255.999 * color.b)
        srgbArray[y * size + x] = s + ir + ig + ib
    }

    func rasterize() -> NSImage {
        let cgImage = srgbArray.withUnsafeMutableBytes { ptr -> CGImage in
            let ctx = CGContext(
                data: ptr.baseAddress,
                width: size,
                height: size,
                bitsPerComponent: 8,
                bytesPerRow: 4 * size,
                space: CGColorSpace(name: CGColorSpace.sRGB)!,
                bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue + CGImageAlphaInfo.premultipliedFirst.rawValue
            )!
            return ctx.makeImage()!
        }

        return NSImage.init(cgImage: cgImage, size: NSSize.init(width: size, height: size))
    }

}
