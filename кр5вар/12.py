text = input('Введите текст на русском: ')
letters = {
    'а':'a', 'б':'b', 'в':'v', 'г':'g', 'д':'d',
    'е':'e', 'ж':'zh', 'з':'z', 'и':'i', 'й':'y',
    'к':'k', 'л':'l', 'м':'m', 'н':'n', 'о':'o',
    'п':'p', 'р':'r', 'с':'s', 'т':'t', 'у':'u',
    'ф':'f', 'х':'kh', 'ц':'ts', 'ч':'ch', 'ш':'sh',
    'щ':'sch', 'ъ':' \ ', 'ы':'y', 'ь':'', 'э':'e',
    'ю':'yu', 'я':'ya'
}
result = ''
for symbol in text.lower():
    if symbol in letters:
        result += letters[symbol]
    else:
        result += symbol
percent = (len(result) - len(text)) / len(text) * 100
print(f'Транслитерация: {result}\nДлина транслитерации: {len(result)}\nТранслитерация длиннее на: {percent:.2f}%')
