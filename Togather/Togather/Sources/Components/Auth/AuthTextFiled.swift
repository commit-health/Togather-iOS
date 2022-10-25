import SwiftUI

struct AuthTextFiled: View {
    let placeholder: String
    let isSecret: Bool
    @State private var isShow = true
    @Binding var text: String
    @Binding var message: String
    @Binding var isError: Bool
    
    init(
        placeholder: String,
        isSecret: Bool = false,
        text: Binding<String>,
        message: Binding<String> = .constant(""),
        isError: Binding<Bool> = .constant(false)
    ) {
        self.placeholder = placeholder
        self.isSecret = isSecret
        self._text = text
        self._message = message
        self._isError = isError
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .trailing) {
                HStack {
                    if isSecret ? !isShow : true {
                        TextField(
                            placeholder,
                            text: $text
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.title3m)
                        .padding(.leading, 10)
                    } else {
                        SecureField(
                            placeholder,
                            text: $text
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.title3m)
                        .padding(.leading, 10)
                    }
                }
                .frame(height: 48)
                .background(Color.whiteElevated1)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: .init(lineWidth: 1))
                        .foregroundColor(isError ? .error : .whiteElevated3)
                )
                
                if isSecret {
                    Button {
                        self.isShow.toggle()
                    } label: {
                        Image(isShow ? "EyeDisable" : "Eye")
                    }
                    .frame(width: 28, height: 28)
                    .padding(.trailing, 10)
                }
            }
            if !message.isEmpty {
                HStack {
                    Text(message)
                        .font(.indicator)
                        .foregroundColor(isError ? Color.error : Color.whiteElevated4)
                        .padding(.top, 8)
                        .padding(.leading, 12)
                    Spacer()
                }
            }
        }
    }
}

struct AuthTextFiled_Previews: PreviewProvider {
    static var previews: some View {
        AuthTextFiled(
            placeholder: "아이디",
            isSecret: true,
            text: .constant("hi"),
            message: .constant("dsm.hs.kr 도메인을 사용하는 이메일을 사용하세요"),
            isError: .constant(false)
        )
    }
}