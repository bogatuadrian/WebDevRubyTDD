require 'set'

class Cell < Struct.new(:x, :y)
  def +(cell)
    Cell.new(self[:x] + cell[:x], self[:y] + cell[:y])
  end
end

class Directions
  def Directions::getDirections()
    directions = Array.new
    (-1..1).each do |i|
      (-1..1).each do |j|
        directions << Cell.new(i, j) unless i == 0 && j == 0
      end
    end
    directions
  end
end

def get_neighbours(cell)
  directions = Directions::getDirections

  res = Array.new

  directions.each do |d|
    neighbour = cell + d
    res << neighbour if (yield neighbour)
  end

  res
end

=begin
def alive_neighbours(cell, alive_cells)
  directions = Directions::getDirections

  res = Array.new

  directions.each do |d|
    neighbour = cell + d
    res << neighbour if alive_cells[neighbour] == true
  end

  res
end
=end

def direct_surroundings_of(alive_cells)
  neighbours = Array.new
  alive_cells.keys.each do |cell|
    neighbours = neighbours + (get_neighbours(cell) { |k| alive_cells[k] != true })
  end

  neighbours
end

def dead_cells_that_become_alive(alive_cells)
  dead_cells = direct_surroundings_of(alive_cells)
  new_alive_cells = Array.new

  dead_cells.each do |cell|
    neighbours = get_neighbours(cell) { |k| alive_cells[k] == true }

    new_alive_cells << cell if neighbours.count == 3
  end

  new_alive_cells
end

def alive_cells_that_stay_alive(alive_cells)

  new_alive_cells = Array.new

  alive_cells.each do |cell, v|
    neighbours = get_neighbours(cell) { |k| alive_cells[k] == true }

    new_alive_cells << cell if neighbours.count == 2 || neighbours.count == 3
  end

  new_alive_cells
end


def evolve_universe(seed)

  return [].to_set if seed == [].to_set

  alive_cells = Hash.new

  seed.each do |e|
    alive_cells[e] = true
  end


=begin
  res = Array.new
  new_alive_cells.each do |k, v|
    res << k if new_alive_cells[k] == true
  end
=end
  res = alive_cells_that_stay_alive(alive_cells) + dead_cells_that_become_alive(alive_cells)
  res.to_set
end

