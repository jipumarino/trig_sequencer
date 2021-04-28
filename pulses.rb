bpm = 20
ppqn = 384
last_step = ppqn*4-1
pulses_per_bar = (last_step + 1).to_f
total_max_diff = 0

puts "@MySetAllPulses"
puts "  for i = 0 to 1000"
puts "    pulses1[i] = 0"
puts "    pulses2[i] = 0"
puts "  endfor"
puts ""
puts "  for i = 0 to 2"
puts "    v = trigs[i]"


(1..16).each do |denominator|
  orig_arr = 0.step(last_step, pulses_per_bar / denominator).to_a
  round_arr = orig_arr.map(&:round)
  max_diff_pulse = round_arr.zip(orig_arr).map{|x,y| x-y}.map{|d| d.abs}.max
  max_diff_sec = max_diff_pulse * (60*4/bpm)/pulses_per_bar
  total_max_diff = max_diff_sec if max_diff_sec > total_max_diff

  if denominator == 1
    puts "    if v = #{denominator}"
  else
    puts "    elseif v = #{denominator}"
  end

  round_arr.each do |p|
    puts "      pulse = #{p}"
    puts "      call @MyAddPulse"
  end
end

puts "    endif"
puts "  endfor"
puts "@End"

puts "\n\n\n----------------------------------\nMax diff: #{total_max_diff*1000} milliseconds"
