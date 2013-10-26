
def compute_row(n)
  return [] if n < 1
  return [1] if n == 1

  curr = []
  n.times do
    result = []
    curr.inject(0) do |acc, x|
      result << (x + acc)
      x
    end
    result << 1
    curr = result
  end

  curr
end

__END__

1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
1 5 10 10 5 1
