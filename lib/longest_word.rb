require 'open-uri'
require 'json'

LINK_BEG = "https://api-platform.systran.net/translation/text/translate?input="
LINK_END = "&source=en&target=fr&key=1507b565-9dba-4938-8090-2712679f7a87"

class Grid

  def initialize
  end

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    random_grid = []

    (1..grid_size).each do
      random_grid << ('A'..'Z').to_a.sample
    end

    random_grid
  end

  def run_game(attempt, grid, start_time, end_time)
    # TODO: runs the game and return detailed hash of result
    result = {}
    fr_translation = parse_json(attempt)
    result[:time] = game_time(start_time, end_time)
    # score = score(attempt) / result[:time].round(4)
    score = score(attempt)


    if (grid & attempt.upcase.split("")).sort != attempt.upcase.split("").sort
      game_result(fr_translation, 0, "not in the grid", result[:time])
    elsif attempt == fr_translation then
      game_result(nil, 0, "not an english word", result[:time])
    else
      game_result(fr_translation, score, "well done", result[:time])
    end
  end

  def game_result(user_translation, user_score, user_message, time)
    result = {}

    result[:time] = time
    result[:translation] = user_translation
    result[:score] = user_score
    result[:message] = user_message

    return result
  end

  def parse_json(user_input)
    # FRENCH TRANSLATION****************************************
    input = LINK_BEG + user_input + LINK_END
    translation_serialized = open(input).read
    parsed_translation = JSON.parse(translation_serialized)
    return parsed_translation["outputs"][0]["output"]
  end

  def game_time(start_time, end_time)
    total_time = end_time - start_time
    puts total_time
    return total_time
  end

  def score(user_input)
    # FRENCH TRANSLATION****************************************
    input = LINK_BEG + user_input + LINK_END
    translation_serialized = open(input).read
    parsed_translation = JSON.parse(translation_serialized)

    characters = (parsed_translation["outputs"][0]["stats"]["nb_characters"])
    return characters
  end
end
# run_game("train", %w(W G G Z O N A L), Time.now, Time.now + 1.3432)
# run_game("apdsfsd", %w(W G G Z O N A L), Time.now, Time.now + 2.846)
# run_game("computer", %w(C O M P U T E R), Time.now, Time.now + 3.5345)
# run_game("china", %w(W G G Z O N A L), Time.now, Time.now + 2.323)

# p generate_grid(9)


# The Systran API might stop to respond at some point
# (too much requests from you guys!). Try to implement a fallback strategy
# where you rescue the error,
# and look at the built-in dictionary (English-only):

# words = File.read('/usr/share/dict/words').upcase.split("\n")



