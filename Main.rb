require "./Player.rb"
require "./GameController.rb"

puts "Please enter player 1's name"
input = gets.chomp
player1 = Player.new(input)
puts "Please enter player 2's name"
input = gets.chomp
player2 = Player.new(input)
controller = GameController.new(player1,player2)
controller.startGame()