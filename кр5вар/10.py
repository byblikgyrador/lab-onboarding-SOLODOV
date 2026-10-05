word1 = input()
word2 = input()
letters = word1 + word2
vowels = 'аеёиоуыэюя'
v = ''
c = ''
for letter in letters.lower():
    if letter in vowels:
        v += letter
    else:
        c += letter
result = v + c
print(f'Получившаяся строка: {result}\nГласных: {len(v)}\nСогласных: {len(c)}')
