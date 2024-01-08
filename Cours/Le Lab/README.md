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
    - 

#### 2. - Installation de l’hyperviseur

Les prérequis pour cette partie du cours sont : 
- un ordinateur avec une connexion internet
- une clé usb 8go
- notre machine qui deviendra le serveur

Pour l'installation de notre proxmox, nous allons commencer par télécharger sur notre ordinateur l'iso de proxmox et rufus, un utilitaire pour intaller cet iso sur une clé usb bootable.
- ![Proxmox](https://enterprise.proxmox.com/iso/proxmox-ve_8.1-1.iso)
- ![Rufus](https://github.com/pbatard/rufus/releases/download/v4.3/rufus-4.3.exe)

Une fois ces deux éléments télécharger, lancez l'éxécutable rufus. Dans l'onglet `device`, sélectionnez votre clé usb. Point d'attention si vous avez plusieurs disques ou clé usb connceté sur votre ordinateur a ce moment la, mais l'installation de l'ISO sur votre clé procedera à un formatage, donc a la perte de l'ensemble des données présente sur cette clé.
Vous pouvez ensuite spécifier l'ISO de proxmox dans l'onglet `Boot selection`.

![Rufus_exemple](src/rufus.png)


#### 3. - Installation de l’environnement Docker

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
