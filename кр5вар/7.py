text = input()
result = ''
count = 1
for i in range(len(text)):
    if i + 1 < len(text) and text[i] == text[i + 1]:
        count += 1
    else:
        result += str(count) + text[i]
        count = 1
compression = len(text) / len(result)
print(f'Исходная строка: {text}\nЗакодированная строка: {result}\nКоэффициент сжатия: {compression:.2f}')