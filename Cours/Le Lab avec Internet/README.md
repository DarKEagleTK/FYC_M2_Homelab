## A.	Le lab avec internet

Maintenant que nous avons tout un ensemble de systèmes et de services configurés sur notre environnement, nous pouvons nous posez les questions suivantes : 
- Comment exposer mes services sur internet pour pouvoir y accéder de partout ?
- Quels services dois-je exposer ou non ? 

Lors de cette partie de cours, nous allons voir lesquel de nos services nous pouvons exposer sur la toile, et comment le faire de manière propre. Nous verrons aussi pour mettre en place un système multisite, pour connecter votre infrastructure à d'autre environnement comme la maison de vos amis ou parents.

Pour cela, nous allons avoir besoin de plusieurs technologies différentes: 
- Les noms de domaines
- Les certificats
- Les zones DMZ
- Les VPNs

**Point d'attention** : L'exposition de votre infrastructure personnelle sur internet peut contenir des risques. Des services mal configuré peuvent être cassé par des bots ou des personnes mal intentionné. Veuillez donc prendre ces informations en comptes avant d'exposer vos services, et faites attentions aux ouvertures que vous faites sur votre firewall !

## B.	Nom de domaine
### 1.	Présentation

Nous allons donc commencer par les noms de domaines. Pour cette partie, nous allons malheuresement avoir de nouveau besoin de notre carte bleu.
Avant de commencer, nous allons faire un petit rappel sur les DNS et leurs fonctionnements.

Il existe plusieurs types de serveurs DNS. On y retrouve les serveurs racines, qui se nomment de A jusqu'à M, et qui sont des serveurs internationnaux. Il n'existe pas de serveurs DNS ayant une authorité plus importante que ces serveurs.
Il y a ensuite les serveurs faisant authorité sur un domaine. C'est ces serveurs que vous devez joindre pour connaitre les informations de la zone qu'ils gèrent. Dans le cas de `google.com`, on retrouve les celebres IP 8.8.8.8 et 8.8.4.4.
Pour finir, les serveurs DNS relais ne font pas authorité sur une zone, et servent uniquement de caches pour les hôtes qui se connectent dessus.

Pour obtenir un nom de domaine, on doit réserver le nom de domaine aupres de `registars`, qui dependent de la zone DNS qui vous voulez (fr, com, eu, ...). L'oganisme internationnal qui gèrent les DNS s'appelle ICANN.
Un certain nombres d'entreprises proposent cependant aux utilisateurs l'accès à des noms de domaines, pour les prixs allant de 5 à plusieurs milliers d'euros. En France, on retrouve IONOS, CLOUDFARE, ou encore OVH.

### 2.	DNS

Choisissez donc un fournisseur de nom de domaine, et réservez votre propre nom de domaine. **ATTENTION** C'est payant !!
Voici quelques fournisseurs : 
- ![OVH](https://www.ovhcloud.com/fr/domains/)
- ![IONOS](https://www.ionos.fr/domaine/noms-de-domaine)
- ![Hostinger](https://www.hostinger.fr/nom-de-domaine-disponible)

Une fois que vous avez votre nom de domaine, rendez-vous sur la page de gestion de nom de domaine de votre fournisseur. Vous obtiendrez une page similaire, récapitulant les informations de nom de domaine et vous permettant de faire des configurations.
![dns_datails](src/dns_details.png)

Ici, nous allons pouvoir configurer nos sous-domaines, les entrées dns, ainsi que parametrer les serveurs DNS pour faire en sorte d'utiliser votre propre serveurs en tant que serveur de nom.

### 3.	Certificat SSL
- Création d’un certificat
- Utilisation du certificat sur les services configurer précédemment
## C.	DMZ
### 1.	Présentation
- Pourquoi ? (Avantages/inconvénient)
- Comment ?
### 2.	Mise en place d’une DMZ
Mise en place d’une DMZ sur la box
## D.	Multisite
### 1.	Présentation
- Pourquoi ? (Avantages/inconvénient)
- Comment ?
### 2.	Mise en place
•	Mise en place d’un tunnel ipsec (boitiers physiques)
•	Mise en place d’un tunnel ipsec (pfsense)
•	(Mise en place d’un tunnel ipsec vers cloud public)
