require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

require('pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new( { 'name' => 'Ben Ghirardani', 'funds' => 100 } )
customer2 = Customer.new( { 'name' => 'Martina Salvi', 'funds' => 100 } )

customer1.save()
customer2.save()

film1 = Film.new( { 'title' => 'Lego Batman', 'price' => 10 } )
film2 = Film.new( { 'title' => 'Wonder Woman', 'price' => 11 } )

film1.save()
film2.save()

ticket1 = Ticket.new( { 'customer_id' => customer1.id, 'film_id' => film1.id } )
ticket2 = Ticket.new( { 'customer_id' => customer2.id, 'film_id' => film1.id } )

ticket1.save()
ticket2.save()


binding.pry
nil