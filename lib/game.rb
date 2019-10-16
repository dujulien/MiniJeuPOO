#Player class creation

require 'pry'
require_relative 'player'

#Player class with name and life_points in attributes
class Game
	attr_accessor :human_player
	attr_accessor :enemies

	def initialize(name)
		@human_player = HumanPlayer.new(name)
		@enemies = []
		for i in 1..4 do
			player_i = Player.new("Enemy_#{i}")
			@enemies << player_i
		end
	end

	def kill_player(player)
		@enemies.delete_if{|enemy| enemy == player}
	end

	def is_still_ongoing?
		if @human_player.life_points > 0 && @enemies.size > 0
			return true
		else
			return false
		end
	end

	def show_players
		@human_player.show_state
		puts "Il y a #{@enemies.size} ennemis restants."
	end

	def menu
		puts "Quelle action veux-tu effectuer ?"
		puts ""
		puts "a - chercher une meilleure arme"
		puts "s - chercher à se soigner"
		puts ""
		puts "attaquer un joueur en vue :"
		@enemies.each.with_index {|enemy, i| print "#{i} -" 
		print "#{enemy.show_state}"}
	end

	def menu_choice(choice)
		if choice == "a"
			@human_player.search_weapon
		elsif choice == "s"
			@human_player.search_health_pack
		else
			@enemies.each.with_index {|enemy, i| @human_player.attacks(enemy) if i.to_s == choice}
		end
		@enemies.each.with_index {|enemy, i| self.kill_player(enemy) if enemy.life_points <= 0}
	end

	def enemies_attack
		puts ""
		puts "Les ennemis attaquent !"
		@enemies.each{|enemy| enemy.attacks(@human_player)}
	end

	def end_game
		puts "La partie est finie"
		if @human_player.life_points > 0 
			puts "BRAVO ! TU AS GAGNE !"
		else
			puts "Loser ! Tu as perdu !"
		end
	end

end
