
<h1 align="center">Progtest Tester</h1>
<h4 align="center">Progtest Tester je testovací skript, který se zaměřuje na jednoduchost používání a informativnost.</h4>


Už tě nebaví kontrolovat každý výstup tvého programu ručně? Nevíš, v jakých souborech máš chybu? Nechceš zrácet čas psaním si vlastního testovacího skriptu? **Progtest Tester** se o tebe postará!
## Použití
### Spouštění
Skript se dá spouštět dvěma základními způsoby:

 1. Příkazem `./tester.sh`
 2. Příkazem `tester`

Pro první způsob postačí mít stažený skript v nějaké složce (nejlépe společně s testovacími daty a zdrojovým kódem). Pokud není soubor spustitelný, tak mu stačí nastavit práva pro spuštění příkazem `chmod 755 tester.sh`. Tento způsob není doporučený pokud chceš skript využívat na více místech (např. u více progtestů).

Druhý způsob vyžaduje, abys přidal cestu ke svému skriptu do proměnné `PATH`. Prvně si vytvoř složku (např. se jménem `scripts`) a do ní skript ulož. Odeber příponu (skript se bude jmenovat pouze `tester`). Teď si otevři terminál na konec souboru `.bashrc` (většinout je umístěn v domovském adresáři) napiš `PATH=cesta:$PATH`, kde `cesta` je celá cesta ke skriptu (např. pokud je soubor uložený ve složce `scripts`, která je ještě uložená ve složce `downloads`, pak příkaz bude vypadat např. takto: `PATH=~/downloads/scripts:$PATH`). Teď by měl být skript použitelný odkudkoli.

### Přepínače a argumenty
Skript má následující rozhraní: `tester [option1] [arg1] [option2] [arg2] ...`

`-t PATH_TO_BIN` - Specifikuje cestu k binárnímu souboru. Není potřeba psát, pokud se soubor pojmenovaný `a.out` nachází ve stejné složce, ze které je skript spuštěn.

`-i PATH_TO_INPUT_FILES` - Specifikuje cestu ke vstupním souborům. Soubory musí být na konci pojmenovány `_in.txt`, kde na začátku by mělo být číslo vstupu (např. `0000_in.txt`). Není potřeba psát, pokud se složka `sample/CZE` (defaultní složka progtestových dat) nachazí ve stejné složce, ze které je skript spouštěn. 

`-o PATH_TO_OUTPUT_FOLDER` - Specifikuje složku, do které budou uloženy výstupní data. Tento přepínač musí být použit s přepínačem `-k`. Pokud není složka specifikována, budou data uloženy do složky `$PWD/outputs`, tedy do složky `outputs`, která se vytvoří ve složce, ze které je skript spouštěn.

`-k` - Pokud je tento přepínač použit, pak se výstupní data zachovají. V opačném případě se automaticky smažou.

### Ukázky použití
