require('pg')
require_relative('../db/sql_runner')
require_relative('customer')
require_relative('ticket')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING id"
    film = SQLRunner.run(sql).first
    @id = film['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films where id = #{@id}"
    SQLRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets ON tickets.customer_id = customer_id WHERE film_id = #{@id}"
    return Film.map_items(sql).first
  end

  def self.map_items(sql)
    films = SQLRunner.run(sql)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SQLRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SQLRunner.run(sql)
  end

end