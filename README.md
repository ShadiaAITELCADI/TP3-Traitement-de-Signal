# TP3- Traitement d’un signal ECG

<img width="992" alt="Screenshot 2023-01-01 121217" src="https://user-images.githubusercontent.com/89936910/210168645-997348a6-bd9a-4f1e-8b1c-92e97b4017c0.png">

<summary>Table of Contents</summary>
  <ol>      
      <li><a href="#Objectifs">Objectifs</a></li>
      <li><a href="#Suppression du bruit provoqué par les mouvements du corps ">Suppression du bruit provoqué par les mouvements du corps </a></li> 
      <li><a href="#Suppression des interférences des lignes électriques 50H">Suppression des interférences des lignes électriques 50H</a></li> 
      <li><a href="#Amélioration du rapport signal sur bruit">Amélioration du rapport signal sur bruit </a></li> 
      <li><a href="#Identification de la fréquence cardiaque avec la fonction d’autocorrélation ">Identification de la fréquence cardiaque avec la fonction     d’autocorrélation </a></li> 
      
  </ol>

# Objectifs 

- Suppression du bruit autour du signal produit par un électrocardiographe.
- Recherche de la fréquence cardiaque.

>Commentaires : Il est à remarquer que ce TP traite en principe des signaux continus. Or, l'utilisation de Matlab suppose l'échantillonnage du signal. Il faudra donc >être vigilant par rapport aux différences de traitement entre le temps continu et le temps discret.
>Tracé des figures : toutes les figures devront être tracées avec les axes et les légendes des axes appropriés.
>Travail demandé : un script Matlab commenté contenant le travail réalisé et descommentaires sur ce que vous avez compris et pas compris, ou sur ce qui vous a semblé >intéressant ou pas, bref tout commentaire pertinent sur le TP.

# Introduction 

Un électrocardiogramme (ECG) est une représentation graphique de l’activation électrique du cœur à l’aide d’un électrocardiographe. Cette activité est recueillie sur un patient allongé, au repos, par des électrodes posées à la surface de la peau. L’analyse du signal ECG est utile dans le but de diagnostiquer des anomalies cardiaques telles qu’une arythmie, un risque d’infarctus, de maladie cardiaque cardiovasculaire ou encore extracardiaque. 

Ci-dessous, voici un schéma représentant une représentation classique d’une courbe d’un ECG. Ce schéma se nomme un « Complexe QRS » mettant en évidence le bon fonctionnement d’un cycle cardiaque.

<img width="700" alt="222222" src="https://user-images.githubusercontent.com/89936910/210168489-5f9ba2e0-bb4b-4560-8c90-8bc16a3589c7.png">


L’onde P représente la première étape du cycle où les oreillettes (ou atriums) se contractent permettant le passage du sang, à travers les valves auriculoventriculaires, vers les ventricules.Ensuite, le complexe QRS symbolise à la fois la contraction ventriculaire (permettant l’éjection du sang vers les artères) notamment par le pic en R, dans le même temps, le relâchement des oreillettes entraîne le remplissage de celles-ci en attente d’un nouveau cycle).

L’onde T représente le relâchement des ventricules suite à leur contraction.L’enchaînement de ces complexes permet par ailleurs de déterminer la fréquence 
cardiaque, c’est-à-dire le nombre de cycle cardiaque par unité de temps. Une fréquence cardiaque normale est comprise entre 60 et 100 battements par minute, en 
dessous de cette valeur, le patient est en « bradycardie », au-dessus de cette valeur, le patient est en « tachycardie ».

Les signaux ECG sont contaminés avec différentes sources de bruits. Les bruits de hautes fréquences sont provoqués par l’activité musculaire extracardiaque et les interférences dues aux appareils électriques, et des bruits de basses fréquences provoqués par les mouvements du corps liés à la respiration, les changements physicochimiques induits par l’électrode posée sur la peau et les micro variations du flux sanguin. Le filtrage de ces bruits est une étape très importante pour faire un diagnostic réussi. 

# Suppression du bruit provoqué par les mouvements du corps 

1- Sauvegarder le signal ECG sur votre répertoire de travail, puis charger-le dans Matlab à l’aide la commande load.




