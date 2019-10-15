#Compilation file of classes and methods stored in lib directory

# lignes très pratiques qui appellent les gems du Gemfile. On verra plus tard comment s'en servir ;) - ça évite juste les "require" partout
require 'bundler'
Bundler.require

# lignes qui appellent les fichiers lib/user.rb et lib/event.rb
# comme ça, tu peux faire User.new dans ce fichier d'application. Top.
require_relative 'lib/player'

#######COMBATS###########################

#Instantiate player 1 and player 2
player1 = Player.new("Josiane")
player2 = Player.new("José")
#puts "Voici l'état de chaque joueur :"

# #Show states of player 1 and player 2
# player1.show_state
# player2.show_state
# puts ""
# puts "Passons à la phase d'attaque"
# puts""

#Attacks begin
while player1.life_points > 0 && player2.life_points > 0
puts ""
puts "Voici l'état de chaque joueur :"
player1.show_state
player2.show_state
puts ""
puts "Passons à la phase d'attaque"
player1.attacks(player2)
	if player2.life_points < 0
		break
	end
player2.attacks(player1)
end

#binding.pry