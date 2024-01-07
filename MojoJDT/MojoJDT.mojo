struct IteratorInt:
    var data: Int
    var index: Int
    fn __init__(inout self, data: Int):
        self.data = data
        self.index = -1

    fn __len__(self) -> Int:
        return self.data - self.index - 1

    fn __next__(inout self) raises -> Int:
        self.index += 1
        return self.index

struct IteratorString:
    var data: String
    var index: Int
    fn __init__(inout self, data: String):
        self.data = data
        self.index = -1
    
    fn __len__(self) -> Int:
        return len(self.data) - self.index - 1
    
    fn __next__(inout self) raises -> String:
        self.index += 1
        return self.data[self.index]

struct IterStringJDT:
    var stringData: String
    fn __init__(inout self, data: String):
        self.stringData = data
    fn __iter__(self) -> IteratorString:
        return IteratorString(self.stringData)

struct JDTRange:
    var times: Int
    fn __init__(inout self, times: Int):
        self.times = times
    
    fn __iter__(self):
        pass

fn main() raises:
    for i in IterStringJDT("Hello World"):
        print(i)
