# Bytepace Architecture

### VIP + ROUTER

- Каждый модуль имеет следующие файлы:

    - **Fabric** - используется для создания модуля, сюда прокидываются данные, которые мы будем передавать на следующий экран. Используется во Flow, чтобы создать экран и использовать его для роутинга
        ```
        Например, при переходе на экран профиля, передаем id в этот слой, как параметр
        ```
        ```
        let vc = ExampleFabric.assembledScreen(id: id)
        navigationController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.stepper))
        ```
        
        - **Interactor** - используется для работы с сервисами, вся логика с загрузкой, обновлением данных происходит через данный слой. 
            Для работы с сетевым слоем используем отдельные сервисы, которые работают с Moya и возвращают результат 
        ```
        Например, при работе с Realm, чтобы не работать с RealmObject желательно использовать мапперы, этот модуль будет работать и с RealmObject и с конвертированными объектами, но отдавать будет только конвертированные объекты
        ```
        
    - **Presenter** - используется для биндинга данных ко view. Для работы с View используем протокол. Данный биндинг происходит через протокол ***IsPresenter***, со следующими полями:
        ```
        protocol IsPresenter {
            associatedtype Input
            associatedtype Output

            func bindInput(_ input: Input)
            func configureOutput(_ input: Input) -> Output

            func buildOutput(with input: Input) -> Output
        }
        ```
        ***
        В input складываем действия, которые будут обрабатываться. В output складываем Driver элементы, которые мы будем биндить уже к UI
        
    - **View** - используется для создания экрана, имеет доступ только к ***протоколу презентера***. В данном объекте будут храниться UI элементы и биндинги
    
    - **ViewController** - используется для хранения view
    
    - **Router** - слой, для навигации по приложению, для навигации используется [RxFlow](https://github.com/RxSwiftCommunity/RxFlow). О навигации знает ***презентер этого модуля***
---
### Структура

### Структура представлена на изображении ниже:
![](https://miro.medium.com/max/2862/1*-Mfew6qvLQ-t-DSOkY23Aw.png)
1. View общается с Presenter через протокол
2. Presenter может давать следующий навигационный шаг роутеру и просить данные из interactor, выдавать UI bindings во View
3. Interactor общается с сервисами/базой данных

### Ссылки на объекты:
1. ViewController имеет ссылку на протокол ***Stepper из presenter***, чтобы делать роутинг через presenter и не иметь доступа к другим объектам presenter'а. Также ViewController имеет ссылку на ***view***, чтобы сделать override loadView. 
Stepper - объект, который эмитит шаги во Flow, т.е производит роутинг между экранами [больше информации](https://github.com/RxSwiftCommunity/RxFlow)
2. View имеет ссылку на ***presenter protocol***, чтобы обновлять UI, делать роутинг по нажатию на кнопки
3. Presenter имеет ссылку на ***interactor*** и может общаться с View через ***Protocol***
4. Interactor имееты ссылки на сервисы и хранит в себе состояние, которое используем в ***presenter***

---

## Зависимости


### UI

Для создания UI используется [PinLayout](https://github.com/layoutBox/PinLayout). 


### Assets

Для работы с ассетами используется [R.swift](https://github.com/mac-cain13/R.swift)
При работе с цветами из ассетов, стоит написать wrapper, т.к возвращаются UIColor типа optional


### Networking

Для работы с сетевым слоем используется [Moya](https://github.com/Moya/Moya)


### Database

Для работы со слоем хранения используется [Realm](https://realm.io/docs/swift/latest)
