import demo2

print("Balaji Dinakaran")
print('Welcome to api automation')

a = 10
b = 10.2

print(a)
print(type(a))
print(type(b))

# add a & b and store it in c. Print c
c = a + b
print(c)
print("The output is " + str(c))

my_name = "Balaji Dinakaran"
print(my_name)

print(type(my_name))

company_name = "E2OPEN"

print(company_name)
print(company_name[0])
print(company_name[3])

colors = ["red", "yellow", "green", "blue"]

print(colors)
print(type(colors))
print(colors[2])

numbers = [3, 44, 55, 45, 46, 6]
print(numbers[3])

my_details = {
    "name": "bala",
    "role": "trainer",
    "mobile": 9848,
    "age": 30
}

print(my_details)
print(type(my_details))

print(my_details["mobile"])


res=demo2.add(1,10)
print(res)

res=demo2.mul(1,10)
print(res)

res=demo2.get_name()
print(res)

res=demo2.sub()
print(res)

res=demo2.sub(9,10)
print(res)