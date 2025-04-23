# frozen_string_literal: true

class Graph
  attr_accessor :data, :children, :parent

  def initialize(data, parent = nil)
    @data = data
    @children = []
    @parent = parent
  end
end
