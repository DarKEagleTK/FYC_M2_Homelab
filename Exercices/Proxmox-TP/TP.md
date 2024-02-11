# TP Proxmox

## Avant de commencer
Avant de commencer cette partie, assurez vous d'avoir déjà mis en place votre proxmox.

Vous pouvez donc aller dans notre partie du cours sur l'installation et la configuration de proxmox pour en savoir plus.

# A faire

Dans ce TP, vous allez devoir créer un template pour vos machines virtuelles.
Comme précisé dans le cours, avoir des templates vous permettra de ne pas avoir à reinstaller totalement vos machines virtuelles, et simplement faire des clones de vos templates pré-installer avec un ensemble de services.

Il faudra remplir les points suivant : 
- L'os mis en place doit etre un debian ou un ubuntu.
- Vous devez utiliser le cloud-init
- Comme nous avons un prometheus pour notre supervision, installer sur le template l'exporteur de données de prometheus
- Mettez en place le système guest agent.
- Configurer votre clé ssh dans la machine

Il vous sera demander de rendre sur la plateforme un compte rendu de votre TP, avec des captures d'écrans et des explications des systèmes que vous allez utiliser.