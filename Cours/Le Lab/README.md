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

Avant de nous intéresser à Docker, nous définirons ce qu'est un conteneur. Un conteneur est un environnement d'exécution léger, permettant d'isoler les applications déployés sur un seul et le de partage de ressources de l'hôte entre les différents conteneurs. Un conteneur est plus léger et plus simple qu’une machine virtuelle et peut donc démarrer et s’arrêter plus rapidement. Il est donc plus réactif, et adaptable aux besoins fluctuants liés au ” scaling ” d’une application.
Docker orchestre, crée et manage ces conteneurs, dans le partage de ressources, la configuration réseau et stockage des conteneurs.

![Schema Conteneurs](src/why_containers.svg) 

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
Vous trouverez l'anti-sèche des commandes les plus utilisées sur Docker : 
[Cheat Sheet Docker](https://docs.docker.com/get-started/docker_cheatsheet.pdf)

#### 4. - Configuration

##### Gestion des conteneurs

Nous allons voir 3 concepts clefs de Docker : *les conteneurs, les images et les fichiers Docker (Dockerfile)*

En prenant NGINX comme exemple, voici un tableau avec les commandes les plus utilisé sur Docker pour gérer les conteneurs :

|Commandes|Exemple|Commentaires|
|---|:-:|---|
|**docker run <nom_image>**|`docker run --name some-nginx -v /some/content:/usr/share/nginx/html:ro -d nginx`|Différents arguments peuvent être ajouté lors de la création du conteneur. Voir [ici](https://docs.docker.com/engine/reference/run/)|
|**docker ps**|`docker ps`|pour lister les conteneurs lancés. Rajouter "-a" comme argument pour lister tous les conteneurs|
|**docker stop <id_conteneur>**|`docker stop 78`|Pour arrêter un conteneur|
|**docker restart <id_conteneur>**|`docker restart 78`|Pour redémarrer un conteneur|
|**docker rm <id_conteneur>**|`docker rm 78`|Pour supprimer un conteneur|


La gestion de conteneur n'oblige pas que nous créons les conteneurs à chaque fois, un site propose différentes images Docker les plus utiliser [Docker Hub](https://hub.docker.com/search?q=)

Prenons, comme exemple NGINX : serveur web HTTP pouvant servir de proxy inversé, proxy de messagerie électronique ainsi que de LoadBalancer.

Pour l'installer dans notre machine via Dockerhub nous lançons:
```bash
docker pull nginx
```
Et nous devons attribuer un port externe pour notre hôte locale :
```bash
docker run --name some-nginx -d -p 8080:80 some-content-nginx
```

Nous pouvons maintenant accéder à notre serveur local sur notre navigateur en tapant : http://localhost:8080

Pour lister les images nous tapons `docker images`
Pour supprimer une image nous lançons la commande `docker rmi <id_image>`

##### Compréhension des scripts YAML orienté Docker

Cas pratique : création de docker compose.yaml pour installer MySQL, Nginx.

#### 5. - Pour aller plus loin

##### Clustering/HA

Un des points interessant avec les systèmes de virtualisation, c'est la possibilité de faire des clusters avec les différentes machines que vous mettez en place. 

Pour faire un cluster, je vous recommande d'aller voir les liens suivant : 

- [Proxmox Documentation](https://pve.proxmox.com/wiki/Cluster_Manager)
- [Tuto Youtube](https://www.youtube.com/results?search_query=cluster+proxmox)

##### Kubernetes

Si nous souhaitons aller plus loin dans le management et la création de conteneur, nous pouvons installer Kubernetes. Kubernetes est une plate-forme open-source pour gérer les ressources machines (computing), la mise en réseau et l’infrastructure de stockage sur les workloads des utilisateurs.

Vous trouverez donc ci-dessous, différents liens permettant de d'installer et d'utiliser kubernetes : 
- https://kubernetes.io/fr/
    - https://kubernetes.io/fr/docs/concepts/overview/what-is-kubernetes/
- https://docs.k0sproject.io/v1.21.2+k0s.1/
    - https://docs.k0sproject.io/v1.21.2+k0s.1/k0s-in-docker/
- [Playlist Tutoriel Kubernetes](https://www.youtube.com/playlist?list=PLy7NrYWoggjziYQIDorlXjTvvwweTYoNC)

## C. - Le stockage

#### 1. - Présentation
Dans tout système de stockage, certaines bonnes pratiques sont à respecter. 

  - Le RAID : 

  La mise en place d’un système en RAID (cf rappel sur les RAID). Votre système de stockage ne peut pas reposer sur un seul élément (un disque dur externe par exemple) ; le risque d’interruption de service en cas de panne serait de 100%. Il vous faut donc choisir un système RAID correspondant à vos besoins en rapidité comme en sécurité/niveau de redondance. 

  - Les sauvegardes : 

Un système de stockage se doit avoir des sauvegardes (et j’insiste ici sur DES sauvegardeS et pas UNE sauvegarde). Encore une fois, tout dépend de la criticité de vos données, mais la règle du 3-2-1 semble être un minimum. Cela consiste en 3 copies de vos données (= 2 sauvegardes, votre prod + 2 copies), sur 2 supports différents (un NAS et une sauvegarde sur bandes par exemple), et une sauvegarde externalisée (par exemple une cartouche RDX, l’objectif étant de ne pas être pris en défaut par un incendie dans votre baie informatique par exemple). La sauvegarde externalisée peut être “à froid” ou juste délocalisée sur un autre site ; mais une sauvegarde à froid peut aussi servir en cas de ransomware. Certaines technologies permettent aussi de créer des sauvegarde “inaltérables”, soit directement grâce à une solution de sauvegarde (Certains produits de chez Veeam par exemple), soit sur le support de sauvegarde (instantané immuable sur NAS Synology par exemple) ; ces fonctions peuvent également être de bonnes solutions pour sécuriser vos données. 

Enfin, point très important : testez vos sauvegardes. Cela peut paraitre bête, mais on ne teste pas ses sauvegardes le jour où l’on en a besoin. Il faut faire des tests de restauration et d’intégrité réguliers pour vérifier tout d’abord que vous saurez utiliser vos sauvegardes si besoin est, mais aussi que vos machines sont sauvegardées convenablement et que les données de sauvegarde ne sont pas corrompues. 

#### 2. - Installation de NAS/SAN (TrueNAS)
Ce cours portera sur l’installation et la configuration initiale de TrueNAS. TrueNAS est une solution gratuite et open source, permettant de stocker vos fichiers à la manière d’un NAS mais bien plus encore. Avant d’aller plus loin, il faut savoir que plusieurs versions de TrueNAS existent : TrueNAS core et TrueNAS scale. La version scale est un peu plus puissante et permet offre quelques fonctionnalités supplémentaires comme la possibilité de créer et gérer des conteneurs, offrir de la redondance, etc. Cette dernière est un peu plus adaptée à un environnement d’entreprise ou demandant des ressources de puissance et de stockage importantes (on parle de plusieurs Po), et la version Core nous suffira largement. TrueNAS scale est aussi plus récent que la version core, puisque l’OS est sorti en 2022, tandis que la version core a vu le jour en 2005 (on a donc un bien meilleur recul sur sa fiabilité). 

La version core demande un minimum de 16Go de stockage pour son installation (il en faudra évidemment plus pour stocker les données que vous souhaitez héberger), ainsi qu’un minimum de 8Go de RAM et un processeur 2 cœurs. Il s’agit ici de la configuration recommandée, il est toujorus de faire tourner un système TrueNAS avec moins de RAM par exemple si on se limite à du stockage et partage de fichiers dans un foyer. A l’inverse, augmenter le nombre de fonctions et de plugins portés par votre système vous obligera à augmenter la RAM allouée à votre machine (il est possible de calculer combien de RAM sera nécessaire ici : [Site officiel TrueNAS](https://www.truenas.com/docs/core/gettingstarted/corehardwareguide/))

Nous pouvons donc commencer ce cours en téléchargeant l’image disque de TrueNAS core depuis le site officiel ici : [Télécharger l'ISO](https://www.truenas.com/download-truenas-core/?location=hero)

L’étape suivante est logiquement de passer à l’installation de notre machine. Vous pouvez l’installer en tant que machine physique (le système permet même de supporter des VM si elles restent simples) ou, comme ici, en tant que machine virtuelle.
![Install_VM_TrueNAS](src/installTrueNAS1.png)

Une fois notre machine démarrée, nous débutons l’installation. Si vous avez fait le choix de provisionner plusieurs disques dès le début (ou si vous avez fait le choix d’une machine physique), faites attention à sélectionner le bon disque cible pour l’installation.
![SelectDiskTrueNAS](src/installTrueNAS2.png)

On suit les différentes étapes de l’installateur, faites attention au type de clavier que vous utilisez lorsque l’on vous demande de choisir un mot de passe : un clavier QWERTY pourrait rendre l’accès à votre machine compliqué par la suite.
![PwdTrueNAS](src/installTrueNAS3.png)

L’installation finie, on redémarre notre machine, sans oublier de retirer le support d’installation. Une fois le système démarré, on arrive sur cette interface :
![MenuTrueNAS](src/installTrueNAS4.png)

Suivant la configuration de votre HomeLab, il peut être nécessaire de configurer une ou plusieurs interfaces avant de pouvoir se connecter à l’interface web. Vous pouvez aussi vouloir configurer des interfaces en ligne de commande si vous préférez, pour fixer une IP fixe dès le début par exemple. 

Dans notre situation, notre TrueNAS a déjà récupéré une IP depuis notre DHCP, nous pouvons donc d’ores et déjà accéder à l’interface web sans configuration supplémentaire. Il suffit de saisir l’identifiant root et le mot de passe que vous avez configuré lors de la création de la machine (s’il ne correspond pas, pas de panique, il est toujours possible de le réinitialiser via l’interface en ligne de commande de la machine en saisissant l’option numéro 7).
![InterfaceWebTrueNAS](src/installTrueNAS5.png)

Afin d’éviter de mauvaises manipulations (ou de soulager les moins anglophones d’entre vous), je vous conseille de commencer par changer les options de langue, de clavier et d’emplacement dans System > General
![MenuGeneralTrueNAS](src/installTrueNAS6.png)

On se rend ensuite dans Stockages > Volumes > Ajouter afin de créer notre partition de stockage. Plusieurs options sont possibles, mais nous allons ici faire au plus simple en choisissant de créer un volume basé sur un seul disque. Nous confirmons notre choix en cliquant sur “Créer un volume”, que l’on nomme ensuite (dans mon cas je l’appellerai “Data”). Dans cette même page, nous avons la possibilité d'activer le chiffrement (plusieurs options sont disponibles, de l’AES-128-CCM à l’AES-256-GCM), que nous n’activerons pas ici. Un autre bouton éveille peut-être aussi votre curiosité : “ajouter vdev”. Sous une apparence compliquée, il s’agit en fait simplement d’une autre unité de stockage (VDEV -> Virtual DEVice) que vous pourriez choisir de créer en vous basant sur un même volume physique. Toujours dans une optique de garder notre machine didactique la plus simple possible, nous choisirons d’allouer tout notre disque à un seul volume de stockage ; puis nous cliquons sur le bouton “créer”. 
![MenuStockageTrueNAS](src/installTrueNAS7.png)

Nous avons donc désormais un système opérationnel, et de quoi stocker nos données. Nous allons désormais voire comment créer des utilisateurs afin de remplir tout ce stockage inutilisé. Pour ce faire, nous nous rendons dans Comptes > Utilisateurs > Ajouter. Nous saisissons alors au minimum le nom complet de notre utilisateur, ainsi que son nom d’utilisateur et le mot de passe qui lui sera attribué. Dans les autres options disponibles, nous retrouvons l’ID d’utilisateur (qui doit forcément être supérieur à 1000 dans le cas d’un compte utilisateur), le ou les groupes auxquels on peut ajouter notre utilisateur, ainsi que les permissions que l’on choisit de lui attribuer sur les partages de notre système. On constate également la possibilité de configurer une authentification via clé SSH, de désactiver le compte utilisateur, de l’autoriser à utiliser la commande sudo ou son compte Microsoft (pour l’authentification), et d’utiliser Samba.
![MenuComptesTrueNAS](src/installTrueNAS8.png)

Quand tout a été rempli selon notre convenance, nous pouvons cliquer sur le bouton “envoyer” afin de créer notre utilisateur, que l’on voit maintenant au côté de root dans notre liste d’utilisateurs. Libre à vous maintenant d’en créer d’autres, associés à des groupes ou non, afin de compléter et sécuriser votre arborescence de fichiers.
![MenuUtilisateursTrueNAS](src/installTrueNAS9.png)

Nous pouvons également créer des partages, SMB par exemple dans le cas d’un utilisateur Windows. Pour cela, nous nous rendons dans Partages > Partages Windows (SMB). On nomme alors notre partage, puis on constate que le bouton “options avancées” nous offre plusieurs fonctions pouvant être utiles. Nous retrouvons entre autres la possibilité de limiter l’accès au partage en lecture seule (via l’option “Exporter en lecture seule”), de choisir les hôtes ayant accès ou ne devant pas accéder au partage (via une liste d’adresses IP par exemple), ou encore de choisir ce lecteur comme dossier personnel de nos utilisateurs. Un dernier menu déroulant nous permet d’autoriser la compatibilité de notre partage avec d’autres protocoles, afin de permettre l’accès via un MAC par exemple.

Votre serveur TrueNAS est désormais totalement opérationnel et bénéficie des fonctions de base d’un NAS. Vous pouvez désormais explorer les autres menus de votre système, parmi lesquels vous retrouverez par exemple : 

    - La possibilité de répliquer vos données (Tâches > Réplication) 

    - Lier votre système à des annuaires (Services d’annuaire) 

    - Permettre à votre système de vous envoyer des notifications via mail (Système > Courriel) 

    - Créer des machines virtuelles hébergées par votre serveur TrueNAS (Machines virtuelles) 

Mais aussi et surtout la possibilité d’installer des plugins sur votre serveur TrueNAS. La collection d’iXsystems vous permet déjà d’ajouter NextCloud à votre système ou de transformer votre système en serveur Plex, mais la communauté offre bien d’autres plugins bien plus nombreux, tels qu’un serveur OpenVPN par exemple, mais aussi des serveurs DNS comme Bind ou des solutions de vidéo surveillance ; le tout appuyé sur une solide communauté. Gardez cependant à l’esprit que toutes ces options demanderont aussi des ressources systèmes, et pourront ralentir votre système et/ou vous obliger à passer sur du matériel plus puissant. 

Si l’installation de ces plugins vous intéresse, vous pouvez suivre notre tutoriel sur NextCloud qui vous aidera à vous familiariser avec un de ces composants. 


#### 3. - Configuration

#### 4. - Pour aller plus loin

## D. - Services

#### 1 - Présentation

Maintenant que vous avez installé votre environnement de virtualisation et votre stockage, nous allons pouvoir commencer à installer des services.
Il vous est bien entendu possible d'installer tout types de services sur votre infrastructure, mais voici ce que nous vous recommendons d'avoir : 
- Firewall : Pour connecter vos différents sous réseaux, et pouvoir l'utiliser comme point d'entrée d'une DMZ, par exemple, nous vous recommendons l'utilisations d'un firewall. Nous vous présenterons PFsense, mais il peut etre interessant d'apprendre NFTables ou iptables pour bien comprendre le fonctionnement de ce genre de systeme.
- VPN : Pouvoir se connecter à votre infrastructure peut importe où vous vous trouvez nous semblent indispensable. Nous vous présenterons donc comment faire un VPN avec le célèbre OPENVPN
- Outils DevOps : Savoir utiliser git, et être capable d'automatiser certaines choses redondante, comme l'installation de machines virtuelles, est un point important en informatique, et qui devient de plus en plus rechercher dans le monde professionnel. Nous vous présenterons donc terraform, ansible et git pour vous lancer sur ces sujets.
- Sockage : Nous vous présenterons pour finir un Nextcloud, pour vous présenter une alternative au systeme cloud.
#### 2. - Installation/Utilisation du Firewall

#### 3. - Installation/Utilisation d’un VPN

#### 4. - Installation/Utilisation d’outils DEVOPS
Pour notre environnement DevOps, nous allons voir trois points : 
- Terraform
- Ansible 
- Git

Nous procéderons à la présentation et à l'installation de ces systèmes sur une machine virtuelle, que vous pouvez créer tout de suite. Vous aurez ensuite un TP à faire, pour 
##### Terraform

Terraform est un système d'infrastructure as code. Il permettra donc de créer des vms via des fichiers de configuration terraform.<br>
Voici la documentation officiel de terraform : https://www.terraform.io/<br>
Si vous n'êtes pas d'accord avec l'utilisation de terraform, pour certaines raisons d'orientation d'entreprise, regardez cette documentation d'OpenTofu : https://opentofu.org/docs/

Pour installer Terraform, connectez vous sur la machine devops que vous avez créé au préalable.
On commence par installer les dépendances : 
```bash
# Debian
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
# RedHat
sudo yum install -y yum-utils
```
On installe ensuite la clé gpg du repo et le repo : 
```bash
# Debian
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# RedHat
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
```
On fini par installer terraform : 
```bash
# Debian
sudo apt update
sudo apt install -y terraform
# RedHat 
sudo dnf install -y terraform
```

Maintenant que terraform est installé, nous allons pouvoir commencer à l'utiliser.<br>
Commencons donc par créer un dossier ``terraform``, dans lequel nous mettrons l'ensemble de nos projets, puis un dossier `TP-terraform`.
```bash
mkdir -p terraform/TP-terraform && cd terraform/TP-terraform
```
Pour commencer, nous devons créer les différents fichiers terraforms : 
- credentials.rfvars : Nous y mettrons les differents mot de passes et autres. C'est un fichier à bien entendu mettre dans votre git_ignore.
- provider.tf : le provider est le support sur lequel votre terraform va s'executer. Nous allons donc devoir utiliser le provider de proxmox. Voici la liste des providers de terraform : https://registry.terraform.io/browse/providers
- main.tf : c'est ici que la magie opère. Nous allons pouvoir definir les différentes actions à effectuer.

```bash
# Fichier provider.tf
terraform {
    required_version = ">= 0.13.0"
    required_providers {
        proxmox = {
            source = "telmate/proxmox" # On défini la source. Pour nous, proxmox !
        }
    }
}
# On défini les variables
variable "proxmox_api_url" {
    type = string
}
variable "proxmox_api_token_id" {
    type = string
}
variable "proxmox_api_token_secret" {
    type = string
}

provider "proxmox" {
    pm_api_url = var.proxmox_api_url
    pm_api_token_id = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret
}
```

Générez sur votre utilisateur et le token depuis votre proxmox, puis remplissez les champs suivant : 
```bash
# Fichier credentials.tfvars
proxmox_api_url = "https://0.0.0.0:8006/api2/json"  # Your Proxmox IP Address
proxmox_api_token_id = "terraform@pam!terraform"  # API Token ID
proxmox_api_token_secret = "your-api-token-secret"
```

Vous créerez votre main.tf dans un TP par la suite.

Concernant les différentes commandes importante : 
```bash
terraform init #permet d'initialiser le projet/telecharger les elements nécessaires pour communiquer avec proxmox

terraform plan -var-file="credentials.tfvars" #Permet d'afficher les changements prévu, sans les appliquer

terraform apply -var-file="credentials.tfvars" #Permet de lancer le terraform, et donc de creer la VM

terraform destroy -var-file="credentials.tfvars" #Permet de supprimer les elements créer par terraform
```

##### Ansible 

Ansible est un système de configuration as code. Contrairement à Terraform, Ansible est fait pour configurer des serveurs ou services. Cela combine cependant bien avec Terraform dans la mise en place d'un projet AsCode. Vous allez pouvoir definir des configurations dans des fichiers yaml, et les appliquer à distance et sur plusieurs machines différentes en même temps.<br>
Voici la documentation d'Ansible : https://docs.ansible.com/

Pour installer Ansible, connectez vous sur la machine devops que vous avez créé au préalable.
```bash
# Debian
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible
# RedHat 
sudo dnf install -y ansible-core
```

Avant de commencer, nous allons créer sur notre serveur une clé ssh qui permettra à notre ansible de se connecter sur les différents hôtes. Vous pouvez rajouter cette clé à votre template de vm pour permettre à ansible de pouvoir directement se connecter à vos VMs, et faire des actions dessus.

Les fichiers ansible sont des fichiers yaml. On les appelle les playbook.<br>
Pour lancer ces playbooks, il va falloir spécifier les hôtes. On va donc pouvoir configurer un fichier inventory.ini.

Pour tester la connexion vers les différents hôtes : 
```bash
ansible all -i inventory.ini -m ping
```
Voici la liste des paramètres : 
- `all` : toutes les hôtes de l'inventaire
- `-i inventory.ini`: L'inventaire en question
- `-m ping` : On lui demande d'executer la commande ping

On peut aussi lancer des commandes linux : 
```bash
ansible all -i inventory.ini -a "whereis python"
```
Dans le cas où il faudra une élévation de privilège, vous pouvez passer le paramètres `--become`.

Le fichier inventory.ini sera de la forme : 
```yaml
[targets] 
other1.example.com ansible_connection=ssh ansible_ssh_user=user ansible_ssh_private_key_file=/path/to/file
```
Voici la liste des paramètres : 
- `[targets]` : Nom de la target
- `other1.example.com`: ip ou fqdn de la target
- `ansible_connection=ssh` : On definit le type de connexion. Pour windows, cela pourrait etre winrm.
- ``ansible_ssh_user=user`` : on définit l'utilisateur de l'hôte distant
- ``ansible_ssh_private_key_file=/path/to/file`` : on définit la clé ssh pour se connecter dans mot de passe.

Vous créerez des playbooks dans un TP par la suite.

Les commandes pour lancer des playbooks : 
```bash
ansible-playbook -i inventory.ini nom_playbook
```
Voici la liste des paramètres : 
- `-i inventory.ini`: L'inventaire
- `nom_playbook` : Le playbook que vous voulez lancer

##### Git

Git est un logiciel de gestion de versions. Il est intéressant car il permet de stocker des fichiers de configurations ou le code sources d'applications de manière efficace, permettant de gerer les versions des fichiers. Il est aussi très utilisé, vous retrouverez beaucoup d'integration de git dans les logiciles de developpement. De plus, certains dérivé, comme gitlab ou github, permettent d'avoir un ensemble d'outils supplémentaires pour les développeurs, et pour déployer des services de manières automatiques.<br>
Voici la documentation de Git : https://git-scm.com/<br>
Voici la documentation de Gitlab : https://docs.gitlab.com/<br>
Voici la documentation de github : https://docs.github.com/fr<br>

Nous allons commencer par installer git sur notre poste : https://git-scm.com/downloads<br>
Une fois git installer sur votre ordinateur, vous pourrez faire des clones de repos.

De notre côté, nous allons installer gitlab. Votre machine virtuelle aura donc besoin au minimum : 
- 2 coeurs
- 8go de ram

Nous commencerons donc par installer les prérequis : 
```bash
sudo apt update
sudo apt install ca-certificates curl openssh-server postfix perl
```

Pour installer les référentiels maintenus par gitlab, nous allons utiliser un script : 
```bash
cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
sudo bash /tmp/script.deb.sh
```
Nous pouvons maintenant installer gitlab via apt : 
```bash
sudo apt install gitlab-ce
```

Nous allons ensuite editer le fichier de configuration de gitlab : 
```bash
# Vous pouvez utiliser l'éditeur que vous souhaitez
sudo vim /etc/gitlab/gitlab.rb
```

Cherchez le paramètre external_url, et remplissez placez l'url qui sera utiliser pour se connecter sur cette machine. Cela dépends de votre cas. Si vous avez un nom de domaine, vous pouvez l'utiliser.
```bash
external_url 'http://exemple.com:80'
```
Vous pouvez aussi jeter un oeil à la documentation et aux autres paramètres pour configurer votre gitlab comme vous le souhaitez.

Une fois vos paramètres etablis correctement dans le fichier de configuration, nous allons configurer le service : 
```bash
sudo gitlab-ctl reconfigure
```
Cette opération peut prendre plus ou moins de temps en fonction des ressources que vous avez.

Une fois la configuration finalisé, vous pouvez aller sur l'url que vous avez configurer et aller sur votre gitlab. Les identifiants par défaut sont récupérable dans le fichier `/etc/gitlab/initial_root_password`.

Vous pouvez maintenant utiliser votre gitlab, créer des repos et des utilisateurs.

#### 5. - Installation/Utilisation de NEXTCLOUD

## E. - Monitorings

#### 1. - Présentation

#### 2. - Installation Grafana/Prometheus/UptimeKuma

#### 3. - Configuration

#### 4. - Pour aller plus loin

## F. - Dashboard

#### 1. - Présentation

#### 2. - Installation Homer

## G. - Pour aller plus loin

Vous avez maintenant un infrastructure en place fonctionnel. Vous allez pouvoir integrer plus de services, et tester plus de technologies.

Voici quelques technologies que nous vous conseillons de regarder : 
- Virtualisation
    - QEMU/KVM
    - XCP-NG
    - VMware ESXI/Vsphere
- Firewall
    - Iptables
    - NFTables
- Automatisation
    - rundeck
    - foreman
    - 
- Autres
    - Serveur DNS
    - Serveur DHCP
    - Serveur WEB
    - Serveur proxy/reverse proxy

Un homelab est quelque chose qui ouvre des portes pour tous les passionnés d'informatiques, leur permettant de tester des choses, et surtout de les mettres en place ! <br>
Maintenant que vous avez mis en place le coeur de votre homelab, amusez vous et testez tous !