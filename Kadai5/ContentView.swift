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
                    .nobuStyle()
                Text("÷")
                TextField("", text: $inputNumber2)
                    .nobuStyle()
                Spacer()
            }
            HStack {
                Button(action: alertCheckAndShowLabel, label: {
                    Text("計算")
                })
                .alert(isPresented: $showAlert) {
                    switch alertType {
                    case .inputNumber1EmptyAlert:
                        return Alert(title: Text("課題５"), message: Text("割られる数を入力して下さい"), dismissButton: .default(Text("OK")))
                    case .inputNumber2EmptyAlert:
                        return Alert(title: Text("課題５"), message: Text("割る数を入力して下さい"), dismissButton: .default(Text("OK")))
                    case .inputNumber2ZeroAlert:
                        return Alert(title: Text("課題５"), message: Text("割る数には0を入力しないで下さい"), dismissButton: .default(Text("OK")))
                    }
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
        guard !inputNumber1.isEmpty else {
            alertType = .inputNumber1EmptyAlert
            showAlert = true
            return
        }
        // 割る数の入力存在チェック
        guard !inputNumber2.isEmpty else {
            alertType = .inputNumber2EmptyAlert
            showAlert = true
            return
        }
        
        /*
        割られる数と割る数に値があることが確定した後、
        入力値前後のスペースを除去し、数値に変換
        */
        let number1 = Float(inputNumber1.trimmingCharacters(in: .whitespaces)) ?? 0
        let number2 = Float(inputNumber2.trimmingCharacters(in: .whitespaces)) ?? 0
        
        // 割る数の0チェック
        guard number2 != 0 else {
            alertType = .inputNumber2ZeroAlert
            showAlert = true
            return
        }
        
        result = number1 / number2
    }
}

extension TextField {
    func nobuStyle() -> some View {
        return self
            .textFieldStyle(.roundedBorder)
            .frame(width: 100)
            .keyboardType(.numberPad)
    }
}

#Preview {
    ContentView()
}
