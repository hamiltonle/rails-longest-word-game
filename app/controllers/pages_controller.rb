require_relative '../../lib/longest_word.rb'

class PagesController < ApplicationController

  def initialize
    @grid = Grid.new
  end

  def game
    @gamegrid = @grid.generate_grid(9)
  end

  def score
    attempt = params[:attempt]
    gamegrid2 = params[:gamegrid2].scan(/\w+/)
    start_time = Time.parse(params[:start_time])
    end_time = Time.now

    @gamescore = @grid.run_game(attempt, gamegrid2, start_time, end_time)
  end
end
