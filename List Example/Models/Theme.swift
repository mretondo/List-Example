import Foundation
import UIKit

/*
struct Reminder {
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
}

#if DEBUG
extension Reminder {
    static var sampleData = [
        Reminder(title: "Submit reimbursement report", dueDate: Date().addingTimeInterval(800.0), notes: "Don't forget about taxi receipts"),
        Reminder(title: "Code review", dueDate: Date().addingTimeInterval(14000.0), notes: "Check tech specs in shared folder", isComplete: true),
        Reminder(title: "Pick up new contacts", dueDate: Date().addingTimeInterval(24000.0), notes: "Optometrist closes at 6:00PM"),
        Reminder(title: "Add notes to retrospective", dueDate: Date().addingTimeInterval(3200.0), notes: "Collaborate with project manager", isComplete: true),
        Reminder(title: "Interview new project manager candidate", dueDate: Date().addingTimeInterval(60000.0), notes: "Review portfolio"),
        Reminder(title: "Mock up onboarding experience", dueDate: Date().addingTimeInterval(72000.0), notes: "Think different"),
        Reminder(title: "Review usage analytics", dueDate: Date().addingTimeInterval(83000.0), notes: "Discuss trends with management"),
        Reminder(title: "Confirm group reservation", dueDate: Date().addingTimeInterval(92500.0), notes: "Ask about space heaters"),
        Reminder(title: "Add beta testers to TestFlight", dueDate: Date().addingTimeInterval(101000.0),  notes: "v0.9 out on Friday")
    ]
}
#endif
*/

struct Theme: Hashable {
    var title: String
    var emojis: String
    var backgroundColor: UIColor
    var faceDownColor: UIColor
    var faceUpColor: UIColor
    
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension Theme {
    static var sampleThemes = [
        Theme(title: "Sports", emojis: "ππβΎοΈπββοΈποΈββοΈπ΄ββοΈπΈππββοΈπ―π³ππβ·ππ»ββοΈπ€ΈββοΈβΉοΈββοΈπΎπβ½οΈππΉπΉβΈπ₯", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
        Theme(title: "Animals", emojis: "πΆπ π¦π»π¨ππΈπ€π°π½π¦π¦π¦πππΊπ¦π·π¦π¬π«π¦π¦ππ", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
        Theme(title: "Faces", emojis: "ππ€£ππ€’π€ͺπ€π¬ππ‘ππ₯Άπ€₯ππ€ π€?ππ€π«π₯³ππ?π€π³ππ₯Ί", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
        Theme(title: "Christmas", emojis: "ππ»π§£πβοΈβοΈππ¨βοΈπ€Άπ»π§€", backgroundColor: #colorLiteral(red: 0, green: 0.2784313725, blue: 0.1529411765, alpha: 1), faceDownColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), faceUpColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        Theme(title: "Halloween", emojis: "ππ¦π±πππ»π­π¬ππ§π»ββοΈπ§ββοΈπΊβ°οΈ", backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), faceDownColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), faceUpColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        Theme(title: "Food", emojis: "πππππππ₯₯π₯π₯¦π½π₯π₯―π₯¨π₯©ππ­ππππ?π¦π§π°ππ­π©βοΈπΊπ§ππΆππ₯π", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
        Theme(title: "Travel", emojis: "πππππππ΄π²π΅ππ ππβοΈπ©π°ππΈππΆβ΅οΈπ³π¦π½πΏπ°π―π’ππβΊοΈπ ππβ©", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
        Theme(title: "Flags", emojis: "π΄ββ οΈπ©π³οΈβππΊπΈπ¨π¦π«π·π¨π³π·πΊπ?π³π?π±π―π΅π?πΉππ²πΎπ²π½π³π΅π³π΄π΅π¦π¨π­π¬π§ππ?πͺπ²πΎπ»π³π§π©", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
        Theme(title: "Objects", emojis: "βοΈπ±π»β¨οΈπ₯π¨πΉπππΈπ₯π½πππΊπ§­β°β³π‘π¦π§―π π§²π§¨ππππππ­ππππππΏπ§¬πππ§·π§?π¬", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
        Theme(title: "Potpourri", emojis: "ππ¦π§΅π΄π­πβ°β€οΈπΏβ­οΈπ₯ΆππΆπ€‘ππ¦πππΉβοΈπππͺπ₯¨ππ²π±π₯π΅βοΈπ°β΅οΈπΎπ‘π§²βοΈππ°ππΊπΈπ«π", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
    ]
}
