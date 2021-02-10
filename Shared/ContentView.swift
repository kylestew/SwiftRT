import SwiftUI

struct ContentView: View {
    let imageProvider = ImageOut(size: 256)

    var body: some View {
        Image(nsImage: imageProvider.nsImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
