# Petersoni algoritm OCamlis

See projekt rakendab ja verifitseerib Petersoni algoritmi OCamlis. Implementatsioon sisaldab mudelkontrollijat, et tagada algoritmi korrektne toimimine, vältimaks mõlema lõime samaaegset kriitilisse sektsiooni sisenemist.

## Petersoni algoritm

Petersoni algoritm on paralleelprogrammeermise algoritm, mis tagab, et kaks või enam protsessi ei kasuta samaaegselt ühiskasutatavat ressurssi. See algoritm tagab, et kaks protsessi ei viibi samaaegselt oma kriitilises sektsioonis.

### Seisund

- `flag1`, `flag2`: Näitavad, kas lõim 1 või lõim 2 soovib siseneda kriitilisse sektsiooni.
- `turn`: Näitab, kummal lõimel on eesõigus siseneda kriitilisse sektsiooni.
- `critical1`, `critical2`: Näitavad, kas lõim 1 või lõim 2 on kriitilises sektsioonis.

### Funktsioonid
- `step`: Simuleerib lõime sammu kriitilisse sektsiooni sisenemiseks.
- `leave_critical`: Simuleerib lõime lahkumist kriitilisest sektsioonist.
- `is_error`: Kontrollib, kas mõlemad lõimed on samaaegselt kriitilises sektsioonis.
- `model_check`: Rekursiivselt kontrollib süsteemi seisundite üleminekuid algoritmi verifitseerimiseks.

## Failid

- `bin/main.ml`: Peamine käivituspunkt mudelkontrolli käivitamiseks.
- `lib/peterson.ml`: Petersoni algoritmi ja mudelkontrolli implementatsioon.
- `test/test_peterson.ml`: Petersoni algoritmi implementatsiooni testid.

## Ehitamine ja testimine

### Eeltingimused

- [OPAM-i](https://opam.ocaml.org/doc/Install.html) paigaldamine
- OCaml (versioon 4.14.0) paigaldamine

### Sammud

1. Initsialiseeri OPAM ja kasuta OCaml 4.14.0 versioonile:
   
   `opam init`
   `opam switch create 4.14.0`
   `eval $(opam env)`

2. Paigalda sõltuvused:

    `opam install dune alcotest`

3. Ehitamine:

    `dune build`

4. Peaprogrammi käivitamine:

    `dune exec peterson_project`

5. Testide täitmine:

    `dune runtest`





