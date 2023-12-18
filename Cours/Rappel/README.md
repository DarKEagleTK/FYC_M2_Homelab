## A. Rappel système

Pour fonctionner, un système d’exploitation (OS) a besoin d’accéder à des ressources. Pour cela, l’OS embarque un kernel (ou noyau), qui va s’occuper de traduire les demandes de ressources, qu’on appelle appels systèmes, aux différents composants de l’ordinateur.

L’une des avancées importantes dans le monde du système est la virtualisation. Cela permet entre autres de faire tourner plusieurs systèmes d’exploitation sous forme de systèmes virtualisés sur une machine hôte. La machine hôte va s’occuper de distribuer ses ressources aux différents systèmes virtualisés, et en fonction de la quantité de ressources disponibles, un certain nombre de systèmes virtualisés pourra fonctionner côte à côte.

### 1. Superviseur, Hyperviseur et Conteneur

Pour faire ces systèmes virtualisés, nous allons avoir besoin d’une couche qui s’occupera de faire la virtualisation. C’est-à-dire que cette couche va s’occuper de faire la traduction entre les appels systèmes du systèmes virtualisés et les composants de l’hôte.

Il existe donc plusieurs moyens de faire de la virtualisation : les machines virtuelles et les conteneurs. Chacun de ces systèmes intervient sur des couches différentes, et permet plus ou moins de fonctionnalités.

#### a. Superviseur

Un superviseur est un logiciel de virtualisation que l’on doit installer sur un système d’exploitation. On appelle aussi ces logiciels des hyperviseurs de niveau 2. Parmi ce genre de logiciel, on retrouve VMWare Workstation ou encore VirtualBox.

Ces logiciels viennent rajouter une couche par-dessus un système d’exploitation.

Le logiciel superviseur embarque donc des drivers pour ces VMs, pour permettre aux appels systèmes des machines virtuelles à travers l’OS et atteindre les ressources. Ce genre de système n’est pas efficace lorsqu’on a besoin de beaucoup de ressources et de performances.

#### b. Hyperviseur

Un hyperviseur est un système d’exploitation dédié à la création de machine virtuelle. On parle aussi d’hyperviseur de niveau 1. Parmi ce genre de logiciel, on retrouve KVM, VMWare ESXI ou Hyper-V.

Ce genre de système de virtualisation supprime la couche OS du superviseur. On retrouve en règle générale une partie logiciel de contrôles, pour la gestion des systèmes virtualisés.

Ces systèmes de virtualisation sont beaucoup plus efficaces et performants pour créer des machines virtuelles, et sont souvent installés sur des serveurs ayant beaucoup de ressources, avec des outils permettant la mise en cluster de ces systèmes.

#### c. Conteneur

Les conteneurs sont une manière de faire de la virtualisation totalement différente des machines virtuelles, donc des hyperviseurs. Le concept des conteneurs est de virtualiser une seule et unique application. Par exemple, si on doit déployer un serveur web et une base de données, on créera deux conteneurs avec un pour le serveur et un pour la base de données.

Parmi ce genre de logiciels, on retrouve Docker, containerd, LXD ou encore Podman.

Ces systèmes intègrent donc un moteur de conteneur, qui doit se rajouter par-dessus un OS.

## 2. Les raids

Les Systèmes RAID (Redundant Array of Independent Disks) sont des systèmes utilisés pour améliorer la fiabilité et les performances du stockage. L’idée est de combiner plusieurs disques physiques en un seul disque logique.

Il existe plusieurs niveaux de RAID, et ils peuvent être faits grâce à une carte RAID physique ou grâce à des systèmes logiciels.

1. RAID 0
    - Améliorer les performances en écrivant les données entre plusieurs disques.
    - A pour inconvénient de n’avoir aucune redondance. La perte d’un disque fait perdre l’ensemble des données.
2. RAID 1
    - Améliorer la redondance en écrivant simultanément sur deux disques identiques. Dans le cas où un des disques se corrompt, l’autre disque permet d’accéder aux données.
    - A pour inconvénient la grande quantité de disques, donc de coût, pour le mettre en place.
3. RAID 5
    - Combine performance et redondance en répartissant les données sur les différents disques avec un système de parité.
    - A pour inconvénient de ne pas être très rapide pendant les opérations d’écriture.
4. RAID 6
    - Similaire au RAID 5 avec deux parités, ce qui offre une meilleure protection contre la perte de données.

On retrouve aussi d’autres types de RAID, comme le RAID 10 qui est une combinaison entre un RAID 1 et 0, ou le RAID 50 qui est une combinaison de RAID 5.

Chaque RAID a ses avantages et défauts, et nécessite d’avoir été étudié pour prévoir les besoins nécessaires pour leur déploiement.

## 3. Linux

### a. L’arborescence

L’arborescence de Linux fonctionne à partir d’un répertoire racine (le /), dans lequel on retrouve l’ensemble des dossiers.

Chacun des dossiers a ses utilisations, et il est important de savoir ce qu’on peut y retrouver.

### b. Commandes utiles

Linux a énormément de commandes. Voici quelques commandes utiles pour faire vos débogages, ou pour votre utilisation de Linux :

- La commande `screen` permet de créer des terminaux, que l’on peut mettre en arrière-plan, diviser en plusieurs pour faire plusieurs actions simultanément.
- La commande `tail -f nom_fichier` permet de lister les dernières lignes de votre fichier, et d’afficher les nouvelles dernières lignes qui s’ajoutent. Cette

 commande est utile lors de vos débogages dans les fichiers de logs.

### c. Logs

Linux a un dossier dans lequel on retrouve tous les logs. C’est le dossier /var/log.

Les applications créent en général un dossier à leur nom dans ce répertoire.

Vous pouvez utiliser la commande `journalctl -xe` pour avoir accès au log système.

## 4. Windows

### a. Arborescence

### b. Logs

# B. Rappel Réseau

## OSI et TCP/IP

Le modèle OSI et le modèle TCP/IP sont des modèles de communication sur les réseaux. Ils déterminent comment sont construits les paquets.

La partie réseau est souvent de l’Ethernet IP, donc des adresses IP que nous verrons dans quelques instants.

UDP et TCP sont les deux protocoles de couche transport les plus connus. La grosse différence entre ces deux protocoles est que le TCP privilégie et assure des transferts de données fiables tandis que l’UDP privilégie des transferts rapides.

La couche application permet de déterminer l’application à qui appartiennent les données du paquet. Par exemple, de l’HTTPS pour une page web.

## Adresse IP et masque

La base du réseau informatique est les adresses IPs. Ici, nous nous concentrerons sur l’IPv4.

Une IPv4 est découpée en 4 octets. Une adresse IP est découpée en deux parties : la partie réseau et la partie hôtes. La partie réseau correspond à l’identifiant du réseau, et la partie hôtes correspond au numéro de l'hôte. Pour déterminer les deux parties, on utilise le masque de sous-réseau.

Tout comme l’adresse IP, le masque de sous-réseau est découpé en 4 octets. Grâce à une opération binaire, il permet de déterminer la partie réseau et la partie hôte d’une adresse IP. Par exemple :

Cela permet d'intégrer le système de sous-réseau, qui permet de découper les réseaux en réseau plus petit pour isoler les serveurs dans une zone précise.

Il est aussi important de noter que la première adresse du réseau est l’adresse qui désigne le réseau, et la dernière celle qui désigne l’adresse de broadcast du réseau.

## Routes et route par défaut

Pour communiquer entre les réseaux, on va utiliser les routes. Les routes sont des configurations qui permettent à une machine de savoir où est-ce qu’elle doit envoyer le paquet pour qu’il atteigne le destinataire. Les routes peuvent être statiques ou dynamiques, c’est-à-dire qu’on peut les mettre à la main de manière statique ou utiliser des services pour modifier les tables de routages automatiquement.

Dans la même logique, la route par défaut est la route sur laquelle on enverra tous les paquets dont on ne connaît pas précisément la destination.

Dans le cas d’un réseau domestique, la route par défaut est souvent la box internet.

Nous utilisons aussi ces routes pour relier plusieurs sous-réseaux.
