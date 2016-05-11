# Each character takes 8 pixels
# Each line has 800 pixels
# 1 pixel buffer between characters in a word
# 2 pixel buffer between each word
require 'pry-byebug'
def lineate_pixel_text(line_size, chr_size, chr_buffer, word_buffer, paragraph)
  words_arr = paragraph.split(' ')
  pixels_remaining = 0
  lineated_text = []
  for i in (0...words_arr.length)
    word = words_arr[i]
    curr_word_space = calculate_pixels(chr_size, chr_buffer, word)
    next_word_space = calculate_pixels_next_word(chr_size, chr_buffer, words_arr[i+1], word_buffer)
    if(pixels_remaining >= curr_word_space + next_word_space)
      pixels_remaining -= word_buffer + curr_word_space
      lineated_text[-1] += " " + word
    elsif(pixels_remaining >= curr_word_space)
      pixels_remaining -= curr_word_space
      lineated_text[-1] += " " + word
    else
      pixels_remaining = line_size - curr_word_space
      lineated_text.push(word)
    end
  end
  lineated_text
end

def calculate_pixels(chr_size, chr_buffer, word)
  num_chars = word.length
  num_chars*chr_size + (num_chars-1)*chr_buffer
end

def calculate_pixels_next_word(chr_size, chr_buffer, word, word_buffer)
  return 0 unless word
  word_buffer + calculate_pixels(chr_size, chr_buffer, word)
end

# test methods

def calculate_line_length(lines)
  lines.map do |line|
    line.chars.inject(0) do |sum, char|
      char == " " ? (sum + 1) : (sum + 8 + 1)
    end - 1
  end
end

paragraph = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non neque suscipit, porta turpis ut, pellentesque velit. Donec hendrerit finibus ullamcorper. In vitae gravida metus. Proin id massa libero. Nulla fringilla pretium eros id tincidunt. Phasellus in risus varius, tempor massa et, consequat nibh. Maecenas convallis dui sem, non lobortis augue ornare vel. Nulla volutpat urna dui, sed pretium lacus ullamcorper sit amet. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam vitae leo et lacus tincidunt consequat id quis turpis. In leo nibh, accumsan et massa non, porta tincidunt ligula. Etiam malesuada placerat nibh ut pretium. Praesent quis faucibus eros, a porttitor enim. Vivamus egestas elit non sapien malesuada dignissim."

lines= lineate_pixel_text(800, 8, 1, 2, paragraph)
p lines
p calculate_line_length(lines)