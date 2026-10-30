# PBZ Auto Sprint

[🇬🇧 English](README.md) · **🇵🇱 Polski** · [🇫🇷 Français](README.fr.md) · [🇪🇸 Español](README.es.md) · [🇺🇦 Українська](README.uk.md)

Mod ułatwień dostępu do **Phantom Blade Zero** (PC), który **trzyma sprint za Ciebie**, gdy biegniesz, i sam przestaje
sprintować przed wrogami i w walce.

> ♿ **Mod został stworzony z myślą o osobach z niepełnosprawnością ruchową.** Eksploracja to minuty trzymania jednego
> przycisku. Jeśli jest to dla Ciebie męczące, bolesne lub niemożliwe, mod zrobi to za Ciebie – Ty tylko kierujesz postacią.

> ⚠️ **Do działania moda potrzebna jest oficjalna, legalnie zakupiona wersja gry.**

Dobrze działa razem z [**PBZ Auto Parry & Dodge**](https://github.com/Muspelion/PBZ-AutoParryDodge) i
[**PBZ Auto Weapon Switch**](https://github.com/Muspelion/PBZ-AutoWeaponSwitch). Każdy mod można zainstalować osobno.

---

## ✨ Co robi

- **Sprintuje, gdy biegniesz** – po ziemi, poza walką, o ile się nie skradasz i nie idziesz. Kierunek wybierasz Ty.
- **Zatrzymuje sprint 20 m przed wrogiem** na Twoim poziomie, żebyś nie wbiegł w grupę pełnym pędem.
  Sprint wraca, gdy oddalisz się na ponad 23 m.
- **Nigdy nie sprintuje w walce.**
- Wrogowie na innym poziomie (ponad 3 m wyżej lub niżej) są ignorowani.
- **Komunikaty na ekranie** – po wczytaniu zapisu, po naciśnięciu klawisza i gdy wróg zatrzyma sprint
  (np. *„Auto Sprint: running - enemy 19 m”*).
- **Ustawienie jest zapamiętywane** między uruchomieniami gry.
- **Gra nie jest modyfikowana** – mod tylko dodaje pliki obok gry.

Sprint nie zużywa Shachi i nie spowalnia jego odnawiania (pomiar w grze: 75 sekund sprintu przy pełnym Shachi),
więc mod nie musi niczego liczyć w związku z Shachi.

### Wyniki testów (wersja Steam)

| Sytuacja | Wynik |
|---|---|
| Bieg bez wrogów w pobliżu | Pełna prędkość sprintu (750) |
| Bieg w stronę wrogów | Sprint gasł 4 razy na 4 przy 18,8–19,9 m |
| Oddalanie się od wrogów | Sprint wracał od 24 m, bez migania przy granicy |
| Walka | Brak sprintu przez całą walkę |

## 📋 Wymagania

- **Oficjalna kopia** Phantom Blade Zero na PC (Windows 10/11).
  - **Steam** – przetestowane ✅
  - **Epic Games Store** – obsługiwane przez instalator, jeszcze nieprzetestowane
  - **GOG** – gry obecnie nie ma na GOG; instalator ją znajdzie, jeśli się tam pojawi
- Internet przy pierwszej instalacji (instalator pobiera [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS),
  darmowy loader modów do gier na Unreal Engine – chyba że jest już zainstalowany).
- Gra jest **tylko dla jednego gracza** i nie ma anty-cheata. Mod nie dotyka DRM ani funkcji online.

## 🚀 Łatwa instalacja (zalecana)

1. Pobierz **`PBZ-AutoSprint-v1.0.0.zip`** ze strony [**Releases**](../../releases/latest).
2. Rozpakuj zip w dowolnym miejscu (np. na Pulpicie).
3. **Zamknij grę.**
4. Kliknij dwukrotnie **`install.bat`**.
   - Jeśli Windows pokaże *„System Windows ochronił ten komputer”*, kliknij **Więcej informacji → Uruchom mimo to**
     (instalator to zwykły skrypt tekstowy – możesz otworzyć `install.ps1` w Notatniku i go przeczytać).
5. Gdy pojawi się **Done!**, zamknij okno.
6. Uruchom grę normalnie. Po wczytaniu zapisu zobaczysz: `Auto Sprint: ON`

Jeśli gra nie zostanie znaleziona automatycznie, instalator zapyta o folder gry:
Steam → prawy klik na Phantom Blade Zero → **Zarządzaj → Przeglądaj pliki lokalne**;
Epic → Biblioteka → **⋯ → Zarządzaj → Folder instalacji**. Skopiuj ścieżkę i wklej ją w oknie instalatora.

Jeśli inny mod PBZ jest już zainstalowany, instalator zostawia jego UE4SS i tylko dodaje ten mod.

## 🎮 Sterowanie

| Klawisz | Działanie |
|---|---|
| **F5** | Auto sprint WŁ. / WYŁ. |

Zmiana jest pokazywana na ekranie i zapisywana automatycznie. Twój własny przycisk sprintu działa jak zwykle.

## 🗑️ Odinstalowanie

Zamknij grę i kliknij dwukrotnie **`uninstall.bat`**. Usuwa mod. UE4SS jest usuwany tylko wtedy, gdy
zainstalował go ten instalator **i** żaden inny mod PBZ już go nie używa (najpierw zostaniesz zapytany).

## 🔧 Instalacja ręczna (zaawansowana)

1. Otwórz folder gry z dużym plikiem `PBZ.exe` (Steam: `…\steamapps\common\PBZ\platform\steam\`).
2. Jeśli UE4SS nie jest jeszcze zainstalowany: pobierz najnowszy `UE4SS_v…zip` (nie `zDEV-…`) z
   [UE4SS experimental-latest](https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/experimental-latest)
   i rozpakuj go tam, tak żeby `dwmapi.dll` i folder `ue4ss` leżały obok `PBZ.exe`.
3. Skopiuj zawartość folderu `ue4ss-config` z tej paczki do folderu `ue4ss`
   (`MemberVariableLayout.ini` i folder `UE4SS_Signatures`). Gra potrzebuje tej konfiguracji, żeby UE4SS działał.
4. Skopiuj folder `mod\PBZAutoSprint` do `ue4ss\Mods\`.
5. Otwórz `ue4ss\Mods\mods.txt` i dodaj linię `PBZAutoSprint : 1` nad linią `Keybinds`.

## ❓ Rozwiązywanie problemów

- **Brak komunikatu po wczytaniu zapisu** → sprawdź, czy `ue4ss\Mods\mods.txt` zawiera `PBZAutoSprint : 1`,
  i zajrzyj do `ue4ss\UE4SS.log`.
- **Postać nie sprintuje** → sprawdź komunikat po F5 (ma być ON) i czy w pobliżu nie ma wroga. Sprint jest też
  wyłączony przy skradaniu i chodzeniu.
- **Gra się nie uruchamia lub crashuje przy starcie** → uruchom `uninstall.bat` (albo usuń `dwmapi.dll` obok
  `PBZ.exe`). Aktualizacja gry może zmienić kod, którego potrzebuje UE4SS; sprawdź tę stronę, czy jest nowa wersja.
- **Coś innego nie działa** → otwórz `ue4ss\Mods\PBZAutoSprint\Scripts\main.lua` w Notatniku, zmień
  `log = false` na `log = true`, zagraj i dołącz `autosprint.log` (z folderu moda) do [zgłoszenia](../../issues).

## ⚙️ Jak to działa (krótko)

Gra nie ma funkcji „zacznij sprintować”: sprintem steruje wyłącznie przycisk. Gdy reguły na to pozwalają, mod naciska
ten przycisk w każdej klatce przez system wejścia gry, dokładnie jak trzymany klawisz. Dziesięć razy na sekundę sprawdza
prędkość, stan postaci i odległość do najbliższego wroga. Mod to skrypt Lua dla
[UE4SS](https://github.com/UE4SS-RE/RE-UE4SS); nie zawiera żadnych plików gry.

## 🙏 Podziękowania

- [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) – system skryptów do Unreal Engine (MIT).
- Konfiguracja UE4SS dla Phantom Blade Zero (`MemberVariableLayout.ini`, sygnatury) –
  [KintaroModding](https://github.com/KintaroModding), zgłoszona jako
  [UE4SS-RE/RE-UE4SS#1484](https://github.com/UE4SS-RE/RE-UE4SS/pull/1484); wzorce sygnatur z konfiguracji
  zespołu UE4SS (MIT).
- Stworzony z pomocą **Claude Code** (AI Claude firmy Anthropic), który przeanalizował logikę gry
  i napisał mod razem z autorem; wszystkie wyniki sprawdzono w prawdziwej grze.

## 📄 Licencja i zastrzeżenia

Kod: [licencja MIT](LICENSE). To nieoficjalny projekt fanowski, niezwiązany z S-GAME ani przez nią niepopierany.
Phantom Blade Zero jest znakiem towarowym S-GAME. Używasz na własne ryzyko – zrób kopię zapasową zapisów gry.

Historia wersji: [CHANGELOG](CHANGELOG.md).
