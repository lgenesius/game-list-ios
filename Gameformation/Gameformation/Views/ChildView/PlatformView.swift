import SwiftUI

struct PlatformView: View {
    let platformName: String
    var body: some View {
        Text(platformName)
            .foregroundColor(.black)
            .font(Font.system(size: 12))
            .padding(.all, 10)
            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            .cornerRadius(10)
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformView(platformName: "PlayStation 5")
    }
}
