n = int(input())
summa = 0
prostye = 0
for i in range(1, n + 1):
    for j in range(1, n + 1):
        x = i * j
        print(f'{i} x {j} = {x}')
        summa += x
        if x > 1:
            prostoe = True
            for k in range(2, int(x ** 0.5) + 1):
                if x % k == 0:
                    prostoe = False
                    break
            if prostoe:
                prostye += 1
print(f'Сумма: {summa}\nПростых чисел: {prostye}')