require('pg')
require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ( '#{@name}', #{@funds}) RETURNING id"
    customer = SQLRunner.run(sql).first
    @id = customer['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers where id = #{@id}"
    SQLRunner.run(sql)
  end

  def films()
    sql = "SELECT films.* FROM films
          INNER JOIN tickets ON tickets.film_id = film_id WHERE customer_id = #{@id}"
    return Film.map_items(sql).first
  end

  def self.map_items(sql)
    customers = SQLRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SQLRunner.run(sql)
    return customers.map { |person| Customer.new(person) }
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SQLRunner.run(sql)
  end


end