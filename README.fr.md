# PBZ Auto Sprint

[🇬🇧 English](README.md) · [🇵🇱 Polski](README.pl.md) · **🇫🇷 Français** · [🇪🇸 Español](README.es.md) · [🇺🇦 Українська](README.uk.md)

Un mod d'accessibilité pour **Phantom Blade Zero** (PC) qui **maintient le sprint à votre place** quand vous courez,
et s'arrête tout seul avant les ennemis et en combat.

> ♿ **Ce mod a été créé en pensant aux personnes en situation de handicap moteur.** Explorer, c'est maintenir une touche
> pendant de longues minutes. Si c'est fatigant, douloureux ou impossible pour vous, le mod le fait : vous n'avez qu'à diriger.

> ⚠️ **Une version officielle du jeu, achetée légalement, est nécessaire pour que le mod fonctionne.**

Fonctionne bien avec [**PBZ Auto Parry & Dodge**](https://github.com/Muspelion/PBZ-AutoParryDodge) et
[**PBZ Auto Weapon Switch**](https://github.com/Muspelion/PBZ-AutoWeaponSwitch). Chaque mod peut être installé seul.

---

## ✨ Ce que fait le mod

- **Sprinte quand vous courez** – au sol, hors combat, sauf si vous vous faufilez ou marchez. Vous choisissez la direction.
- **S'arrête à 20 m d'un ennemi** à votre niveau, pour ne pas foncer dans un groupe.
  Le sprint revient au-delà de 23 m.
- **Ne sprinte jamais en combat.**
- Les ennemis sur un autre niveau (plus de 3 m au-dessus ou en dessous) sont ignorés.
- **Messages à l'écran** – au chargement, à l'appui sur la touche et quand un ennemi arrête le sprint
  (par exemple *« Auto Sprint: running - enemy 19 m »*).
- **Votre réglage est conservé** entre les sessions.
- **Le jeu n'est pas modifié** – le mod ajoute seulement des fichiers à côté du jeu.

Le sprint n'utilise pas le Shachi et ne ralentit pas sa récupération (mesuré en jeu : 75 secondes de sprint avec le
Shachi plein) ; le mod n'a donc pas besoin de le gérer.

### Résultats des tests (version Steam)

| Situation | Résultat |
|---|---|
| Course sans ennemi proche | Vitesse de sprint complète (750) |
| Course vers des ennemis | Sprint arrêté 4 fois sur 4 à 18,8–19,9 m |
| Éloignement des ennemis | Sprint revenu dès 24 m, sans clignotement à la limite |
| Combat | Aucun sprint pendant tout le combat |

## 📋 Configuration requise

- Une **copie officielle** de Phantom Blade Zero pour PC (Windows 10/11).
  - **Steam** – testé ✅
  - **Epic Games Store** – pris en charge par l'installateur, pas encore testé
  - **GOG** – le jeu n'est pas sur GOG pour l'instant ; l'installateur le trouvera s'il y apparaît
- Une connexion Internet lors de la première installation (l'installateur télécharge
  [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS), le chargeur de mods gratuit, s'il n'est pas déjà installé).
- Le jeu est **uniquement solo** et n'a pas d'anti-triche. Ce mod ne touche ni au DRM ni aux fonctions en ligne.

## 🚀 Installation facile (recommandée)

1. Téléchargez **`PBZ-AutoSprint-v1.0.0.zip`** depuis la page [**Releases**](../../releases/latest).
2. Décompressez le zip n'importe où (par exemple sur le Bureau).
3. **Fermez le jeu.**
4. Double-cliquez sur **`install.bat`**.
   - Si Windows affiche *« Windows a protégé votre ordinateur »*, cliquez sur
     **Informations complémentaires → Exécuter quand même** (l'installateur est un simple script texte).
5. Quand **Done!** s'affiche, fermez la fenêtre.
6. Lancez le jeu normalement. Après le chargement d'une sauvegarde, vous verrez : `Auto Sprint: ON`

Si le jeu n'est pas trouvé automatiquement, l'installateur demande le dossier du jeu :
Steam → clic droit sur Phantom Blade Zero → **Gérer → Parcourir les fichiers locaux** ;
Epic → Bibliothèque → **⋯ → Gérer → Dossier d'installation**.

Si un autre mod PBZ est déjà installé, l'installateur garde son UE4SS et ajoute seulement ce mod.

## 🎮 Commandes

| Touche | Action |
|---|---|
| **F5** | Sprint automatique ON / OFF |

Le changement s'affiche à l'écran et est enregistré automatiquement. Votre touche de sprint fonctionne comme d'habitude.

## 🗑️ Désinstallation

Fermez le jeu et double-cliquez sur **`uninstall.bat`**. Le mod est supprimé. UE4SS n'est supprimé que si cet
installateur l'a installé **et** qu'aucun autre mod PBZ ne l'utilise encore (une question vous est posée).

## 🔧 Installation manuelle (avancée)

1. Ouvrez le dossier du jeu qui contient le gros `PBZ.exe` (Steam : `…\steamapps\common\PBZ\platform\steam\`).
2. Si UE4SS n'est pas encore installé : téléchargez le dernier `UE4SS_v…zip` (pas `zDEV-…`) depuis
   [UE4SS experimental-latest](https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/experimental-latest)
   et décompressez-le à cet endroit (`dwmapi.dll` et le dossier `ue4ss` à côté de `PBZ.exe`).
3. Copiez le contenu du dossier `ue4ss-config` de ce paquet dans le dossier `ue4ss`.
4. Copiez le dossier `mod\PBZAutoSprint` dans `ue4ss\Mods\`.
5. Ouvrez `ue4ss\Mods\mods.txt` et ajoutez la ligne `PBZAutoSprint : 1` au-dessus de la ligne `Keybinds`.

## ❓ Dépannage

- **Aucun message après le chargement** → vérifiez que `ue4ss\Mods\mods.txt` contient `PBZAutoSprint : 1`
  et consultez `ue4ss\UE4SS.log`.
- **Le personnage ne sprinte pas** → vérifiez le message après F5 (il doit indiquer ON) et qu'aucun ennemi n'est proche.
  Le sprint reste aussi désactivé quand vous vous faufilez ou marchez.
- **Le jeu ne démarre pas ou plante au lancement** → lancez `uninstall.bat` (ou supprimez `dwmapi.dll` à côté de
  `PBZ.exe`). Une mise à jour du jeu peut nécessiter une nouvelle version du mod.
- **Autre problème** → dans `ue4ss\Mods\PBZAutoSprint\Scripts\main.lua`, remplacez `log = false` par
  `log = true`, jouez, puis joignez `autosprint.log` à une [issue](../../issues).

## ⚙️ Fonctionnement (en bref)

Le jeu n'a pas de fonction « commencer à sprinter » : seul le bouton de sprint le contrôle. Quand les règles le
permettent, le mod appuie sur ce bouton à chaque image via le système d'entrée du jeu, comme une touche maintenue.
Dix fois par seconde, il vérifie votre vitesse, votre état et la distance à l'ennemi le plus proche.
Le mod est un script Lua pour [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) ; il ne contient aucun fichier du jeu.

## 🙏 Remerciements

- [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) (MIT).
- Configuration UE4SS de Phantom Blade Zero – [KintaroModding](https://github.com/KintaroModding),
  [UE4SS-RE/RE-UE4SS#1484](https://github.com/UE4SS-RE/RE-UE4SS/pull/1484) ; motifs de signatures de l'équipe UE4SS (MIT).
- Réalisé avec l'aide de **Claude Code** (l'IA Claude d'Anthropic) ; tous les résultats ont été testés en jeu.

## 📄 Licence et avertissement

Code : [licence MIT](LICENSE). Projet de fan non officiel, sans lien avec S-GAME.
Phantom Blade Zero est une marque de S-GAME. À utiliser à vos risques – sauvegardez vos fichiers de sauvegarde.

Historique des versions : [CHANGELOG](CHANGELOG.md).
