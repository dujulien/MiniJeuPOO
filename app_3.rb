require 'bundler'
Bundler.require

#require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/game'

################ The Game ####################

def game
	welcome_message
	my_game = Game.new("Julien")
	i = 1
	while my_game.is_still_ongoing?
		puts "********************* TOUR #{i} *********************"
		puts ""
		my_game.new_player_in_sight
		puts""
		my_game.show_players
		puts""
		my_game.menu
		puts""
		print "> Ton action :"
		choice = gets.chomp.to_s
		my_game.menu_choice(choice)
		if my_game.enemies_in_sight.size > 0
			my_game.enemies_attack
		end
		i = i + 1
	end
	my_game.end_game
end


################ Methods ####################

def welcome_message
puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"
end

game