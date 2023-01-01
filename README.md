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

>Commentaires : Il est à remarquer que ce TP traite en principe des signaux continus. Or, l'utilisation de Matlab suppose l'échantillonnage du signal. Il faudra donc être vigilant par rapport aux différences de traitement entre le temps continu et le temps discret.
>Tracé des figures : toutes les figures devront être tracées avec les axes et les légendes des axes appropriés.
>Travail demandé : un script Matlab commenté contenant le travail réalisé et descommentaires sur ce que vous avez compris et pas compris, ou sur ce qui vous a semblé intéressant ou pas, bref tout commentaire pertinent sur le TP.

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
```matlab
clear all 
close all
clc 

%exporter le fichier au matlab
load('ecg.mat');
%garder dans un variable
A=ecg;
```
2- Ce signal a été échantillonné avec une fréquence de 500Hz. Tracer-le en fonction du temps,  

```matlab
%caluculer la taille
N=length(A);
%nbr de 
fs=500;
Te=1/F;
t =[0:Te:(N-1)*Te];
% taracage du fct
title(" sig ECG");
plot(t,A);

```

<img width="781" alt="eee" src="https://user-images.githubusercontent.com/89936910/210170558-06a308a8-c728-4788-bbf8-e39db38115db.png">

>puis faire un zoom sur une période du signal.

<img width="782" alt="33333" src="https://user-images.githubusercontent.com/89936910/210170607-eaa8a809-d673-4b70-bf8f-19639b8caa7b.png">

3- Pour supprimer les bruits à très basse fréquence dues aux mouvements du corps,on utilisera un filtre idéal passe-haut. Pour ce faire, calculer tout d’abord la TFD du signal ECG, régler les fréquences inférieures à 0.5Hz à zéro, puis effectuer une TFDI pour restituer le signal filtré. 

```matlab
%le spectre Amplitude
 y = fft(A);
 f = (0:N-1)*(fs/N);
 fshift = (-N/2:N/2-1)*(fs/N);

%TFD
subplot(2,2,2)
plot(fshift,fftshift(abs(y)))
title("spectre Amplitude")

%spectre Amplitude centré


%suppression du bruit des movements de corps

h = ones(size(A));
fh = 0.5;
index_h = ceil(fh*N/fs);
h(1:index_h)=0;
h(N-index_h+1:N)=0;

%TFDI pour restituer le signal filtré
ecg1_freq = h.*y;
ecg1 =ifft(ecg1_freq,"symmetric");
subplot(211)
plot(t,ecg);

```
4- Tracer le nouveau signal ecg1

```matlab
plot(t,ecg1);
title("ecg1")

```
<img width="781" alt="hhh" src="https://user-images.githubusercontent.com/89936910/210171272-81b47334-ee5d-43a2-8c49-1360c861d64c.png">

 >et noter les différences par rapport au signal d’origine. 
 
 ```matlab
plot(t,A-ecg1);
title("La différence")

```

 <img width="782" alt="QQQ" src="https://user-images.githubusercontent.com/89936910/210171406-ac3be1c9-0000-4324-8456-d5148ca13498.png">

# Suppression des interférences des lignes électriques 50H

>Souvent, l'ECG est contaminé par un bruit du secteur 50 Hz qui doit être supprimé.

5. Appliquer un filtre Notch idéal pour supprimer cette composante. Les filtres Notch sont utilisés pour rejeter une seule fréquence d'une bande de fréquence donnée.

```matlab
% Elimination interference 50Hz
 
Notch = ones(size(A));
fcn = 50;
index_hcn = ceil(fcn*N/fs)+1;
Notch(index_hcn)=0;
Notch(index_hcn+2)=0;

ecg2_freq = Notch.*fft(ecg1);
ecg2 =ifft(ecg2_freq,"symmetric");
subplot(211)
plot(t,ecg);
xlim([0.5 1.5])
title("signal filtré")
subplot(212)
plot(t,ecg2);
xlim([0.5 1.5])

```
<img width="790" alt="HHHHHH" src="https://user-images.githubusercontent.com/89936910/210171515-c7c20eb9-4c91-444e-af70-68690c5e684e.png">
