import Foundation
import AppKit

struct ImageOut {

    let cgImage: CGImage
    let nsImage: NSImage

    init(size: Int) {
        var srgbArray = [UInt32](repeating: 0xFFFFFFFF, count: size * size)

        for j in 0..<size {
            for i in 0..<size {
                let r = Double(i) / Double(size - 1)
                let g = Double(j) / Double(size - 1)
                let b = 0.25

                let s = UInt32(0xFF000000)
                let ir = UInt32(255.999 * r) << 16
                let ig = UInt32(255.999 * g) << 8
                let ib = UInt32(255.999 * b)

                srgbArray[j * size + i] = s + ir + ig + ib
            }
        }

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

        self.cgImage = cgImage
        self.nsImage = NSImage.init(cgImage: cgImage, size: NSSize.init(width: size, height: size))
    }

}
