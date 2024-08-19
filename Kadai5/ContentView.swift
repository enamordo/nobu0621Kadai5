//
//  ContentView.swift
//  Kadai5
//
//  Created by nobu0621 on 2024/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber1: String = ""
    @State private var inputNumber2: String = ""
    @State private var result: Float = 0.0
    
    // アラートの表示状態を監視
    @State private var showAlert = false
    @State var alertType: AlertType = .inputNumber1EmptyAlert
    
    // 子要素のHstackに１つSpacer()があれば、他は親Vstackのalignment: .leadingがあれば位置設定される様子
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                TextField("", text: $inputNumber1)
                    .roundedTextFieldStyle()
                Text("÷")
                TextField("", text: $inputNumber2)
                    .roundedTextFieldStyle()
                Spacer()
            }
            HStack {
                Button(action: alertCheckAndShowLabel, label: {
                    Text("計算")
                })
                .alert(isPresented: $showAlert) {
                    let message: String = switch alertType {
                    case .inputNumber1EmptyAlert:
                        "割られる数を入力して下さい"
                    case .inputNumber2EmptyAlert:
                        "割る数を入力して下さい"
                    case .inputNumber2ZeroAlert:
                        "割る数には0を入力しないで下さい"
                    }
                    
                    return Alert(title: Text("課題５"), message: Text(message), dismissButton: .default(Text("OK")))
                }
            }
            HStack {
                Label(String(result), systemImage: "")
            }
            Spacer()
        }
        .padding()
    }
    
    func alertCheckAndShowLabel() {
        // 割られる数の入力存在チェック
        // スペース除去も実施
        guard let number1 = Float(inputNumber1.trimmingCharacters(in: .whitespaces)) else {
            alertType = .inputNumber1EmptyAlert
            showAlert = true
            return
        }
        
        // 割る数の入力存在チェック
        // スペース除去も実施
        guard  let number2 = Float(inputNumber2.trimmingCharacters(in: .whitespaces)) else {
            alertType = .inputNumber2EmptyAlert
            showAlert = true
            return
        }
        
        // 割る数の0チェック
        if number2 == 0 {
            alertType = .inputNumber2ZeroAlert
            showAlert = true
        } else {
            result = number1 / number2
        }
    }
}

extension TextField {
    func roundedTextFieldStyle() -> some View {
        return self
            .textFieldStyle(.roundedBorder)
            .frame(width: 100)
            .keyboardType(.numberPad)
    }
}

#Preview {
    ContentView()
}
