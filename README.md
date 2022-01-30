# guardhelper

### Opis

Skrypt daje mozliwosc wyswietlania w oknie kondycji nastepujacych stanow druzyny:
* najbardziej poraniony
![Screenshot from 2022-01-30 15-14-21](https://user-images.githubusercontent.com/11772152/151705552-476bf6e9-092d-410d-a494-387b65a27a53.png)

* najbardziej atakowany
![Screenshot from 2022-01-30 15-15-59](https://user-images.githubusercontent.com/11772152/151705591-dd602378-64c1-49b2-b0c6-054ce6a430e9.png)

* najbardziej optymalny do zasloniecia, bazujac na dwoch powyzszych wartosciach

  - na kims:
![Screenshot from 2022-01-29 21-29-33](https://user-images.githubusercontent.com/11772152/151678164-d1c45e05-3c45-44d4-9559-9750ece10819.png)

  - na sobie:
![Screenshot from 2022-01-29 21-28-45](https://user-images.githubusercontent.com/11772152/151678172-c3009bdc-6132-47c8-9b10-0d5af0c3206e.png)

### Instalacja

`/zainstaluj_plugin https://codeload.github.com/eldakar/guardhelper/zip/main`

### Konfiguracja

> Uwaga! Klawisze nie beda dzialaly, jesli dana funkcja jest wylaczona w konfiguracji.

`/cset guardhelper.show_suggested_target=true/false` - wyswietlaj tarcze sugerowanej brony

`/cset guardhelper.show_most_wounded=true/false` - wyswietlaj najbardziej poranionego

`/cset guardhelper.show_most_attacked=true/false` - wyswietlaj najbardziej atakowanego

`/cset guardhelper.respect_attack_flags=true/false` - jezeli prowadzimy druzyne, flagi AWR beda respektowane przy wskazywaniu i rozkazywaniu obrony.

### Uzycie

`guardhelper:za_func()` - funkcja obrony sugerowanego

`guardhelper:za_func_type("wounded")` - poranionego

`guardhelper:za_func_type("targeted")` - celowanego


Przyklad ustawienia w mudlecie (wcisnij alt+e, a nastepnie **keys**)

![Screenshot from 2022-01-29 22-08-12](https://user-images.githubusercontent.com/11772152/151679101-21a12332-bc74-4954-9cbd-8b8c9a1c8b3f.png)


### TODO
- [ ] Legionista
- [ ] Wyswietlanie prowadzacego
- [x] Rozdzielenie na celowanego i pocietego
- [ ] Mozliwosc wskazywania zaslon bez zaslaniania samemu
