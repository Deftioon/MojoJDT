from python import Python

struct Array[T: AnyRegType]:
    var ArrPointer: Pointer[T]
    var len: Int
    var capacity: Int

    fn __init__(inout self, default_value: T, capacity: Int = 10) -> None:
        self.len = capacity if capacity > 0 else 1
        self.capacity = self.len * 2
        self.ArrPointer = Pointer[T].alloc(self.capacity)
        for i in range(self.len):
            self[i] = default_value

    fn __getitem__(borrowed self, i: Int) -> T:
        if i >= self.len:
            print("getitem: IndexError: Out of Bounds")
            return self.ArrPointer.load(0) 
        return self.ArrPointer.load(i)

    fn __setitem__(inout self, loc: Int, item: T) -> None:
        if loc > self.capacity:
            print("setitem: IndexError: Out of Bounds")
            return
        if loc > self.len:
            let old_len = self.len
            self.len = loc + 1
            for i in range(old_len, self.len):
                self.ArrPointer.store(i, item)
            return
        self.ArrPointer.store(loc, item)

    fn pop(inout self) -> T:
        if self.len == 0:
            print("pop: IndexError: Pop from empty array")
            return self.ArrPointer.load(0)  # or handle error differently
        self.len -= 1
        return self.ArrPointer.load(self.len)
    
    fn delete(inout self, index: Int) -> None:
        for i in range(index, self.len-1):
            self[i] = self[i + 1]
        self.len -= 1

    fn load(inout self, input: VariadicList) -> None:
        if len(input) > self.len:
            print("load: IndexError: VariadicList is larger than User-defined Array Length")
            return
        for i in range(len(input)):
            self[i] = input[i]
            self.len = len(input)
    
    fn __del__(owned self) -> None:
        self.ArrPointer.free()

struct JDTBar:
    var total_iter: Int
    var bar_len: Int
    var bar: String
    var barInterval: Array[Int]

    fn __init__(inout self, current_iter: Int, total_iter: Int, bar_len: Int = 20) raises:
        self.total_iter = total_iter
        self.bar_len = bar_len
        self.bar = ""
        self.barInterval = Array[Int](0, bar_len)

        for i in range(total_iter // bar_len):
            self.barInterval[i] = i * bar_len
    fn getBar(inout self, current_iter: Int) -> String:
        var barBar: String = ""
        for i in range(self.bar_len % self.bar_len):
            barBar = barBar + " " 
        return ""

struct IteratorString:
    var data: String
    var index: Int
    var totallen: Int
    var bar_len: Int
    var bar: String
    fn __init__(inout self, data: String, bar_len: Int) raises:
        self.data = data
        self.index = -1
        self.totallen = len(data)
        self.bar_len = bar_len
        self.bar = ""

        for i in range(self.bar_len):
            self.bar = self.bar + " "
    
    fn __len__(self) -> Int:
        return len(self.data) - self.index - 1
    
    fn __next__(inout self) raises -> String:
        if self.index % (self.totallen // self.bar_len) == 0:
            print_no_newline(".")
        if self.index == self.totallen - 2:
            print("")
        self.index += 1
        return self.data[self.index]

struct IterStringJDT:
    var stringData: String
    var bar_len: Int
    fn __init__(inout self, data: String, bar_len: Int = 20):
        self.stringData = data
        self.bar_len = bar_len

    fn __iter__(self) raises -> IteratorString:
        return IteratorString(self.stringData, self.bar_len)

struct IteratorInt:
    var data: Int
    var index: Int
    var bar_len: Int


    fn __init__(inout self, data: Int, bar_len: Int = 20):
        self.data = data
        self.index = -1
        self.bar_len = bar_len

    fn __len__(self) -> Int:
        return self.data - self.index - 1

    fn __next__(inout self) raises -> Int:
        if self.index % (self.data // self.bar_len) == 0:
            print_no_newline(".")
        if self.index == self.data - 2:
            print("")
        self.index += 1
        return self.index

struct IterIntJDT:
    var data: Int
    var bar_len: Int
    fn __init__(inout self, data: Int, bar_len: Int = 20):
        self.data = data
        self.bar_len = bar_len
    
    fn __iter__(self) -> IteratorInt:
        return IteratorInt(self.data, self.bar_len)

fn main() raises:
    pass
