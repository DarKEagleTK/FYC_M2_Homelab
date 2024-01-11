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

Les prérequis pour cette partie du cours sont : 
- un ordinateur avec une connexion internet
- une clé usb 8go
- notre machine qui deviendra le serveur

Pour l'installation de notre proxmox, nous allons commencer par télécharger sur notre ordinateur l'iso de proxmox et rufus, un utilitaire pour intaller cet iso sur une clé usb bootable.
- ![Proxmox](https://enterprise.proxmox.com/iso/proxmox-ve_8.1-1.iso)
- ![Rufus](https://github.com/pbatard/rufus/releases/download/v4.3/rufus-4.3.exe)

Une fois ces deux éléments télécharger, lancez l'éxécutable rufus. Dans l'onglet `device`, sélectionnez votre clé usb. Point d'attention si vous avez plusieurs disques ou clé usb connceté sur votre ordinateur a ce moment la, mais l'installation de l'ISO sur votre clé procedera à un formatage, donc a la perte de l'ensemble des données présente sur cette clé.
Une fois ces deux éléments télécharger, lancez l'éxécutable rufus. Dans l'onglet `device`, sélectionnez votre clé usb. 
**Point d'attention** : si vous avez plusieurs disques ou clé usb connceté sur votre ordinateur a ce moment la, mais l'installation de l'ISO sur votre clé procedera à un formatage, donc a la perte de l'ensemble des données présente sur cette clé.
Vous pouvez ensuite spécifier l'ISO de proxmox dans l'onglet `Boot selection`.
Une fois que vous avez sélectionner ces deux paramètres, vous pouvez laisser le reste par défaut, et cliquer sur `Start`

![Rufus_exemple](src/rufus.png)

Une fois que vous aurez votre clé USB bootable prête à l'emploi, vous pouvez la brancher sur votre serveur, et aller dans le bios pour booter sur cette clé usb.
Une fois que vous aurez booter sur cette clé, vous arriverez sur l'interface d'installation de proxmox ! 
**Point d'attention** : Le processus ci-dessus est le même pour toute les versions de proxmox. Seules les configurations ultérieures à l'installation changeront en fonction de la version que vous avez installé.

A ce point la, cliquez simplement sur `Isntall Proxmox VE` :
![proxmox_fisrt_page](src/proxmox_install_fisrt_page.png)

Acceptez ensuite le contrat de license (eula) : 
![proxmox_eula](src/proxmox_eula.png)

Nous devons ensuite sélectionner le disque sur lequel nous allons installer l'OS. Nous configurerons le stockage des VMs plus tard, lorsque l'os sera installer.
![proxmox_disque](src/proxmox_disque.png)

On s'occupe ensuite de la sélection du pays, qui permet de determiner le layout du clavier et la zone de temps.
![proxmox_pays](src/proxmox_pays.png)

On configure ensuite le mot de passe de l'utilisateur **root**, ainsi qu'une adresse email.
**Point important** : Le clavier de base de l'installateur peut être en QWERTY. Vérifiez donc bien quand vous écrivez !
![proxmox_password](src/proxmox_password.png)

La configuration réseau se fait par rapport à votre réseau chez vous. En règle générale, vous serez sur la plage d'ip 192.168.0.0/24 ou 192.168.1.0/24, avec comme routeur/dns l'adresse ip de votre routeur.
Vous pouvez avoir ces informations sur votre ordinateur, en tapant la commande `ipconfig /all`.
Entrez donc l'adresse IP que vous avez choisi pour votre serveur, et validez.
![proxmox_network](src/proxmox_network.png)

Proxmox vous faira ensuite un récapitualitif de vos configurations. En cas d'erreurs, vous pouvez cliquez sur `previous`, et venir changer les paramètres sur lesquels vous vous etes trompé.
![proxmox_install_recap](src/proxmox_install_recap.png)

L'installation se faira, et au bout de quelques minutes, vous aurez une page contenant le lien de l'interface web de votre proxmox : 
![proxmox_install_end](src/proxmox_install_end.png)

Vous pourrez donc acceder à votre insterface web sur le lien suivant depuis votre navigateur : 
```
https://<ip_serveur>:8006
```

Vous pourrez vous connecter avec l'utilisateur **root**, le mot de passe que vous avez défini lors de l'installation, dans le REALM `Linux PAM standard authentification`.
![proxmox_login_page](src/proxmox_login_page.png)

**Point d'attention** : Vous retrouverez sous proxmox deux manières d'authentification, que l'on appelle REALM.
- PAM : C'est le module d'authentification utilisé par Linux et les systèmes UNIX et BSD. Les informations de l'utilisateur local sont stocké dans le système et permette l'authentification de se connecter sur la machine en SSH ou en local, ainsi que sur l'interface de proxmox.
- PVE : C'est la base de données de proxmox. Elle ne permettra que l'utilisation de l'interface web à ses utilisateurs, ainsi qu'à l'API.


#### 3. - Installation de l’environnement Docker

Avant de nous intéresser à Docker, nous définirons ce qu'est un conteneur. Un conteneur est un environnement d'exécution léger, permettant d'utiliser des applications sans la difficulté d'organisation d'un système d'exploitation entier.
Son utilisation peut nous être intéressant pour l'installation de services tel qu'un serveur de 

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
