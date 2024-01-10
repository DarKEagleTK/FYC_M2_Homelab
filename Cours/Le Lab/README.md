## A. - Les technologies présentées

Lors de cette partie du cours, nous allons vous présenter les différents systèmes que nous avons choisi d’installer sur notre HomeLab.

Pour chaque technologie que nous allons présenter, le cours sera en deux parties : une partie théorique qui présentera le système global via une technologie associée, et l’installation et configuration de cette technologie sur notre infrastructure. Comme nous ne vous présentons qu’une des différents chemins que vous pouvez emprunter, chaque catégorie aura des recommandations supplémentaires vers d’autres technologies avec les liens vers les documentations pour que vous puissiez aussi trouver par vous-même des solutions qui vous conviennent.

Nous allons donc vous présenter : 

- La virtualisation via : 
  - Les hyperviseurs
  - Les superviseurs
  - L'environnement Docker

- Le stockage via : 
  - Les NAS
  - Les SANs

- Les services installables pour le bon fonctionnement de l’infrastructure : 
  - Firewall (physique ou logiciels)
  - Les VPNs
  - Les outils DevOps
  - Le monitoring
    - Grafana
    - Prometheus
    - UptimeKuma

- Un dashboard de centralisation : 
  - Homer

Maintenant que vous avez une idée globale  de ce que nous allons faire dans ce cours, armez-vous de patience et de vos claviers, et suivez-nous dans l’élaboration de votre premier homelab !

## B. - La virtualisation

#### 1. - Présentation
Comme vous avez pu le voir dans notre partie Rappel, la virtualisation est un point important voir central dans l’informatique moderne. Il est donc important de comprendre les concepts de la virtualisation et de la mettre en place dans notre homelab.
Nous allons donc voir ensemble l'installation d'un hyperviseur et de sa configuration. Dans la même lancé, nous installerons un systeme de conteneurisation pour installer certains de nos services sous un format de docker.

Avant de commencer, il est important de comprendre ce que vous voulez faire avec vos conteneurs ou vos machines virtuelles. Un certain nombre de service propose des conteneurs déjà presque entierement configurer, et c'est l'un des gros avantages de cette technologies, mais dans un but d'apprentissage, il est parfois interessant d'installer les services manuellement sur une machine virtuelle, ou de monter sa propre image de conteneur pour comprendre comment ces services fonctionnent.

Pour ce cours, nous avons choisi de vous présenter l'hyperviseur proxmox et le système de conteneurisation docker.
Nous porterons nos attentions sur ces différents points : 

- L'installation de notre proxmox et de notre environnement docker.
- La configuration basique de notre proxmox :
    - configuration du stockage
    - Configuration d'utilisateurs/groupes et gestions des droits associée à ces comptes/groupes
    - Configuration du/des réseaux
    - Création de machines virtuelles
- Les bonnes pratiques en termes de virtualisation :
    - Mise en place de templates
    - Cloud init
    - Connexion via clé SSH

Les prérequis pour cette partie du cours sont : 
- un ordinateur avec une connexion internet
- une clé usb 8go
- notre machine qui deviendra le serveur. Il sera donc nécessaire d'avoir effectuer les manipulations possible présenter dans la section `Hardware`.

Concernant la machine serveur :
- Cpu : Il est indispensable d'avoir un processeur mutlicoeurs supportant la virtualisation. Pour le nombre de coeurs, il en faut au minimum 2, même si cela ne vous permettra pas de faire grand chose. La recommendation serait donc d'avoir un processeur 4 coeurs ou plus.
- Ram : Le minimum requis en terme de mémoire RAM est de 2go. Cependant, de même que pour le CPU, vous ne pourrez pas faire grand chose de cette manière, et certain OS ne pourrons pas être installer par manque de RAM (exemple: windows qui demande environ 4go de ram minimum). Je vous conseillerai de partir sur du 4go au minimum, et je vous recommenderai d'avoir 8go pour avoir un peu de marge.
- Stockage : Il est recommender d'avoir plusieurs disques, dont un petit (entre 128 et 256 go) que nous utiliserons pour installer l'OS proxmox, et un second plus gros qui servira de stockage pour les disques des machines virtulles.
- Réseau : Il faut nécessairement une carte réseau pour permettre à vos machines d'avoir accès à internet. Il est donc forcement recommender d'avoir une interface Gigabit.

#### 2. - Installation de l’hyperviseur

Pour l'installation de notre proxmox, nous allons commencer par télécharger sur notre ordinateur l'iso de proxmox et rufus, un utilitaire pour intaller cet iso sur une clé usb bootable.
- ![Proxmox](https://enterprise.proxmox.com/iso/proxmox-ve_8.1-1.iso)
- ![Rufus](https://github.com/pbatard/rufus/releases/download/v4.3/rufus-4.3.exe)

Une fois ces deux éléments télécharger, lancez l'éxécutable rufus. Dans l'onglet `device`, sélectionnez votre clé usb. Point d'attention si vous avez plusieurs disques ou clé usb connceté sur votre ordinateur a ce moment la, mais l'installation de l'ISO sur votre clé procedera à un formatage, donc a la perte de l'ensemble des données présente sur cette clé.
Vous pouvez ensuite spécifier l'ISO de proxmox dans l'onglet `Boot selection`.

![Rufus_exemple](src/rufus.png)


#### 3. - Installation de l’environnement Docker

L'installation de notre hyperviseur effectué, nous pouvons installer notre plateforme Docker, permettant de créer et gérer automatiquement les différentes applications que nous aurons besoin.
Pour cela, nous aurons besoin de créer une VM linux. Ici nous utiliserons Debian comme distributeur de système d'exploitation.

Une fois l'installation de Linux effectué, nous nous connecterons en SSH sur notre propre machine pour plus de fluidité.

Nous allons dans un premier temps installer le référentiel apt de Docker qui nous servira de sources d'installation et de mise à jour de Docker.

Ajout de la clé GPG officiel de Docker :
```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

Ajout du référentiel aux sources APT:
``` bash
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Et enfin nous allons installer docker et ces plugins : 
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Pour vérifier que Docker a bien été installer nous lançons un conteneur test : 
```bash
sudo docker run hello-world
```

L'installation effectué, nous allons le configurer pour que Docker se lance à chaque démarrage système : 
```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

Et pour le désactiver, voici les commandes :
```bash
sudo systemctl disable docker.service
sudo systemctl disable containerd.service
```

#### 4. - Configuration


#### 5. - Pour aller plus loin

## C. - Le stockage

#### 1. - Présentation

#### 2. - Installation de NAS/SAN

#### 3. - Configuration

#### 4. - Pour aller plus loin

## D. - Services

#### 1 - Présentation

#### 2. - Installation/Utilisation du Firewall

#### 3. - Installation/Utilisation d’outils DEVOPS

#### 4. - Installation/Utilisation de NEXTCLOUD

#### 5. - Installation/Utilisation d’un VPN

## E. - Monitorings

#### 1. - Présentation

#### 2. - Installation Grafana/Prometheus/UptimeKuma

#### 3. - Configuration

#### 4. - Pour aller plus loin

## F. - Dashboard

#### 1. - Présentation

#### 2. - Installation Homer
