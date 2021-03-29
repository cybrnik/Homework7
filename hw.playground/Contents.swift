import UIKit

enum ATMError: Error {

    case noEnoughMoney(moneyNeeded: Int)
    case cardNotReadble
    case internetError
    
    var localizedDescription: String {
        switch self {
        case .noEnoughMoney(moneyNeeded: let moneyNeeded):
            return "Недостаточно: \(moneyNeeded) рублей"
        case .cardNotReadble:
            return "Карта не читается"
        case .internetError:
            return "Проблемы с интернетом"
        }
    }
}

class ATM {
    var cards = ["1234 5432 8743 2345": 550, "1334 5782 8190 2143": 30000]
    func checkInternet() -> Bool {
        return Bool.random()
    }
    func getMoney(howMuchMoney: Int, card: String) -> ATMError? {
        guard checkInternet() else {
            return ATMError.internetError
        }
        for (cardItem , money) in cards{
            if cardItem == card{
                if money - howMuchMoney >= 0{
                    return nil
                }
                else {return ATMError.noEnoughMoney(moneyNeeded: (money - howMuchMoney)*(-1))}
            }
            
        }
        return ATMError.cardNotReadble
    }
}
extension ATM {
    func getMoneyThrow(howMuchMoney: Int, card: String) throws -> String?{
        guard checkInternet() else {
            throw ATMError.internetError
        }
        for (cardItem , money) in cards{
            if cardItem == card{
                if money - howMuchMoney >= 0{
                    return "Success"
                }
                else {throw ATMError.noEnoughMoney(moneyNeeded: (money - howMuchMoney)*(-1))}
            }
            
        }
        throw ATMError.cardNotReadble
    }

}
let card = ATM()
print(card.getMoney(howMuchMoney: 100000, card: "1234 5432 8743 2345") ?? "Success")
print(card.getMoney(howMuchMoney: 10, card: "1234 5432 8743 2345") ?? "Success")

do {
    let result = try card.getMoneyThrow(howMuchMoney: 100000, card: "1234 5432 8743 2345")
    print(result!)
} catch let error {
    print(error)
}

do {
    let result = try card.getMoneyThrow(howMuchMoney: 10, card: "1234 5432 8743 2345")
    print(result!)
} catch let error {
    print(error)
}
