# TP

## Avant de commencer
Avant de commencer cette partie, assurez vous d'avoir déjà mis en place un environnement Ansible et l'environnement Prometheus/Grafana.

Vous pouvez donc aller dans notre partie du cours sur les sytèmes devops pour en savoir plus.

## A faire 
Maintenant que vous etes prêt, vous allez devoir pratiquer Ansible, pour configurer votre prometheus.

Vous allez donc devoir faire avec ansible : 
- créer un rôle ansible permettant de modifier le fichier de configuration de prometheus pour y ajouter les nouveaux hôtes.
- Créer un rôle permettant de mettre à jour vos conteneurs prometheus, grafana et uptimekuma sans perdre les données.
- Créer un playbook permettant de lancer la mise à jour des conteneurs et mettre à jour les fichiers de configurations de prometheus.