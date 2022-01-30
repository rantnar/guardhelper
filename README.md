# guardhelper

### Opis

Skrypt daje mozliwosc wyswietlania w oknie kondycji nastepujacych stanow druzyny:
* najbardziej poraniony
* najbardziej atakowany
* najbardziej optymalny do zasloniecia, bazujac na dwoch powyzszych wartosciach

Funkcja zaslony, ktora nalezy wprowadzic pod jakis klawisz, probuje zaslonic ranna osobe. Puszczanie zaslon uzywa standardowej flagi.

Tarcza na kims:

![Screenshot from 2022-01-29 21-29-33](https://user-images.githubusercontent.com/11772152/151678164-d1c45e05-3c45-44d4-9559-9750ece10819.png)

Tarcza na sobie:

![Screenshot from 2022-01-29 21-28-45](https://user-images.githubusercontent.com/11772152/151678172-c3009bdc-6132-47c8-9b10-0d5af0c3206e.png)

### Instalacja

`/zainstaluj_plugin https://codeload.github.com/eldakar/guardhelper/zip/main`

### Konfiguracja

`/cset guardhelper.respect_attack_flags=true` - jezeli prowadzimy druzyne, flagi AWR beda respektowane przy wskazywaniu i rozkazywaniu obrony.

### Uzycie

Alias do klawisza: `guardhelper:za_func()`

![Screenshot from 2022-01-29 22-08-12](https://user-images.githubusercontent.com/11772152/151679101-21a12332-bc74-4954-9cbd-8b8c9a1c8b3f.png)


### TODO
* Legionista
* Wyswietlanie prowadzacego

* Mozliwosc wskazywania zaslon bez zaslaniania samemu
