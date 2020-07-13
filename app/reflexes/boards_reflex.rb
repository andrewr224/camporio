# frozen_string_literal: true

class BoardsReflex < ApplicationReflex
  def like
    board = Board.find(element.dataset[:id])
    board.increment! :likes_count
  end
end
