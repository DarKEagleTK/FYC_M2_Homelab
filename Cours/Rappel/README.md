## A. Rappel système

Pour fonctionner, un système d’exploitation (OS) a besoin d’accéder à des ressources. Pour cela, l’OS embarque un noyau (ou Kernel), qui va s’occuper de traduire les demandes de ressources (qu’on nomme appels système) aux différents composants de l’ordinateur.

L’une des avancées importantes dans le monde du système est la virtualisation. Cela permet entre autres de faire tourner plusieurs systèmes d’exploitation sous forme de systèmes virtualisés sur une machine hôte. La machine hôte (hyperviseur) s'occupera de distribuer ses ressources aux différents systèmes virtualisés, et autorisera le fonctionnement simultané de plusieurs systèmes en parallèle.

### 1. Superviseur, Hyperviseur et Conteneur

Pour créer et supporter ces systèmes virtualisés, nous allons avoir besoin d’une couche qui s’occupera de faire la virtualisation; c’est-à-dire de faire la traduction entre les appels système des systèmes virtualisés et les composants physiques de l’hôte.

Il existe plusieurs moyens de faire de la virtualisation : les machines virtuelles et les conteneurs. Chacune de ces technologies intervient sur des couches différentes, et permette plus ou moins de fonctionnalités.

#### a. Superviseur

Un superviseur est un logiciel de virtualisation que l’on doit installer sur un système d’exploitation. Aussi appelés hyperviseurs de niveau 2, on retrouve des logiciels tels que VMWare Workstation ou VirtualBox.

Le logiciel superviseur embarque des drivers afin de permettre aux appels système des machines virtuelles de communiquer avec les composants physiques de l'hôte. Ce genre de système n’est pas efficace lorsque l'on a besoin de beaucoup de ressources et/ou de performances.

#### b. Hyperviseur

Un hyperviseur est un système d’exploitation dédié à la création de machines virtuelles, on parle aussi d’hyperviseur de niveau 1. Parmi ce genre de logiciel, on retrouve KVM, VMWare ESXI ou Hyper-V.

Ce genre de système de virtualisation supprime la couche OS du superviseur. On retrouve en règle générale une partie logiciel de contrôle pour la gestion des systèmes virtualisés.

Ces systèmes de virtualisation sont beaucoup plus efficaces et performants et sont souvent installés sur des serveurs ayant beaucoup de ressources, avec des outils permettant la mise en cluster de ces systèmes.

#### c. Conteneur

Les conteneurs utilisent une technique de virtualisation totalement différente des machines virtuelles, et par extension, des hyperviseurs. L'intérêt des conteneurs est de virtualiser une seule et unique application à la fois. Par exemple, si l'on doit déployer un serveur web et une base de données, on créera deux conteneurs : un pour le serveur, et un pour la base de données.

Parmi ce genre de logiciels, on retrouve Docker, containerd, LXD ou encore Podman.

Ces systèmes intègrent un moteur de conteneur, qui doit se rajouter par-dessus un OS.

## 2. Les raids

Les Systèmes RAID (Redundant Array of Independent Disks) sont des systèmes utilisés pour améliorer la fiabilité et les performances du stockage. L’idée est de combiner plusieurs disques physiques en un seul disque logique.

Il existe plusieurs niveaux de RAID, pouvant être créés grâce à une carte RAID physique ou grâce à des solutions logicielles.

1. RAID 0
    - Améliore les performances en répartissant la lecture et l'écriture des données entre plusieurs disques.
    - A pour inconvénient principal de n’avoir aucune redondance. La perte d’un disque fait perdre l’ensemble des données.
2. RAID 1
    - Améliore la redondance en écrivant simultanément sur plusieurs disques identiques. Dans le cas où un des disques rencontre un problème, l’autre disque permet de garder l'accès aux données. Adapté au systèmes avec peu de disques physiques.
    - A pour inconvénient principal de vite nécessiter une grande quantité de disques, donc de moyens financiers, pour être mis en place.
3. RAID 5
    - Combine performance et redondance en répartissant les données sur les différents disques avec un système de parité.
    - A pour inconvénient de ne pas être très rapide pendant les opérations d’écriture.
4. RAID 6
    - Similaire au RAID 5 mais avec deux disques de parité, ce qui offre une meilleure protection contre la perte de données.

On retrouve aussi d’autres types de RAID, tels le RAID 10 (combinaison entre un RAID 1 et 0) ou le RAID 50 (combinaison d'un RAID 5 et d'un RAID 0).

Chaque RAID a des avantages et défauts, et nécessite d’avoir été étudié afin d'anticiper les besoins nécessaires à leur déploiement.

## 3. Linux

### a. L’arborescence

L’arborescence de Linux fonctionne à partir d’un répertoire racine (le /), dans lequel on retrouve l’ensemble des dossiers.

Chacun des dossiers à une fonction précise, il est donc important de savoir ce qu’on peut y retrouver.

### b. Commandes utiles

Linux possède une grande variété de commandes. Voici quelques commandes utiles pour vos débogages, ou simplement pour utiliser Linux correctement :

- La commande `screen` permet de créer des terminaux que l’on peut mettre en arrière-plan ou diviser afin de réaliser plusieurs actions simultanément.
- La commande `tail -f nom_fichier` permet de lister les dernières lignes de votre fichier et d’afficher les nouvelles dernières lignes ajoutées. Cette commande est utile lors de vos débogages dans les fichiers de logs.

### c. Logs

Linux a un dossier dans lequel on retrouve tous les logs; il s'agit du dossier /var/log.

Les applications créent en général un dossier à leur nom dans ce répertoire.

Vous pouvez utiliser la commande `journalctl -xe` pour accéder aux logs système.

## 4. Windows

### a. Arborescence

### b. Logs

# B. Rappel Réseau

## OSI et TCP/IP

Le modèle OSI et le modèle TCP/IP sont des modèles de communication sur les réseaux. Ils déterminent comment sont construits les paquets réseau.

La partie réseau est souvent de l’Ethernet IP, donc des adresses IP, que nous verrons dans quelques instants.

UDP et TCP sont les deux protocoles de couche transport les plus connus. La grosse différence entre ces deux protocoles est que le TCP privilégie et assure des transferts de données fiables tandis que l’UDP privilégie des transferts rapides sans contrôle de paquets.

La couche application permet de déterminer l’application à qui appartient les données du paquet. Par exemple, de l’HTTPS pour une page web.

## Adresse IP et masque

La base du réseau informatique s'appuie sur les adresses IP. Ici, nous nous concentrerons sur l’IPv4.

Une IPv4 est découpée en 4 octets, et chaque adresse IP est découpée en deux parties : la partie réseau et la partie hôte. La partie réseau correspond à l’identifiant du réseau, tandis que la partie hôte permet l'identification de l'hôte. Pour déterminer les deux parties, on utilise un masque de sous-réseau.

Tout comme l’adresse IP, le masque de sous-réseau est découpé en 4 octets. Grâce à un opération logique, il permet de déterminer la partie réseau et la partie hôte d’une adresse IP. Cela permet d'intégrer le système de sous-réseaux, qui permet de découper les réseaux en réseaux plus petits pour isoler les hôtes dans une zone précise.

Il est aussi important de noter que la première adresse du réseau est celle qui désigne le réseau, tandis que la dernière désigne l’adresse de broadcast du réseau.

## Routes et route par défaut

Pour communiquer entre les réseaux, on va utiliser des routes. Les routes sont des configurations qui permettent à une machine de savoir par où envoyer ses communications pour qu’elles atteignent le bon destinataire. Les routes peuvent être statiques ou dynamiques, c’est-à-dire qu’on peut les renseigner manuellement ou utiliser des services pour modifier les tables de routages de manière automatique.
Dans le cas où l'on ne connaitrait pas la destination de notre paquet, nous utiliserons une route par défaut, qui est en général, dans un reseau domestique, la box internet.

Nous utilisons aussi ces routes pour relier plusieurs sous-réseaux et leur permettre de communiquer entre eux.