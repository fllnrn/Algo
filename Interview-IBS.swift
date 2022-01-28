let question = "ab2(3(c)d)ab2(3(c)d)"
func multiplyStr(count: Int, str: String) -> String {
    var result = ""
    for _ in 0..<count {
        result += str
    }
    return result
}
func nextOpening(from index: String.Index, in str: String) -> String.Index {
    var current = index
    while current < str.endIndex {
        if str[current] == "(" {
            return current
        }
        current = str.index(after: current)
    }
    return str.endIndex
}
func endOfFullExpression(from index: String.Index, in str: String) -> String.Index {
    var current = index
    var count = 0
    while current < str.endIndex {
        if str[current] == ")" {
            count -= 1
        }
        if str[current] == "(" {
            count += 1
        }
        if count == 0 {
            return current
        }
        current = str.index(after: current)
    }
    return str.endIndex
}
func Solution(_ input: String) -> String {
    var current = input.startIndex
    
    var result = ""
    
    while current < input.endIndex {
        if input[current].isLetter {
            result.append(input[current])
            current = input.index(after: current)
            continue
        }
        
        if input[current].isNumber {
            
            let firstParenesis = nextOpening(from: current, in: input)
            let lastParentesis = endOfFullExpression(from: firstParenesis, in: input)

            let number = Int(String(input[current..<firstParenesis])) ?? 1
            
            let substr = String(input[input.index(after: firstParenesis)..<lastParentesis])
            
            let recursive = multiplyStr(count: number, str: Solution(substr))
            
            result.append(recursive)
            current = input.index(after: lastParentesis)
            continue
        }
    }
    return result
}

let answer = Solution(question)
print(answer)
