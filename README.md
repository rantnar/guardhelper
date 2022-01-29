# guardhelper

### Instalacja

`/zainstaluj_plugin https://codeload.github.com/eldakar/guardhelper/zip/main`

### Konfiguracja

`/cset guardhelper.respect_attack_flags=true` - jezeli prowadzimy druzyne i jestesmy najbardziej atakowanym celem, flagi AWR beda respektowane przy wskazywaniu siebie.

### Uzycie

Alias do klawisza: `guardhelper:za_func()`

### Opis

Skrypt wyswietla najbardziej poranionego, ktory jest atakowany przez najwieksza ilosc przeciwnikow.

Funkcja zaslony, ktora nalezy wprowadzic pod jakis klawisz, probuje zaslonic ranna osobe. Puszczanie zaslon uzywa standardowej flagi.
Jesli jestesmy celem, nic sie nie dzieje, chyba ze konfig wyzej jest ustawiony na `true`.

### TODO
Legionista
Wyswietlanie prowadzacego
Oddzielne klawisze na rannego i atakowanego (moze)
