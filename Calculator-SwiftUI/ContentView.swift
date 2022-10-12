//
//  ContentView.swift
//  Calculator-SwiftUI
//
//  Created by cecily li on 7/8/22.
//

import SwiftUI

//symbols and strings from app

enum CaclButtons: String {
    
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case nagetive = "+/-"
    
    //computed property for button color
    var buttonColor: Color {
        switch self {
        case .add, .substract, .equal, .multiply, .divide:
            return .orange
        case .clear, .nagetive, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red:55/255.0, green: 55/255.0, blue: 55/255.0,alpha: 1))
        }
    }
}

enum Operation {
    case add, substract, multiply, divide, none
}
struct ContentView: View {
    //MARK: --created properties
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperations: Operation = .none
    
    let buttons: [[CaclButtons]] = [
        [.clear, .nagetive, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    Text(value)
                        //.bold()
                        .font(.system(size: 100))
                        .foregroundStyle(.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) {
                    row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item),
                                           height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })
                            
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }


//functions - configure operations
    func didTap(button: CaclButtons) {
        switch button {
        case .add, .substract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperations = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .substract {
                self.currentOperations = .substract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperations = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperations = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperations {
                case .add: self.value = "\(runningValue + currentValue)"
                case .substract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .nagetive, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    func buttonWidth(item: CaclButtons) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return ((UIScreen.main.bounds.width - (5 * 12)) / 4)
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
