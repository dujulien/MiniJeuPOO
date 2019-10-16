#Player class creation

require 'pry'
require_relative 'player'

#Player class with name and life_points in attributes
class Game
	attr_accessor :human_player
	#attr_accessor :enemies
	attr_accessor :player_left #new attributes
	attr_accessor :enemies_in_sight #new attributes

	def initialize(name, player_left = 10)
		@human_player = HumanPlayer.new(name)
		@player_left = player_left
		@enemies_in_sight = []
		#for i in 1..4 do
		#	player_i = Player.new("Enemy_#{i}")
		#	@enemies_ << player_i
		#end
	end

	def new_player_in_sight
		if @player_left == 0
			puts "Tous les joueurs sont déjà en vue."
		else
			dice = rand(1..6)
			if dice == 1
				puts "Aucun joueur n'arrive..."
			elsif dice >= 2 && dice <= 4
				@enemies_in_sight << Player.new("Enemy_#{rand(1..9999)}")
				@player_left += -1
				puts "Un ennemi apparaît en vue !"
			elsif dice >= 5
				if @player_left >= 2
					2.times do 
						@enemies_in_sight << Player.new("Enemy_#{rand(1..9999)}")
					end
					@player_left += -2
					puts "2 ennemis apparaîssent en vue !"
				else
					@enemies_in_sight << Player.new("Enemy_#{rand(1..9999)}")
					@player_left += -1
					puts "Un ennemi apparaît en vue !"
				end
			end
		end
	end

	def kill_player(player)
		@enemies_in_sight.delete_if{|enemy| enemy == player}
	end

	def is_still_ongoing?
		if @human_player.life_points > 0 && (@player_left + enemies_in_sight.size) > 0
			return true
		else
			return false
		end
	end

	def show_players
		@human_player.show_state
		puts "Il y a #{@player_left + @enemies_in_sight.size} ennemis restants."
	end

	def menu
		puts "Quelle action veux-tu effectuer ?"
		puts ""
		puts "a - chercher une meilleure arme"
		puts "s - chercher à se soigner"
		puts ""
		puts "attaquer un joueur en vue :"
		@enemies_in_sight.each.with_index {|enemy, i| print "#{i} - " 
		print "#{enemy.show_state}"}
	end

	def menu_choice(choice)
		if choice == "a"
			@human_player.search_weapon
		elsif choice == "s"
			@human_player.search_health_pack
		else
			@enemies_in_sight.each.with_index {|enemy, i| @human_player.attacks(enemy) if i.to_s == choice}
		end
		@enemies_in_sight.each.with_index {|enemy, i| self.kill_player(enemy) if enemy.life_points <= 0}
	end

	def enemies_attack
		puts ""
		puts "Les ennemis attaquent !"
		@enemies_in_sight.each{|enemy| enemy.attacks(@human_player) if @human_player.life_points > 0}
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
