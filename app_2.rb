require 'bundler'
Bundler.require

#require_relative 'lib/game'
require_relative 'lib/player'

################ The Game ####################

def game
	welcome_message
	user = ask_user_name
	enemies = player_inst
	fight(user, enemies)
end

################ Methods ####################
def welcome_message
puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"
end

#Player 1 instantiation
def ask_user_name
	puts "Quel est ton prénom ?"
	name = gets.chomp
	user = HumanPlayer.new(name)
	user.show_state
	puts""
	return user
end

#Instatiation of Josiane and José
def player_inst
	enemies = []
	player1 = Player.new("Josiane")
	enemies << player1
	player2 = Player.new("José")
	enemies << player2
	return enemies
end

#FIGHT
def fight (user, enemies)
	while user.life_points > 0 && !are_all_enemies_dead?(enemies)
		#Display user's and enemies' states
		puts "Voici l'état de chaque joueur :"
		user.show_state
		enemies.each{|enemy| enemy.show_state}
		puts ""
		#Attack phase : display action menu and ask for user input
		puts "Passons à la phase d'attaque"
		show_action_menu(enemies)
		action = input_action
		realize_action(user, action, enemies)
		puts ""
		#Enemies strike back : each enemy attacks the user if not all enemies are dead
		if !are_all_enemies_dead?(enemies)
			puts "Les autres joueurs t'attaquent !"
			enemies.each{|enemy| enemy.attacks(user) if enemy.life_points > 0}
			puts ""
		end
	end
	end_of_game(user)
end

#Action Menu display
def show_action_menu(enemies)
	puts "Quelle action veux-tu effectuer ?"
	puts ""
	puts "a - chercher une meilleure arme"
	puts "s - chercher à se soigner"
	puts ""
	puts "attaquer un joueur en vue :"
	print "0 - "
	print "#{enemies[0].show_state}"
	print "1 - "
	print "#{enemies[1].show_state}"
end

#Input action from user. Must be a, s, 0 or 1
def input_action
	print "> Ton action :"
	action = gets.chomp.to_s
	puts ""
	while !(action == "a" || action == "s" || action == "0" || action == "1")
	puts "Erreur de saisie ! Choisis une entrée entre a, b, 0 ou 1 !"
	action = gets.chomp.to_s
	end
	return action
end

#Realize the action according to the action menu
def realize_action(user, action, enemies)
	if action == "a"
		user.search_weapon
	elsif action == "s"
		user.search_health_pack
	elsif action == "0"
		user.attacks(enemies[0])
	else 
		user.attacks(enemies[1])
	end
end

#Method to determine if all enemies are dead
def are_all_enemies_dead?(enemies)
	all_dead = true
	enemies.each do |enemy|
		if enemy.life_points > 0
			all_dead = false
			break
		end
	end
	return all_dead
end

#End of game message
def end_of_game(user)
	puts "La partie est finie"
	if user.life_points > 0 
		puts "BRAVO ! TU AS GAGNE !"
	else
		puts "Loser ! Tu as perdu !"
	end
end

################ Launch game ####################

game

################ End of file ####################



