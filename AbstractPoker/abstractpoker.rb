
MAX_BOUND = 1000

class Fixnum
  def of_a_kind(poker_hand)
    # returns how many self-tuples are in a hand
    counter = {}
    poker_hand.each do |x|
      if counter[x] == nil
        counter[x] = 1
      else
        counter[x] += 1
      end
    end

    counter.select { |k, v| v == self }.count
  end
end


def straight(poker_hand)
  sorted_poker_hand = poker_hand.sort

  count = 0
  max_count = 0
  (sorted_poker_hand.count - 1).times do |i|
    count = 0 unless sorted_poker_hand[i] + 1 == sorted_poker_hand[i + 1]
    count += 1 if sorted_poker_hand[i] + 1 == sorted_poker_hand[i + 1]

    if count > max_count
      max_count = count
    end
  end

  max_count + 1
end

def is_high_card?(poker_hand)
  count = straight(poker_hand)
  count == 4 || count == 3
end

def straight?(poker_hand)
  straight(poker_hand) == 5
end

def one_pair?(poker_hand)
  2.of_a_kind(poker_hand) == 1
end

def two_pairs?(poker_hand)
  2.of_a_kind(poker_hand) == 2
end

def three_of_a_kind?(poker_hand)
  3.of_a_kind(poker_hand) == 1
end

def four_of_a_kind?(poker_hand)
  4.of_a_kind(poker_hand) == 1
end

def full_house?(poker_hand)
  one_pair?(poker_hand) && three_of_a_kind?(poker_hand)
end

def classify_poker_hand(poker_hand)

  return :not_a_ruby_array unless poker_hand.is_a? Array
  return :too_many_or_too_few_cards unless poker_hand.count == 5
  return :at_least_one_card_is_not_an_integer unless poker_hand.select { |x| !x.is_a?(Integer) }.empty?
  return :at_least_one_card_is_out_of_bounds  unless poker_hand.select { |x| x > MAX_BOUND }.empty?
  return :impossible_hand if 5.of_a_kind(poker_hand) > 0

  return :four_of_a_kind  if four_of_a_kind?(poker_hand)
  return :full_house      if full_house?(poker_hand)
  return :straight        if straight?(poker_hand)
  return :three_of_a_kind if three_of_a_kind?(poker_hand)
  return :two_pairs       if two_pairs?(poker_hand)
  return :one_pair        if one_pair?(poker_hand)
  return :high_card       if is_high_card?(poker_hand)

  return :valid_but_nothing_special

end

