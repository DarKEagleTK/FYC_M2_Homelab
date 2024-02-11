# TP Terraform

## Avant de commencer
Avant de commencer cette partie, assurez vous d'avoir déjà mis en place un environnement terraform.

Vous pouvez donc aller dans notre partie du cours sur les sytèmes devops pour en savoir plus.

## A faire 
Maintenant que vous etes prêt, vous allez devoir pratiquer terraform, ainsi qu'un autre point important lorsqu'on fait de l'informatique : la recherche d'information.

Vous allez donc devoir faire, avec terraform, de la création de machine virtuelle sur votre environnement proxmox.<br>
Il vous faudra remplir les prérequis suivant dans le cadre de ce TP : 
- Vous devez séparer votre projet dans différents fichier. Par exemple, les variables ne doivent pas être dans le même fichier que les informations du provider.
- Vous devez utiliser un maximum le système de variable. Le but est de pouvoir lancer plusieurs fois le meme terraform, en changeant simplement les variables des ressources pour la VM.
- Les ressources de la VM créé seront de : 
    - CPU : 2 coeurs
    - RAM : 2Go
    - Disque : 20go
- Vous devez pouvoir configurer l'adresse IP de votre machine
- Vous devez integrer votre clé ssh dans la machine

<br>

Il vous sera demander de rendre sur la plateforme un compte rendu de votre TP, avec des captures d'écrans et des explications des systèmes que vous allez utiliser.

Maintenant, à vos claviers, et à vous de jouer !!