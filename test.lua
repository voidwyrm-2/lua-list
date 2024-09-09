local List = require("list")

local ls = List.New()
print(ls)

ls:Push("hi")
ls:Push("hello")
ls:Push("there")
print(ls)

print(ls:Pop())
print(ls)
