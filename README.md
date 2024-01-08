<style>
    .center-img {
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
</style>

<div style="text-align:center; font-size: 40px; margin-top: 400px">Labo 3 VSE</div>
<div style="text-align:center; font-size: 40px; margin-top: 15px"></h1>
<div style="text-align:center; font-size: 18px; margin-top: 50px">07.01.2023</h3>
<div style="text-align:center; font-size: 18px; margin-top: 5px">Miguel JALUBE</h3>
<div style="text-align:center; font-size: 18px; margin-top: 5px">Leandro SARAIVA MAIA</h3>

<div style="page-break-after: always"></div>

# Contexte

## Objectif


## Description du composant



<div style="page-break-after: always"></div>

## Chronogramme de fonctionnement


# Plan de vérification

| Test case       | Priority | Test                                                                                               | Verification criteria                           |
|-----------------|----------|----------------------------------------------------------------------------------------------------|-------------------------------------------------|
| Random          | 1        | Génère des datas aléatoires                                                                        | Min, max, avg correct                           |
| Ascending       | 1        | Génère des datas croissantes (0, 1, 2, ...)                                                        | Min = 0, Max = WINDOWSIZE, avg = WINDOWSIZE / 2 |
| Full 0          | 1        | Génère des datas contenant que des 0                                                               | Min = 0, Max = 0, Avg = 0                       |
| Full 1          | 1        | Génère des datas contenant que des 1                                                               | Min = 1, Max = 1, Avg = 1                       |
| Edge 1          | 1        | Génère des data contenant des 1 au LSB et au MSB                                                   | Min, max, avg correct selon calcul              |
| Edge 0          | 1        | Génère des data contenant des 0 au LSB et au MSB                                                   | Min, max, avg correct selon calcul              |
| Half 0 half 1   | 1        | Génère des datas contenant 50% de 0 et 50% de 1                                                    | Min, max, avg correct selon calcul              |
| Half 1 half 0   | 1        | Génère des datas contenant 50% de 1 et 50% de 0                                                    | Min, max, avg correct selon calcul              |
| Alternate 1 0   | 1        | Génère des datas contenant 1 puis 0 puis 1 puis 0 ...                                              | Min, max, avg correct selon calcul              |
| Alternate 0 1   | 1        | Génère des datas contenant 0 puis 1 puis 0 puis 1 ...                                              | Min, max, avg correct selon calcul              |

# Asserts

| Assert | Errno 0 | Errno 1 | Errno 2 | Errno 10 | Errno 11 | Errno 12 | Errno 13 | Errno 14 | Errno 15 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| Si frame_o passe de 0 à 1, cela implique que frame_o est égal à valid_o pendant 3 cycles | PASS | PASS | PASS | FAIL | INACTIVE | FAIL | PASS | PASS | PASS |
| Si valid_i passe de 0 à 1, cela implique que valid_i est égal à ready_o pendant `WINDOWSIZE` cycles | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS |


<div style="page-break-after: always"></div>

# Erreurs relevées
## ERRNO 0, 1 et 2
Aucune erreur car ce sont des cas d'utilisation différents du composant.

## ERRNO 10
valid_o est tout le temps à 0.  
Il devrait rester pendant 3 cycles à 1 lorsque frame_o est actif.

## ERRNO 11
frame_o est tout le temps à 0.  
Il devrait être actif jusqu'à ce que ready_o est été actif pendant 3 cycles.  
ready_o est actif pendant 3 cycles, cependant comme frame_o reste à 0, cela n'est pas compté.  
Dans notre cas, l'assertion ne peut même pas débuter car elle commencer à un flanc montant de frame_o.  

## ERRNO 12
Même problème que pour errno 10  

valid_o est tout le temps à 0.  
Il devrait rester pendant 3 cycles à 1 lorsque frame_o est actif.

## ERRNO 13

## ERRNO 14

## ERRNO 15
