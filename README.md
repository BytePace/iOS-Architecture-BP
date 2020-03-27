# iOS Clean Architecture [Bytepace]

# Ссылки
[Описание архитектуры](https://github.com/BytePace/Clean-Architecture-BP/blob/master/Bytepace%20Architecture.md)

[Пример](https://github.com/BytePace/Clean-Architecture-BP/tree/master/CA-Github-Example)

### Установка шаблона (единоразово):
    1. Клонируем проект
    2. В папке проекта открываем терминал
    3. Пишем `cp -R BT\ Clean\ Module.xctemplate ~/Library/Developer/Xcode/Templates`
    4. Теперь при создании нового файла есть выбор нашего шаблона

### Создание проекта:
    1. Создаем проект в XCode
    2. Ставим Pod
    3. Добавляем swiftlint POD
    4. В фазе сборке добавляем правила для линта

### Добавление фаз сборки (для каждого проекта):
    1. Клонируем проект
    2. Из папки **Build Phase Scripts** открываем скрипты и копируем команду 
    (для R.swift понадобится указать Input Files и Output Files)

P.S Добавил в папку Utilities протоколы (IsPresenter, ClassIdentifiable, UIView + Extensions) 

### Планы: 
- Добавить расширения над Rx
