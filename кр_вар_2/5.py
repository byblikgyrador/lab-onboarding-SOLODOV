a = int(input())
b = 0
if a > 1000000:
    b = 0.20
elif a >= 500000:
    b = 0.15
else:
    b = 0.10
print(f'{a}\n{a+a*b}')