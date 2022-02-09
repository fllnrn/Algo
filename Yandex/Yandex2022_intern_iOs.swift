import Foundation

// Не для отправки! Смена текущей папки на каталог проекта
var projectFolder = URL(fileURLWithPath: #file).deletingLastPathComponent()
FileManager.default.changeCurrentDirectoryPath(projectFolder.path)
//


//summ()

//func readNums() {

//    let fileName = "input.txt"
//    guard let line = try? String(contentsOfFile: fileName) else {return}
//    let split = line.split(separator: "\n")
//    guard split.count == 1 else {return}
//    let nums = split[0].split(separator: " ")
//    guard nums.count == 2, let a = Int(nums[0]), let b = Int(nums[1]) else {return}
//    let result = String(a + b)
//    try? result.write(toFile: "output.txt", atomically: true, encoding: .utf8)
//}

//readNums()

//func summ() {
//    let split = readLine()!.split(separator: "\n")
//    let nums = split[0].split(separator: " ").map{ Int($0)!}
//    let result = String(nums[0]+nums[1])
//    print(result)
//}
//summ()
func taskA() {
    var nums = Int(readLine()!)!
    let left: () -> Int = {
        return String(nums / 1000).map{ $0.wholeNumberValue!}.reduce(0, +)
    }
    let right: () -> Int = {
        return String(nums % 1000).map{ $0.wholeNumberValue!}.reduce(0, +)
    }
    while left() != right() {
        nums += 1
    }
    print(nums)
}
taskA()

import Foundation
func taskB() {
    let fileName = "input.txt"
    guard let line = try? String(contentsOfFile: fileName) else {return}

    let split = line.split(separator: "\n")
    let departure = split[0].split(separator: ":").map{Int($0)!}
    let arrivale = split[1].split(separator: ":").map{Int($0)!}
    var diff = Int(split[2])!

    var minutes = arrivale[1] - departure[1]
    if minutes < 0 {
        diff += 1
        minutes = 60+minutes
    }
    var hours = arrivale[0] - diff - departure[0]
    while hours < 0 {
        hours += 24
    }

    let result = String(format: "%d:%02d", hours, minutes)
    print(result)
//    try? result.write(toFile: "output.txt", atomically: true, encoding: .utf8)
}
taskB()
//
//import Foundation
//func taskB_2() {
//    let fileName = "input.txt"
//    guard let line = try? String(contentsOfFile: fileName) else {return}
//
//    let df = DateFormatter()
//    df.dateFormat = "HH:mm"
//
//    let split = line.split(separator: "\n")
//    let diff = Int(split[2])!
//    df.timeZone = TimeZone(secondsFromGMT: 0)
//
//    let dtDeparture = df.date(from: String(split[0]))!
//    df.timeZone = TimeZone(secondsFromGMT: diff*60*60)
//    let dtArrivale = df.date(from: String(split[1]))!
//    var interval = Int(dtArrivale.timeIntervalSince(dtDeparture))
//    while interval < 0 {
//        interval += 24*60*60
//    }
//
//    let hours = interval / 60 / 60
//    let minutes = (interval - (hours * 60 * 60)) / 60
//
//    let result = String(format: "%d:%02d", hours, minutes)
//    print(result)
//}
//taskB_2()


import Foundation
func taskC() -> Bool {
    let fileName = "input.txt"
    guard let line = try? String(contentsOfFile: fileName) else {return false}


    let split = line.split(separator: "\n")

    let filter: (Substring) -> [String] = {
        $0.split(separator: ",").map{ $0.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)}
    }
    let students1 = filter(split[0])
    var students2 = filter(split[1])

    let compareTwoFullNames: ([String], [String]) -> Bool = {
        if $0[0] == $1[0] {
            return $0[1] == $1[1]
        } else if $0[0] == $1[1] {
            return $0[1] == $1[0]
        }
        return false
    }

    for student in students1 {
        let splitName = student.split(separator: " ").map {String($0)}
        for i in students2.indices {
            let candidate = students2[i].split(separator: " ").map {String($0)}
            if compareTwoFullNames(splitName, candidate) {
                students2.remove(at: i)
                break
            }
        }
    }


    return students2.isEmpty
//    try? result.write(toFile: "output.txt", atomically: true, encoding: .utf8)
}
if taskC() {
    print("YES")
} else {
    print("NO")
}


import Foundation
func taskD() {
    let fileName = "input.txt"
    guard let line = try? String(contentsOfFile: fileName) else {return}
    let split = line.split(separator: "\n").map { $0.split(separator: " ").map{ Int($0)!} }
    let count = split[0][0]
    let money = split[0][1]
    let grades = split[1]
    let parents = split[2]
    var result = [Int](repeating: 0, count: count)
    var childs = [[Int]](repeating: [], count: count + 1)
    
    for (o, p) in parents.enumerated() {
        childs[p].append(o+1)
    }
    var queue = [Int]()
    
    queue.append(0)
    while !queue.isEmpty {
        let current = queue.popLast()!
        let money = current == 0 ? money : result[current-1]
        if childs[current].isEmpty {
            continue
        }
        let sum = childs[current].reduce(0) { grade, child in
            return grade + grades[child-1]
        }
        for child in childs[current] {
            result[child-1] = money * grades[child-1] / sum
            queue.append(child)
        }
    }
    
    print(result.map{ String($0)}.joined(separator: " "))
}

taskD()





