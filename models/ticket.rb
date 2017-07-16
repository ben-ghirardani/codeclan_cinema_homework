require('pg')
require_relative('../db/sql_runner')
require_relative('customer')
require_relative('film')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{film_id}) RETURNING id"
    ticket = SQLRunner.run(sql).first
    @id = ticket['id'].to_i
  end

  def delete()
    sql = "DELETE FROM tickets where id = #{@id}"
    SQLRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SQLRunner.run(sql)
  end

  def self.all()
    sql = ' SELECT * FROM tickets'
    tickets = sql_runner.run(sql)
    return tickets.map { |ticket| Ticket.new(ticket) }
  end

end