#!/bin/sh
nouveau_joueur() # La fonction nouveau_joueur qui parmet de creer un nouveau joueur
{
	cd Joueur # Acceder au dossier Joueur
	read -p "Entrez votre nom : " nom
	# Chaque joueur va posseder son propre fichier
	if [ -e $nom ] # Si le nom entré par le joueur existe on fait le traitement suivant
	then
		read -p "Le nom existe déja ! Tapez m pour revenir au menu :  " t
			while [ $t != "m" ]; do
				read -p "Le nom existe déja ! Tapez m pour revenir au menu :  " t
			done
			if [ $t = "m" ]; then
				
			
				cd $PWD/.. # on revient dans le dossier MasterMind
				clear
				menu # On appelle la fonction menu pour afficher le menu
			fi

	 else # Si le nom saisie ne figure pas dans le dossier Joueur on fait le traitement suivant
		# Remplir les autres informations du joueur (mot de passe et description)
		read -p "Entrez votre mot de passe : " mdp 
		read -p "Entrez votre description : " desc
		# On crée le fichier du joueur nommé par son nom qui contient ses informations
		touch $nom | echo "nom:$nom" >> $nom
		touch $nom | echo "motdepasse:$mdp" >> $nom
		touch $nom | echo "description:$desc" >> $nom
		# On va creer un répértoire nommé par le nom du joueur dans le répertoire Historique 
		cd $PWD/../Historique # Acceder au dossier Historique
		mkdir $nom # Création du répertoire du joueur
		cd $PWD/$nom # On accede au répertoire du joueur
		# On va creer deux répertoires : 
		# Vainqueur : Va contenir les parties vaincu
		# En_cours : Va contenir les parties en cours sauvegardé
		mkdir Vainqueur En_cours 
		cd $PWD/../.. # Revenir dans le répertoire MasterMind
		# On affiche un message de bienvenue
		read -p "Bienvenue Mr $nom ! Tapez m pour revenir au menu : " t
		while [ "$t" != "m" ]; do
			read -p "Bienvenue Mr $nom ! Tapez m pour revenir au menu : " t
		done
		if [ "$t" = "m" ]; then
			menu
		fi
	fi

	# Acceder au répertoire En_cours du joueur
	cd $PWD/Historique/$nomidentif/En_cours
	# Lister les parties sauvegardé
	echo "Les parties sauvegardé sont : "
	ls
	# Choisir la partie sauvegardé
	read -p "Choisi la partie que tu veux rejouer : " rjchoix
	 if [ -e "$rjchoix" ];then # Si le nom choisi existe dans le répertoire En_cours
		# On copie le fichier choisie dans le fichier Sauvegarde
		cp $PWD/$rjchoix $PWD/../../../Sauvegarde
		# Revenir dans MasterMind
		cd $PWD/../../..
		# Affichage des lettres du tirage
		echo "Les mots de tirage de la dernière partie sont : `cat Sauvegarde | head -1`"
		# La variable va prend les lettres du tirage
		va=`cat Sauvegarde | head -1 | nl`
}
     cpreesayer()
     {
     # Afficher le message de félicitation
     read -p "Félicitation vous avez gagné choisi un nom pour sauvgarder cette partie gagné : " gagne
     # On accede au répertoire Vainqueur

     touch $PWD/Historique/$nomidentif/Vainqueur/gagne
     if [ -e "$gagne" ];then # Si le nom tapé existe
	# On affiche le message
	read -p "Le nom deja existe / Tapez m(menu) r(reesayer) " t
	if [ "$t" = "r" ];then		
		cd $PWD/../../..
		cpreesayer
	fi
	if [ "$t" = "m" ];then
		clear
		cd $PWD/../../..
		menu
	fi
      else # Si le nom n'existe pas
	# On revient a MaxiPoints
	cd $PWD/../../..
	# On copie le fichier Sauvegarde dans un nouveau fichier $gagne dans le répertoire Vainqueur
	cp $PWD/Sauvegarde $PWD/Historique/$nomidentif/Vainqueur/$gagne
	# On vide le fichier Sauvegarde
	rm Sauvegarde 
	touch Sauvegarde 		
fi
clear 
menu
}

else # Si le nom choisi n'existe pas dans le répertoire En_cours
		# Afficher le message
		read -p "Tapez m(menu) r(reesayer) " t
		if [ "$t" = "r" ];then
			clear
			cd $PWD/../../..
			charger_partie
		fi
		if [ "$t" = "m" ];then
			clear
			cd $PWD/../../..
			menu
		fi
fi
}
desabonner() # Cette fonction permet au joueur de se désabonner
{
	cd $PWD/Joueur # Acceder au répertoire Joueur
	rm $nomidentif # Supprimer son fichier
	cd $PWD/../Historique # Acceder au répertoire Historique
	rm -R $nomidentif # Supprimer le répertoire du joueur 
	cd $PWD/.. # Revenir dans MaxiPoints
	identif="faux" # La variable identif est faux car le joueur est désabonné 
	clear
	menu
}
vainqueur()
{
	# On accede au répertoire Vainqueur
	cd $PWD/Historique/$nomidentif/Vainqueur
	# On liste les parties gagnés
	echo "Les parties gagnés sont : "
	ls
	# Le joueur choisi la partie qui veut voir
	read -p "Choisi la partie que tu veux voir : " choix
	if [ -e "$choix" ];then # Si le choix existe
		# Afficher la partie gagné
		cat $choix
		# Revenir dans MaxiPoints
		cd $PWD/../../..
		# Message pour revenir au menu
		read -p "Tapez m pour revenir au menu " t 
		if [ $t = "m" ]
		then
			clear
			menu
		fi
	else # Si le choix n'existe pas
		read -p "Le nom n'existe pas / Tapez m(menu) r(reesayer) " t
		if [ "$t" = "r" ];then
			# Revenir dans MasterMind
			cd $PWD/../../..
			# Appeler la fonction vainqueur
			vainqueur
		fi
		if [ "$t" = "m" ];then
			clear
			cd $PWD/../../..
			menu
		fi
	fi
}
jeu() # La fonction jeu qui permet au joueur de jouer
{
	# debut de fonction jeu
	
echo "jeu"
read -p  "Tapper un level (1) ou (2) Ou (m) pour revenir au menu principal "  level

jeu
  
  
Saisircombi()
{
read -p "Entrez votre code secret Ou Tappez (m) pour revenir au menu principal " codejoueur
 if [ $codejoueur = "m" ]; then
 touch Sauv
 echo $strrandom $tenta > $PWD/Historique/$nomidentif/En_cours/Sauv
 echo $strrandom $tenta > $PWD/Historique/$nomidentif/En_cours/Sauv
    

	menu

     else
	 #echo ${#codejoueur}

	 touch tmpstr

	 echo $codejoueur > $PWD/tmpstr
	 ssddf=${#codejoueur}
	

	 gyf=`grep -io [abcdefghijklmnopqrstuvwxyz] tmpstr | wc -l` 

	 if [ "$taille" = "$ssddf" ]
          then	
		   if [ $taille -eq  $gyf ]
			 then
				echo "^_^"
		       else
			  Saisircombi
		      
		
             fi  
	     fi
fi
}


afficheplateau()
{
	bienplace=0
	malplace=0

	if [ $taille -eq 4 ]; then
		#statements
	
		ch1=$(echo "$codejoueur" | cut -c1)
		ch2=$(echo "$codejoueur" | cut -c2)
		ch3=$(echo "$codejoueur" | cut -c3)
		ch4=$(echo "$codejoueur" | cut -c4)

		

		if [ "$ch1" = "$h1" ]; then
		 bienplace=$(($bienplace + 1))
		else
         malplace=$(($malplace + 1))
		fi
		if [ "$ch2" = "$h2" ]; then
			bienplace=$(($bienplace + 1))
		else
			malplace=$(($malplace + 1))
		fi
		if [ "$ch3" = "$h3" ]; then
			bienplace=$(($bienplace + 1))
		else
			malplace=$(($malplace + 1))
		fi
		if [ "$ch4" = "$h4" ]; then
			bienplace=$(($bienplace + 1))
		else
			malplace=$(($malplace + 1))
		fi
		echo "bienplace : $bienplace , malplace : $malplace"

	fi 

	if [ $taille -eq 5 ]; then
		ch1=$(echo "$codejoueur" | cut -c1)
		ch2=$(echo "$codejoueur" | cut -c2)
		ch3=$(echo "$codejoueur" | cut -c3)
		ch4=$(echo "$codejoueur" | cut -c4)
		ch5=$(echo "$codejoueur" | cut -c5)

		h1=$(echo "$strrandom" | cut -c1)
		h2=$(echo "$strrandom" | cut -c2)
		h3=$(echo "$strrandom" | cut -c3)
		h4=$(echo "$strrandom" | cut -c4)
		h5=$(echo "$strrandom" | cut -c5)
		


fi
}
testcombi(){
afficheplateau
}
tenta=0
win=0
while [ $tenta -lt 10 ]
do
	if [ "$bienplace" = "$taille" ]; then
		win=1
		break 

	fi
tenta=$(($tenta + 1))
echo " Tentative $tenta"




Saisircombi
testcombi
done


if [ $win -eq 1 ]; then
echo "  "

else
	echo "You Lose ; Try Again "
	sleep 0.1
	echo " Le code secret est  $strrandom "
	sleep 0.1
	echo "tappez (m) pour revenir au Menu principal"
	read k
    while [ "$k" != "m" ]; do
    	echo "tappez (m) pour revenir au Menu principal"
    	read k
    done
	if [ "$k" = "m" ]; then
		menu
	fi
fi
if [ $identif = "vrai" ];then  # Si le joueur n'est pas identifié
		# On accede au répertoire Vainqueur du joueur identifié 
		cd $PWD/Historique/$nomidentif/Vainqueur
		# (`ls | wc -l` -eq 0)  teste si le répertoire est vide
		if [ `ls | wc -l` -eq 0 ]; then # S'il est vide
			cd $PWD/../../..
			# On revient dans MaxiPoints
			clear
			# Afficher le message pour revenir au menu
			read -p "Aucun partie vaincu / Tapez m pour revenir au menu : " t
			if [ $t = "m" ]
			then
				clear
				menu
			fi
		else # S'il n'est pas vide
			# On revient dans MaxiPoints
			cd $PWD/../../..
		clear

############################################################################vvvvvv
# On donne au joueur le droit d'écrire le nom de la partie vaincu a sauvegarder 
# Si le nom de la partie vaincu existe déjà la fonction reesayer donne au joueur d'écrire un autre nom 
reesayer() 
{
	# Afficher le message de félicitation
	read -p "Félicitation vous avez gagné choisi un nom pour sauvgarder cette partie gagné : " gagne
	# On accede au répertoire Vainqueur
	cd $PWD/Historique/$nomidentif/Vainqueur
	if [ -e "$gagne" ];then # Si le nom tapé existe 
		# On affiche le message
		read -p "Le nom deja existe / Tapez m(menu) r(reesayer) " t
		if [ "$t" = "r" ];then		
			cd $PWD/../../..
			reesayer
		fi
		if [ "$t" = "m" ];then
			clear
			cd $PWD/../../..
			menu
		fi
	else # Si le nom n'existe pas
		# On revient a MasterMind
		cd $PWD/../../..
		# On copie le fichier Sauvegarde dans un nouveau fichier $gagne dans le répertoire Vainqueur
		cp $PWD/Sauvegarde $PWD/Historique/$nomidentif/Vainqueur/$gagne
		# On vide le fichier Sauvegarde
		rm Sauvegarde 
		touch Sauvegarde 
	fi
	clear 
menu
}
reesayer
}
sauvegarde()
{	
	# On donne la main au joueur de nommer la partie qui veut sauvegarder pour la charger une autre fois
	read -p "Entrez le nom de la partie que tu veux sauvegarder : " partie 
	# Acceder au répertoire En_cours du joueur identifié
	cd $PWD/Historique/$nomidentif/En_cours
	# Si le nom de la partie qui veut sauvegarder existe
	if [ -e "$partie" ];then
		# Il a deux possibilités : soit revenir au menu ou reesayer un autre nom :
		read -p "Le nom deja existe / Tapez m(menu) r(reesayer) " t
		# Pour reesayer
		if [ "$t" = "r" ];then
			clear
			cd $PWD/../../..
			sauvegarde
		fi
		# Pour revenir au menu
		if [ "$t" = "m" ];then
			clear
			cd $PWD/../../..
			menu
		fi
	else 
		
		
		clear 
		read -p "Partie sauvegardé avec succès ! Tapez m pour revenir au menu " t
		if [ "$t" = "m" ];then
			clear
			menu
		fi
	fi
}
menu() # La fonction menu permet d'afficher le menu au joueur
{
clear
# Pour donner une décoration au jeu on fait le traiement suivant :
# Pour afficher cette décoration on a utilisé la commande 'figlet' et sleep
 echo "   __  ___              __               __  ___ _             __"

echo "   /  |/  /____ _ _____ / /_ ___   _____ /  |/  /(_)____   ____/ /"
echo "  / /|_/ // __ // ___// __// _ \ / ___// /|_/ // // __ \ / __  /"
echo " / /  / // /_/ /(__  )/ /_ /  __// /   / /  / // // / / // /_/ /"
echo "/_/  /_/ \__,_//____/ \__/ \___//_/   /_/  /_//_//_/ /_/ \__,_/
"
echo "  "
echo "  "
	# Afficher les choix au joueur
	echo "Choisissez l'une des options suivantes :"
	echo "/****************************************************************/"
	echo "[1]-Créer un nouveau joueur                                      /"
	echo "[2]-S'identifier (Pour les joueurs éxistants)                    /"
	sleep 0.05
	echo "[3]-Lancer une nouvelle partie (Pour les joueurs identifié(e)s)  /"
	sleep 0.05
	echo "[4]-Sauvegarder la partie courante                               /"
	sleep 0.05
	echo "[5]-Charger une partie sauvegardée                               /"
	sleep 0.05
	echo "[6]-Se désabonner du jeu                                         /"
	sleep 0.05
	echo "[7]-Quitter le jeu                                               /"
	sleep 0.05
	echo "/****************************************************************/"
	sleep 0.05
	# Le joueur choisi une option
	read -p "[X] = " opt
	# Chaque option a un traitment
	case $opt in
	"1")
	clear
	echo "          ----------------------------------------------------"
	echo "     	  |                   Nouveau compte                 |"
	echo "   	  ------------------------------------------------------"
	echo "  "
	nouveau_joueur
	;;
	"2")
	clear
	echo "          ----------------------------------------------------"
	echo "     	  |                   Authentification               |"
	echo "   	  ------------------------------------------------------"
	echo "  "
	identifier
	;;
	"3") 
		# On a utilisé la variable gloabal identif pour tester si le joueur est identifié ou non
		if [ $identif = "vrai" ];then # Si le joueur est identifié 
			clear
				echo "          ----------------------------------------------------"
				echo "     	  |                   Partie en cours                |"
				echo "   	  ------------------------------------------------------"
				echo "  "
				# Pour lancer une nouvelle partie il faut que le fichier Sauvegarde soit vide
				# Le traitement suivant vide la fichier Sauvegarde
				rm Sauvegarde
				touch Sauvegarde
				sv=0 
			jeu
		else # Si le joueur n'est pas identifié
			clear
			# Pour revenir au menu
			read -p "Identifiez-vous d'abord ! / Tapez m pour revenir au menu : " t
			if [ $t = "m" ]
				then
				clear
			menu
			fi
		fi
	;;
	"4")
	if [ $identif = "vrai" ];then # Si le joueur est identifié 
		
		# Si le fichier Sauvegarde est vide alors le joueur n'a pas joué aucune partie
		# `cat Sauvegarde | wc -c` -eq 0 permet de tester si le fichier Sauvegarde est vide
		if [ `cat Sauvegarde | wc -c` -eq 0 ]; then # Si il est vide
			clear
			# Pour revenir au menu
			read -p "Il faut au moins jouer une partie / Tapez m pour revenir au menu : " t
			while [ "$t" != "m" ]; do

				read -p "Il faut au moins jouer une partie / Tapez m pour revenir au menu : " t
			done
			if [ "$t" = "m" ]; then
				clear
				menu
			fi
		else # S'il n'est pas vide (au moins une partie joué) 
		clear
		echo "          ----------------------------------------------------"
		echo "     	  |                   Sauvegarder                    |"
		echo "   	  ------------------------------------------------------"
		echo "  "
		sauvegarde
	   fi
	else # SI le joueur n'est pas identifié
		clear
		# Pour revenir au menu
		read -p "Identifiez-vous d'abord ! / Tapez m pour revenir au menu : " t
		while [ "$t" != "m" ]; do

				read -p "Identifiez-vous d'abord ! / Tapez m pour revenir au menu : " t
			done
			if [ "$t" = "m" ]; then
				clear
				menu
	       fi
	   fi
	;;	
	"5")
		if [ $identif = "vrai" ];then # Si le joueur est identifié
			# On accede au répertoire En_cours du joueur
			cd $PWD/Historique/$nomidentif/En_cours
			# (`ls | wc -l` -eq 0) teste si le répertoire est vide 
			if [ `ls | wc -l` -eq 0 ]; then # S'il est vide
				cd $PWD/../../..
				# On revient dans Master Mind
				clear
				# Et on affiche un message pour revenir au menu
				read -p "Aucun partie sauvegardé / Tapez m pour revenir au menu : " t
				while [ "$t" != "m" ]; do

				read -p "Aucun partie sauvegardé / Tapez m pour revenir au menu : " t
			done
			if [ "$t" = "m" ]; then
				clear
				menu
	        fi
			else # S'il n'est pas vide
				# On revient dans Master Mind
				cd $PWD/../../..
			clear
			echo "          ----------------------------------------------------"
			echo "     	  |                   Charger partie                 |"
			echo "   	  ------------------------------------------------------"
			echo "  "
			charger_partie
			fi
		else # Si le joueur n'est pas identifié 
			clear
			# On affiche un message pour revenir au menu
			read -p "Identifiez-vous d'abord ! / Tapez m pour revenir au menu : " t
			while [ "$t" != "m" ]; do

				read -p "Identifiez-vous d'abord ! / Tapez m pour revenir au menu : " t
			done
			if [ "$t" = "m" ]; then
				clear
				menu
		fi
	fi
	;;

	"6")
		if [ $identif = "vrai" ];then # Si le joueur est identifié
			clear
			echo "          ----------------------------------------------------"
			echo "     	  |                   Désabonner                     |"
			echo "   	  ------------------------------------------------------"
			echo "  "
			# Afficher le message de confirmation
			read -p "Voulez-vous vraiment se désabonner ? (o/n) : " t
			if [ $t = "o" ];then # Si oui
				desabonner
			elif [ $t = "n" ]; then # Si non
				clear
				menu
			fi
		else # Si le joueur n'est pas identifié
			clear
			# Afficher le message pour revenir au menu
			read -p "Identifiez-vous d'abord ! / Tapez m pour revenir au menu : " t
			if [ $t = "m" ]
			then
				clear
				menu
			fi
		fi
	;;
	
	"7") # Pour quitter le jeu
	quitter 
	;;
	*) # Si le joueur tape une option incorrecte on réaffiche le menu
	clear 
	menu
esac
}
quitter()
{
	clear
	echo "          ----------------------------------------------------"
	echo "     	  |                       Quitter                    |"
	echo "   	  ------------------------------------------------------"
	echo "  "
	# On affiche un message de confirmation
	read -p "Voulez-vous vraiment quitter le jeu ? (o/n) : " t
	if [ $t = "o" ];then # Si oui
		clear
		exit
	elif [ $t = "n" ]; then # Si non
		clear
		menu
	fi
}
# Lorsque le jeu est lancé aucun joueur n'est identifié donc on initialise on affecte à identif la valeur faux
identif="faux"
# tan rj3o liha
i=0
# Lorsque le jeu est lancé le fichier Sauvegarde doit être vide
rm Sauvegarde 
touch Sauvegarde
# Le 1 er appelle de menu 
clear
menu