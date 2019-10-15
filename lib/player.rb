#Player class creation

require 'pry'

#Player class with name and life_points in attributes
class Player
 attr_accessor :name
 attr_accessor :life_points

 #name and life_points are initialized at instance creation
 def initialize(name, life_points = 10)
 	@name = name
 	@life_points = life_points
 end

 #puts name and life_points of player
 def show_state
 	puts "#{@name} a #{life_points} points de vie"
 end

 #retrieve damage to player, indicates that player is killed if his life_points get below 0
 def gets_damage(damage)
 	@life_points = @life_points - damage
 	#puts "#{name} subit #{damage} points de dommage"
 	if life_points <= 0 
 		puts "Le joueur #{@name} a été tué !"
 	end
 end

 #retrieve damage to player, indicates that player is killed if his life_points get below 0
 def attacks(player)
 	puts "Le joueur #{@name} attaque le joueur #{player.name}"
 	damage = compute_damage
 	puts "Il lui inflige #{damage} points de dommage"
 	player.gets_damage(damage)
 end

 #return a random integer between 1 and 6
 def compute_damage
 	return rand(1..6)
 end
end

#define HumanPlayer subclass inherited of Player class
class HumanPlayer < Player
	attr_accessor :weapon_level

	#initialize HumanPlayer attributes with 100 lifepoints and weapon_level new attribute
	def initialize(name, life_points = 100, weapon_level = 1)
		@name = name
		@life_points = life_points
		@weapon_level = weapon_level
	end

	#enhanced show_state method for HumanPlayer, displaying weapon_level attribute
	def show_state
		puts "#{@name} a #{life_points} de points de vie et une arme de niveau #{weapon_level}"
	end

	#enhanced compute_damage method for HumanPlayer, damages multiplied by weapon_level
	def compute_damage
		return rand(1..6) * @weapon_level
	end

	#search_weapon method which randomly proposes a new weapon_level between 1 and 6. Select the max between the new and the current weapon 
	def search_weapon
		new_weapon_level = rand(1..6)
		puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
		if new_weapon_level > @weapon_level
			puts "Youhou ! Elle est meilleure que ton arme actuelle : tu la prends."
			@weapon_level = new_weapon_level
		else
			puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
		end
	end

	#search_health_pack method which randomly heals the user with +50 life_points if random result between 2 and 6, +80 life_points if random result == 6, +0 otherwise
	def search_health_pack
		health_pack = rand(1..6)
		if health_pack == 1
			puts "Tu n'as rien trouvé..."
		elsif health_pack >= 2 && health_pack <= 5
			puts "Bravo, tu as trouvé un pack de +50 points de vie"
			@life_points = [100, @life_points + 50].min
		else
			puts "Waow, tu as trouvé un pack de +80 points de vie !"
			@life_points = [100, @life_points + 80].min
		end
	end
end



