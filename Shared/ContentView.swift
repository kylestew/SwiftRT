import SwiftUI

struct ContentView: View {
    let nsImg = ImageOut(size: CGSize(width: 400, height: 225)).rasterize()

    var body: some View {
        Image(nsImage: nsImg)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
