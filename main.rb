# frozen_string_literal: true

require_relative 'lib/graph'

KNIGHT = [[2, 1], [1, 2], [-1, 2], [-2, 1],
          [-2, -1], [-1, -2], [1, -2], [2, -1]].freeze

def knight_moves(start, target)
  return unless valid_position?(start) && valid_position?(target)
  return [start] if start == target

  root = Graph.new(start)
  target_node = knights_search([root], target)

  path = []
  while target_node
    path << target_node.data
    target_node = target_node.parent
  end

  path.reverse
end

def knights_search(queue, target, visited = [])
  return if queue.empty?

  node = queue.shift

  edges = knight_edges(node)
  not_visited = edges.reject { |obj| visited.include?(obj.data) }

  node.children = not_visited

  not_visited.each do |obj|
    obj.parent = node
    return obj if obj.data == target

    queue   << obj
    visited << obj.data
  end

  knights_search(queue, target, visited)
end

def knight_edges(node)
  curr_file, curr_rank = node.data
  edges = []

  KNIGHT.each do |file, rank|
    new_position = [curr_file + file, curr_rank + rank]
    edges << Graph.new(new_position) if valid_position?(new_position)
  end

  edges
end

def valid_position?(position)
  return false unless position.is_a?(Array) && position.size == 2

  file, rank = position
  file.between?(0, 7) && rank.between?(0, 7)
end

#############################################################################

path = knight_moves([0, 0], [6, 6])
if path.nil?
  puts 'Not a valid input'
else
  puts "knight moves(#{path})"
  puts "You made it in #{path.length - 1} moves! Here's your path:"
  path.each { |square| puts "#{square}" }
end
