
b = [0]*10
for i in range(1, 2020):
    key = (i**3) % 10
    b[key] += 1
print(b)